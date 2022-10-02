import 'dart:convert';
import 'dart:math';

import 'package:MechGesture/models/garage/garageModel.dart';
import 'package:MechGesture/models/garage/sub_models/ImagesModel.dart';
import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';
import 'package:MechGesture/models/garage/sub_models/addressModel.dart';
import 'package:MechGesture/models/garage/sub_models/contactsModel.dart';
import 'package:MechGesture/models/garage/sub_models/ownerDetailsModel.dart';
import 'package:MechGesture/models/garage/sub_models/timingModel.dart';
import 'package:MechGesture/models/orderModel.dart';
import 'package:MechGesture/models/ourUser.dart';
import 'package:MechGesture/services/database.dart';
import 'package:MechGesture/values/Constants.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MechGesture/models/garage/sub_models/timingModel.dart';

class CurrentState extends ChangeNotifier {
  /// This class will contain the information about the user if he is loged in or not
  /// and if the user is logged in then the date of the user will be in this class
  final _auth = FirebaseAuth.instance;

  // ignore: deprecated_member_use
  List<OurGarage> garagesList = List<OurGarage>();

  OurUser currentUser = OurUser();
  SharedPreferences _prefs;
  String _inputText;
  Color customColor = MyColors.pureblack;
  bool disableButton = true;
  String phoneNo, smsSent, _verificationId;
  Dio dio = new Dio();
  double totalAmount = 0;
  List<MechanicServices> selectedProducts = [];
  String selectedBrand;
  String vehicleType; // car , bike, rickshaw, truck
  String description = " ";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isScreenDisable = false;
  OurGarage singleGarage;

  // this list will contain all the data regarding the current Orders of the user
  List<OrderModel> currentOrders = List<OrderModel>();


  Box userBox;

  ///  ------------------------------------------- The section of the user login goes here -----------------------------------------------------------------------///

  // this function checks if the user was logged in or not
  Future<String> onStartUpAPI() async {
    //currentUser.uid = _auth.currentUser.uid;
    //print(currentUser.uid);
    _prefs = await SharedPreferences.getInstance();
    var th = await _auth.currentUser.getIdToken();
    //_auth.signOut();
    //setLocalData();
    print("Inside the start function");
    String retVal = "error";
    try {
      //_prefs.get
      if (_prefs.getString("uid") != null) {
        retVal = "success";
        print(_prefs.getString("uid"));
      } else {
        retVal = "error"; // Navigate the user to the login page / splash screen
      }
    } catch (e) {
      print(e);
      retVal = "error";
    }
    return retVal;
  }


  Future<String> onStartUp2() async{
    String retVal = "not";
    userBox = await Hive.openBox("User");
    //
    //
    try{
      currentUser = await userBox.get("user") as OurUser;
      //print(currentUser.email);
      //print(currentUser.toMap());
      retVal = "success";
      //print(currentUser.phone);
      // if(currentUser.phone != null) {
      //   retVal = "login";
      // }

    }catch(e) {
      print("===============");
      print(e);
      retVal = "not";
      //print(currentUser.email);
    }
    //print(currentUser.email);
    print(retVal);
    return retVal;
    print(currentUser.email);
    //await saveAllData();
  }
  validator(String input) {
    _inputText = "+91" + input;
    print(_inputText);
    if (input.length < 10) {
      disableButton = true;
      if (customColor == Colors.red) {
        print("Do nothing");
      } else {
        print("notifying the listeneers");
        customColor = Colors.red;
        notifyListeners();
      }
      //return "Invalid Phone number";
    } else {
      disableButton = false;
      customColor = MyColors.pureblack;
      notifyListeners();
    }
  }

  Future<void> login(context) async {
    print(_inputText);
    disableButton = true;

    print("this function is being called");

    // PhoneVerificationCompleted verificationCompleted = (
    //     PhoneAuthCredential phoneAuthCredential) async {
    //   print("Step 1");
    //   //await _auth.signInWithCredential(phoneAuthCredential);
    // };
    final PhoneVerificationCompleted verifiedSuccess =
        (PhoneAuthCredential phoneAuthCredential) {

      print("the verification is successfull");
      //Navigator.of(context).pushNamed(context, "/verify");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      disableButton = false;
      print(authException);
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceCodeResent]) async {
      print("the code has been sent to your mobile");
      _verificationId = verificationId;
      Navigator.pushNamed(context, "/verify");

      // Here we have to navigate the user to the otp entering page
      // Navigator.of(context).push(MaterialPageRoute(
      //   //builder: (context) => OtpScreen(),
      // ));
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      print("Inside the try ");
      print(_inputText);
      await _auth.verifyPhoneNumber(
        phoneNumber: _inputText,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  verifyOtp(String input, context) async {
    String retVal = "error";
    OurUser _user = OurUser();
    print(input);
    final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: input);
    try {
      //  await _auth.signInWithCredential(credential);
      UserCredential _authResult = await _auth.signInWithCredential(credential);

      // Here i have to save the details of the user in the database
      if (_authResult.additionalUserInfo.isNewUser) {
        currentUser.uid = _authResult.user.uid;
        currentUser.phone = _inputText;
        currentUser.type = "Customer";

        retVal = await OurDatabase().createUser(currentUser);
      } else {
        // get the information of the user from the database this already exists
        currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
        if(currentUser!= null) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/homescreen", (route) => false);
        }
      }
      print("End of the await");

      // when signup with the otp
      if (retVal == "success") {
        print("why not inside this mane");
        Navigator.pushNamedAndRemoveUntil(
            context, "/homescreen", (route) => false);
      }

      saveAllData();
    } catch (e) {
      print(e);
      print("Something went wrong");
      //prin
    }
  }



  Future<String> checkPhone() async{
    String retVal = "error";
    // code that will check if the user already exists in the database or not
    DocumentSnapshot _docSnapshot = await _firestore.collection("usersPhone").doc("phone").get();

    print(_docSnapshot);

    return retVal;
  }

  Future<String> updateUserData(Map update) async{
    String _retval =  await OurDatabase().updateUserData(currentUser.uid,update);
    return _retval;
  }

  // this functions will be in contact with the backend
  Future<String> _checkUser(String uid, String input) async {
    print(uid);
    print(input);
    String _retVal = "error";
    // contact with the backedn and then decide if the user is new or old

    try {
      var value = await dio.post(
          "https://mechgesture.herokuapp.com/loginRoutes/checkUser",
          data: {
            "phoneNumber": _inputText,
            "gid": uid,
          },
          options: Options(contentType: Headers.jsonContentType));

      print(value.data);

      if (value.data["success"] == true) {
        print("Inside this if sta");
        currentUser.uid = uid;
        await setLocalData();
        _retVal = "success";
      }
    } catch (e) {
      print(e);
      _retVal = "error";
    }
    return _retVal;
  }

  // this function will create the order for the user
  Future<String> order({var shopData}) async{
    isScreenDisable = true;
    notifyListeners();
    String _retVal = "error";
    Map order = {
      "10000000": {
        "userUID": "sbfjdsfgbdsndgosd",
        "shopUID": "sdfgiodshghdsoijgsjdgegs",
      }
    };
    int min = 10000; //min and max values act as your 6 digit range
    int max = 99999;
    var randomizer = new Random();
    int otp = min + randomizer.nextInt(max - min);
    List orderProducts = [];

    //
    // bool active = true;
    // while(active) {
    //   int maxO = 1000000000;
    //   int minO = 9999999999;
    //   int orderId = min + randomizer.nextInt(max-min);
    //   try{
    //     _firestore.collection('currentOrder').doc(orderId.toString()).get().then((value) {
    //
    //     });
    //   } catch(e) {
    //     active = false;
    //   }
    // }
    //
    //
    try{
      selectedProducts.forEach((element) {
        orderProducts.add({
          "name": element.name,
          "price": element.price,
        });
      });
      final shakti = await _firestore.collection('currentOrder').doc();
      String orderId = shakti.id;

      List<Future> futures = [];
      await shakti.set({
        'id': orderId,
        "userUID": "sdghsiogsdoijgjds",
        "shopUID": shopData.uid,
        'shopname': shopData.name,
        'services': orderProducts,
        "charges": {
          "totalPrice": totalAmount,
          "totalpickup": "50",
          "additionalCharges": "100",
        },
        //'total price': '',
        'otp': otp,
        'pickup': true,
        'vehicleName': '',
        'vehicleBrand': selectedBrand,
        'vehicleType': vehicleType,
        'address': {'address': "", 'pincode': ''},
        'UserPhone': "9041842831",
        'time':DateTime.now(),
        'empName': null,
        'empUID':null,
        'stage':'1',
      });

      /// this will have 4 stages
      /// stage 1 the order is placed
      /// stage 2 the order is accepted and an employee has been assigned
      /// stage 3 the order is completed success
      /// stage 4 some error occured and the order is not completed

      await _firestore.collection("garages").doc(shopData.uid).update({
        'currentOrder':FieldValue.arrayUnion([orderId]),
      }).then((value) => print('i have done my work'));

      await _firestore.collection("users").doc(currentUser.uid).update({
          'order' : FieldValue.arrayUnion([orderId])
      }).then((value) => print("The value is also added to the users document"));
      _retVal = "success";
      isScreenDisable = false;
    } catch(e) {
      isScreenDisable = false;
      print(e);
    }
    isScreenDisable = false;

    notifyListeners();
    return _retVal;
  }


  /// Fetch the details of all the current orders of the user ///
  Future<String> currentOrdersFetch() async{

    print("Inside this functiuon man");
    String retVal = "error";
    List orderIds = [];
    try{
      print("Inside the try block to get the ids of the order now --------------------------------------------------------");
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").doc(currentUser.uid).get();
      if(_docSnapshot.data()["order"] != null) {
        orderIds = _docSnapshot.data()["order"];
        // print("==================================");
        // print("==================================");
        // print(orderIds);
        // print(orderIds);
        // //print(orderIds);
        // print("==================================");

        //retVal = "success";

        //print(currentOrders);
        retVal = await detailsCurrentOrders(orderIds);
        //print(currentOrders);

      }
      else{
        retVal = "empty";
      }

    } catch(e) {

      print("something went teribly wrong man check it out");
      print(e);
    }
    print("Exiting this function now man sorry for this ");
    notifyListeners();
    return retVal;
  }


  /// After the order ids are recived now we have to fetch the details about the currentOrders -------------///
  Future<String> detailsCurrentOrders(List orderIds) async {

    currentOrders.clear();
    String retVal = "erorr";
    try{
      await Future.forEach(orderIds, (element) async{
        DocumentSnapshot _docSnapshot =  await _firestore.collection("currentOrder").doc(element).get();
        // TODO : add the data to the list that will contain the models of the current orders of the user
        // print(_docSnapshot.data());
        // print(_docSnapshot.data()["shopname"]);
        // print(_docSnapshot.data()["services"]);
        List<MechanicServices> products = [];

        _docSnapshot.data()['services'].forEach((ele) {
          products.add(MechanicServices(
            name: ele["name"],
            price: ele["price"],
            id: _docSnapshot.data()["shopUID"],
            selected: true,
          ));
        });
        // this will just fetch the details of the order of the user now from this
        // i have to fetch the details of the shop itself and then display the data of the
        // shop on the screen
        currentOrders.add(
            OrderModel(
              orderId: _docSnapshot.data()["id"],
              address: _docSnapshot.data()["address"],
              shopName: _docSnapshot.data()['shopname'],
              shopUID: _docSnapshot.data()["shopUID"],
              servicesOrder: products,
              employeeName: _docSnapshot.data()["empName"],
              employeeUID: _docSnapshot.data()['empUID'],
              orderTime: _docSnapshot.data()['time'].toDate(),
              otp: _docSnapshot.data()['otp'].toString(),
              charges: _docSnapshot.data()['charges'],
              pickup: _docSnapshot.data()['pickup'],
              userPhone: currentUser.phone,
              vehicleBrand: _docSnapshot.data()['vehicleBrand'],
              vehicleName: _docSnapshot.data()['vehicleName'],
              vehicleType:_docSnapshot.data()['vehicleType'],

              //orderTime: _docSnapshot.data()[""]
            )
        );
      });
      // orderIds.forEach((element) async{
      //   DocumentSnapshot _docSnapshot =  await _firestore.collection("currentOrder").doc(element).get();
      //   // TODO : add the data to the list that will contain the models of the current orders of the user
      //   // print(_docSnapshot.data());
      //   // print(_docSnapshot.data()["shopname"]);
      //   // print(_docSnapshot.data()["services"]);
      //   List<MechanicServices> products = [];
      //
      //   _docSnapshot.data()['services'].forEach((ele) {
      //     products.add(MechanicServices(
      //       name: ele["name"],
      //       price: ele["price"],
      //       id: _docSnapshot.data()["shopUID"],
      //       selected: true,
      //     ));
      //   });
      //   // this will just fetch the details of the order of the user now from this
      //   // i have to fetch the details of the shop itself and then display the data of the
      //   // shop on the screen
      //   currentOrders.add(
      //     OrderModel(
      //       orderId: _docSnapshot.data()["id"],
      //       address: _docSnapshot.data()["address"],
      //       shopName: _docSnapshot.data()['shopname'],
      //       shopUID: _docSnapshot.data()["shopUID"],
      //       servicesOrder: products,
      //       employeeName: _docSnapshot.data()["empName"],
      //       employeeUID: _docSnapshot.data()['empUID'],
      //       orderTime: _docSnapshot.data()['time'].toDate(),
      //       otp: _docSnapshot.data()['otp'].toString(),
      //       charges: _docSnapshot.data()['charges'],
      //       pickup: _docSnapshot.data()['pickup'],
      //       userPhone: currentUser.phone,
      //       vehicleBrand: _docSnapshot.data()['vehicleBrand'],
      //       vehicleName: _docSnapshot.data()['vehicleName'],
      //       vehicleType:_docSnapshot.data()['vehicleType'],
      //
      //       //orderTime: _docSnapshot.data()[""]
      //     )
      //   );
      //
      //   if(currentOrders.length == orderIds.length) {
      //     notifyListeners();
      //   }
      //   retVal = "success";
      // });
    }catch(e) {
      print("Something went really really wrong man");
      print(e);
    }

    print("Exiting the functionthat gets the detais of the oirdere ================");
    print(currentOrders.length);
    return retVal;
  }



  saveAllData() async{

    try{
      await userBox.put("user", currentUser);

    } catch(e) {
      print(e);
    }
    print("Entering this function now ");
  }
  // var myMap = Map<String, dynamic>.from(data); alternative forEach

  /// --------------------------------------------- The section of the user login ends here --------------------------------------------------------///

  /// --------------------------------------------- API CALLS FOR FETCHING DATA INTO APPLICATION LIKE GARAGES AND ALL -----------------------------///

  /// --------------------------------------------- NOT IN USE AT THE MOMENT---------------------------- ///
  Future fetchData() async {
    garagesList.clear();
    //List someThings = [];
    try {
      //http.Response response;
      List allResponses;
      var response = await dio.get(
          Constants.URL + "/garage?type=$vehicleType&brand=$selectedBrand");
      print(response.data);
      if (response.statusCode == 200) {
        //allResponses = json.decode(response.data);
        allResponses = response.data;
        print(allResponses.length);
        allResponses.forEach((element) {
          // print(element["garageDetails"]);
          // print(element["garageDetails"]["timing"]);
          // print(element["garageDetails"]["timing"]["open"]);
          // print(element["garageDetails"]["timing"]["close"]);
          // print(element["garageDetails"]["timing"]["close"]["hours"]);
          // print(element["garageDetails"]["name"]);
          // print(element["garageDetails"]["establishedIn"]);
          // print(element["garageDetails"]["images"]["profileImg"]);
          List<MechanicServices> products = [];
          element["garageDetails"]["products"].forEach((ele) {
            products.add(MechanicServices(
              name: ele["name"],
              price: ele["price"],
              id: element["garageDetails"]["uid"],
              selected: false,
            ));
          });
          print("==============================================");
          print("==============================================");
          print("==============================================");
          print("==============================================");
          print(products);
          garagesList.add(OurGarage(
            uid: element["garageDetails"]["uid"],
            products: products,
            name: element["garageDetails"]["name"],
            establishedYear: element["garageDetails"]["establishedIn"],
            aboutUs: element["garageDetails"]["aboutUs"],
            status: element["garageDetails"]["status"],
            type: element["garageDetails"]["type"],
            openTime: TimingModel(
                hours: element["garageDetails"]["timing"]["open"]["hours"]
                    .toString(),
                minutes: element["garageDetails"]["timing"]["open"]["minutes"]
                    .toString()),
            closeTime: TimingModel(
                hours: element["garageDetails"]["timing"]["close"]["hours"]
                    .toString(),
                minutes: element["garageDetails"]["timing"]["close"]["minutes"]
                    .toString()),
            images: ImagesModel(
              profileImages: element["garageDetails"]["images"]["profileImg"],
              carosuelImgs: element["garageDetails"]["images"]["carouselImages"],
            ),
            address: AddressModel(
              city: element["garageDetails"]["address"]["city"],
              lat: element["garageDetails"]["address"]["coordinates"]["lat"],
              long: element["garageDetails"]["address"]["coordinates"]["lon"],
              shopNo: element["garageDetails"]["address"]["shopNo"],
              state: element["garageDetails"]["address"]["state"],
              pincode: element["garageDetails"]["address"]["pincode"],
              street: element["garageDetails"]["address"]["street"],
            ),
            contacts: ContactsModel(
              email: element["garageDetails"]["contact"]["email"],
              phone: element["garageDetails"]["contact"]["phone"],
              tel: element["garageDetails"]["contact"]["tel"],
            ),
            ownerDetails: OwnerDetailsModel(
              gender: element["garageDetails"]["ownerDetails"]["gender"],
              age: element["garageDetails"]["ownerDetails"]["age"],
              title: element["garageDetails"]["ownerDetails"]["name"]["title"],
              firstName: element["garageDetails"]["ownerDetails"]["name"]
                  ["firstName"],
              lastName: element["garageDetails"]["ownerDetails"]["name"]
                  ["lastName"],
            ),
            vehiclesServices: element["garageDetails"]["services"],
          ));
          //products.clear();
        });
        print("=============================");
        print("=============================");
        print(garagesList.length);
        print(garagesList[0].name);
        //mapResponse = listResponse[0];
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  /// ----------------------------------------------- NOT IN USE AT THE MOMENT ---------------------///

  // Future<String> fetchDataFirebase() async{
  //   garagesList.clear();
  //   try{
  //     garagesList = await OurDatabase().fetchGarages();
  //     if(garagesList != null) {
  //
  //     }
  //
  //   }catch(E){
  //     print(E);
  //   }
  // }

  Future<String> fetchParticularGarages() async {
    garagesList.clear();
    try {
      garagesList = await OurDatabase().fetchIds(vehicleType, selectedBrand);
    } catch (E) {
      print(E);
    }
  }


  /// ----------------- Fetch a single garage to use ----------------------------------------- ///

  Future<String> fetchSingleGarageDetails(List uid) async {
    List<OurGarage> garagesListLocal = List<OurGarage>();

    try{
      garagesListLocal = await OurDatabase().fetchGarages(uid);
      singleGarage = garagesListLocal[0];
      print(garagesListLocal);
    }catch(E) {
      print(E);
    }
    notifyListeners();

  }



  addServicesToList({bool local, MechanicServices data, String id}) async {
    totalAmount = 0;

    if (local == true) {
      if (selectedProducts.isEmpty) {
        selectedProducts.add(data);
        totalAmount = data.price;
      } else {
        if (selectedProducts[0].id == data.id) {
          print("The id is amtcehfc");
          selectedProducts.add(data);
          selectedProducts.forEach((element) {
            totalAmount += element.price;
          });
        } else {
          selectedProducts.clear();
          selectedProducts.add(data);
          totalAmount = data.price;
        }
      }
    } else {
      if (selectedProducts.isNotEmpty) {
        if (selectedProducts[0].id == data.id) {
          if (selectedProducts.contains(data)) {
            selectedProducts.remove(data);
            selectedProducts.forEach((element) {
              totalAmount += element.price;
            });
          }
        } else {
          selectedProducts.clear();
          totalAmount = 0;
        }
      }
    }
    print(selectedProducts);
    notifyListeners();
  }

  // this will save the authentication token locally and then
  // the user can make request with that token -- not in use at the moment
  saveTokenLocally() async {
    String retVal = "error";
    try {
      print("this that is inside the setLocaldataFunctions");
      //_prefs.setString("name", currentUser.fullName);
      //_prefs.setString("uid", currentUser.uid);
      _prefs.setString("name", "Deepak");
      _prefs.setString("authToken", currentUser.uid);
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  /// The code for the phone verification of the user will go here

  Future<String> onStartUp() async {
    _prefs = await SharedPreferences.getInstance();
    print("Inside the start function");
    String retVal = "error";
    try {
      if (_prefs.getString("email") != null) {
        retVal = "success";
        print(_prefs.getString("email"));
      } else {
        retVal = "error"; // Navigate the user to the login page / splash screen
      }
    } catch (e) {
      print(e);
      retVal = "error";
    }
    return retVal;
  }

  Future<String> loginUserWithGoogle() async {
    String retVal = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      print("Enter inng sngne =========================");
      //OurUser _user = OurUser();
      // The first line sign the user into their google account
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      //These create the google account on firebase for us
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential _authResult = await _auth.signInWithCredential(credential);

      currentUser.uid = _authResult.user.uid;
      currentUser.phone = _authResult.user.phoneNumber;
      currentUser.fullName = _authResult.user.displayName;
      currentUser.email = _authResult.user.email;
      currentUser.profileImg = _authResult.user.photoURL;
      currentUser.type = "customer";
      currentUser.gender = "";
      currentUser.houseNo = "";
      currentUser.street = "";
      currentUser.city = "";
      currentUser.state = "";
      currentUser.pincode = "";
      currentUser.orders = [];
      currentUser.dob = null;

      if (_authResult.additionalUserInfo.isNewUser) {

        print("this is a new user so make an account for ");
        print("this is tha ");
        OurDatabase().createUser(currentUser);
      }else {

        print("this is an old user so lets welcome him/her");
        // get the information of the user from the database this already exists
        currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
        print(currentUser.toMap());
        print("-------------------------------------------");
      }
      await saveAllData();
      //_currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
      print("Above the uid---------------");
      print(currentUser);
      if (currentUser != null) {
        retVal = "success";
      }
    } catch (e) {
      retVal = "something went wrong";
      print(
          "Entering the catch block in the google signin function===========");
      print(e);
    }
    //print(retVal);
    return retVal;
  }

  Future<String> setLocalData() async {
    //_prefs = await SharedPreferences.getInstance();
    String retVal = "error";
    try {
      print("this that is inside the setLocaldataFunctions");
      //_prefs.setString("name", currentUser.fullName);
      _prefs.setString("uid", currentUser.uid);
      //_prefs.setString("email", currentUser.email);
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  // to signout the user
  Future<String> signOut() async {
    String retVal = "error";
    try {
      // The FirebaseUser have been changed to the User
      await _auth.signOut();
      // _currentUser.uid = null;
      // _currentUser.email = null;
      currentUser =
          OurUser(); // new instance of the user to wipe the previous data
      retVal = "success";
      _prefs.clear(); // deleting all local data
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
