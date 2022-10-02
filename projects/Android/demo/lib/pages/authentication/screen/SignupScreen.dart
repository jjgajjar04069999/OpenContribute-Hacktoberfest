import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/pages/HomePage/HomeScreen.dart';
import 'package:MechGesture/pages/authentication/widgets/button.dart';
import 'package:MechGesture/pages/authentication/widgets/header.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:MechGesture/values/MyColors.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var isCustomerSelected = true;
  var loading = false;
  final _formKey = GlobalKey<FormState>();
  var pass = TextEditingController();
  var email = TextEditingController();
  var name = TextEditingController();

  void _formSubmit(BuildContext ctx) async {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    print('enter');
    print('${email.text.trim()}    ${pass.text.trim()}');

    final isvalid = _formKey.currentState.validate();
    final _auth = FirebaseAuth.instance;

    _formKey.currentState.save();
    FocusScope.of(ctx).unfocus(); //closes keyboard
    print('${email.text.trim()}    ${pass.text.trim()}');
    try {
      if (isvalid) {
        setState(() {
          loading = true;
        });
        // String retVal = await _instance.signUpUser(
        //     email: email.text.trim(),
        //     password: pass.text.trim(),
        //     name: name.text,
        //     type: isCustomerSelected ? 'Customer' : 'Mechanic');
        // if (retVal == "success") {
        //   // the whole process was successful ready to roll
        //   loading = false;
        //   Navigator.of(context).pushNamed('/homescreen');
        // } else {
        //   setState(() {
        //     loading = false;
        //   });
        //   // show the snack bar to the user here
        //   // _scaffoldKey2.currentState.showSnackBar(
        //   //   SnackBar(
        //   //       duration: Duration(seconds: 1),
        //   //       content: Text(retVal),
        //   //   ),
        //   // );
        //   Fluttertoast.showToast(
        //       msg: retVal,
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.blue,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }
        // await _auth.createUserWithEmailAndPassword(
        //     email: email.text.trim(), password: pass.text.trim());
        //
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(_auth.currentUser.uid)
        //     .set(
        //   {
        //     'name': name.text.trim(),
        //     'email': email.text.trim(),
        //     'user is': isCustomerSelected ? 'Customer' : 'Mechanic',
        //   },
        // );

      }
    } catch (error) {
      print(error);
      var mes = "Invalid Credentials";
      setState(() {
        loading = false;
      });

      //add a snackbar here

    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey2,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 20),
          child: Column(
            children: [
              //header
              Stack(
                children: [
                  Container(
                    width: width,
                    height: height / 3.3 > 260 ? 280 : height / 3.3,
                    padding: EdgeInsets.only(
                      left: width > 360 ? 20 : 10,
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/signupTop.png"),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: height > 700 ? 90 : 60,
                          //right: width > 360 ? 20 : 10,
                          left: width > 360 ? 25 : 15,
                          child: Text('Create \n Account',
                              style: MyTextStyle.heading1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height > 360 ? 10 : 5,
                  right: width > 360 ? 20 : 10,
                  left: width > 360 ? 20 : 10,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     left: width > 360 ? 20 : 10,
                      //   ),
                      //   child: Text('Create \n Account',
                      //       style: MyTextStyle.heading1),
                      // ),
                      // SizedBox(
                      //   height: height / 16,
                      // ),
                      TextFormField(
                        controller: name,
                        style: MyTextStyle.text2,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: MyColors.blue_ribbon,
                          ),
                          labelText: 'Name',
                          labelStyle: MyTextStyle.text1,
                        ),
                        onChanged: (text) {
                          // do something with text
                        },
                      ),
                      TextFormField(
                        controller: email,
                        style: MyTextStyle.text2,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: MyColors.blue_ribbon,
                          ),
                          labelText: 'Email address',
                          labelStyle: MyTextStyle.text1,
                        ),
                        validator: (value) {
                          if (value.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          // do something with text
                        },
                      ),
                      TextFormField(
                        controller: pass,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: MyColors.blue_ribbon,
                          ),
                          labelText: 'Password',
                          labelStyle: MyTextStyle.text1,
                        ),
                        style: MyTextStyle.text2,
                        validator: (value) {
                          if (value.isEmpty || value.length <= 6) {
                            return 'Password is too short. 7 characters required!!';
                          }
                          return null;
                        },
                        obscureText: true,
                        onChanged: (text) {
                          // do something with text
                        },
                      ),
                      SizedBox(
                        height: height / 70,
                      ),
                      !loading
                          ? GestureDetector(
                              onTap: () {
                                //closes keyboard
                                _formSubmit(context);
                              },
                              child: Button(
                                text: "Sign Up",
                                color: 1,
                              ),
                            )
                          : CircularProgressIndicator(),
                      SizedBox(
                        height:
                            height / 30, // Use the same height after 'Or text'
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: MyColors.divider_color,
                              thickness: 2.0,
                              endIndent: 11.0,
                            ),
                          ),
                          Text(
                            'OR',
                            style: MyTextStyle.heading2,
                          ),
                          Expanded(
                            child: Divider(
                              color: MyColors.divider_color,
                              thickness: 2.0,
                              indent: 14.0,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          // take the user to the login page
                          //Navigator.of(context, MaterialPageBuilder())
                          //Navigator.of(context).pushNamed('/singupPage');
                          String retVal = await _instance.loginUserWithGoogle();
                          if (retVal == "success") {
                            Fluttertoast.showToast(
                                msg: retVal,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          } else {
                            Fluttertoast.showToast(
                                msg: retVal,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Button(
                          text: "Continue with google",
                          iconPath: 'assets/images/icons/Google.png',
                          color: 2,
                        ),
                      ),
                      //Spacer(flex:2),

                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed('/loginPage'),
                        child: Button(
                          text: "Log in",
                          color: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  if (_formKey.currentState.validate()) {
//                 // text in form is valid
//               }
