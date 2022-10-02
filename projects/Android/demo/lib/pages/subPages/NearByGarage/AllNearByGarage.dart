import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/data/data.dart';
import 'package:MechGesture/pages/HomePage/widgets/SearchBox.dart';
import 'package:MechGesture/pages/ShopPages/shopPage.dart';
import 'package:MechGesture/pages/ShopPages/widgets/shimmerAnimation.dart';
import 'package:MechGesture/pages/subPages/NearByMechanics/AllNearByMechanics.dart';
import 'package:MechGesture/pages/subPages/widgets/GarageContent/garageListTileCustom.dart';
import 'package:MechGesture/pages/subPages/widgets/GarageContent/garageListTileUpdated.dart';
import 'package:MechGesture/services/database.dart';
import 'package:MechGesture/values/Constants.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AllNearByGarage extends StatefulWidget {
  @override
  _AllNearByGarageState createState() => _AllNearByGarageState();
}

class _AllNearByGarageState extends State<AllNearByGarage> {
  List listResponse;
  Map mapResponse;
  double current_latitude;
  double current_longitude;
  Future data;
  SharedPreferences _prefs;

  double garage_lat;
  double garage_lon;

  double distanceInMeters;

  getLocationData() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      try {
        // currentAddress = _prefs.getString("currentAddress");
        current_latitude = _prefs.getDouble('current_latitude');
        current_longitude = _prefs.getDouble("current_longitude");
      } catch (e) {
        print(e);
      }
    });

    print("Latitude--> " + current_latitude.toString());
    print("Longitude --> " + current_longitude.toString());
  }

  // print("Latitude--> " + current_latitude.toString());
  // print("Longitude --> " + current_longitude.toString());

  // Future fetchData() async {
  //   try {
  //     http.Response response;
  //     response = await http.get(Constants.URL + "/garage");
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         listResponse = json.decode(response.body);
  //         mapResponse = listResponse[0];
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    // TODO: implement initState
    data = _instance.fetchParticularGarages();
    super.initState();
    //fetchData();

    getLocationData();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  var typeSelected = [true, false, false]; //car, truck, motorcycle respectively
  var sortSelected = [true, false]; //nearest, farthest respectively

  void _showFilters(double w) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), //this right here
            child: Container(
              height: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: Icon(
                          Icons.close_sharp,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type',
                          style: MyTextStyle.headingTitle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    typeSelected[0] = !typeSelected[0];
                                  });
                                },
                                child: FilterButton(
                                  text: 'Car',
                                  status: typeSelected[0],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    typeSelected[1] = !typeSelected[1];
                                  });
                                },
                                child: FilterButton(
                                  text: 'Truck',
                                  status: typeSelected[1],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    typeSelected[2] = !typeSelected[2];
                                  });
                                },
                                child: FilterButton(
                                    status: typeSelected[2],
                                    text: 'Motorcycle'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Sort',
                          style: MyTextStyle.headingTitle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sortSelected[0] = !sortSelected[0];
                                  });
                                },
                                child: FilterButton(
                                  text: 'Nearest',
                                  status: sortSelected[0],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sortSelected[1] = !sortSelected[1];
                                  });
                                },
                                child: FilterButton(
                                    status: sortSelected[1], text: 'Farthest'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: w * 0.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Color(0xffEFEFEF),
                          ),
                          child: Center(
                              child: Text('RESET', style: MyTextStyle.text3)),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: w * 0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                              color: MyColors.darkishBlue,
                            ),
                            child: Center(
                                child: Text('APPLY', style: MyTextStyle.text4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    // OurDatabase().fetchGarages();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text("Nearby shops", style: MyTextStyle.appBarTextSupporting),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => AllNearByGarage(),
              transitionDuration: Duration(seconds: 1),
              maintainState: true,
            ),
          );
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              bottom: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                SearchBox(),
                Padding(
                  padding: EdgeInsets.only(left: 13, right: 13, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Results",
                        style: MyTextStyle.headingTitle,
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        color: MyColors.lightBlack,
                        onPressed: () {
                          var w = MediaQuery.of(context).size.height / 3 + 50;
                          _showFilters(w);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Filters",
                          style: MyTextStyle.filter,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Consumer<CurrentState>(
                    builder: (context, _, Widget child) {
                      return FutureBuilder(
                          future: data,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Text("loading.....");
                              case ConnectionState.waiting:
                                return ShimmerForCategories(
                                    size.height / 5.2, size.width - 20);
                              case ConnectionState.done:
                                //return
                                if (_instance.garagesList != null &&
                                    _instance.garagesList.isNotEmpty) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      //print(listResponse.length);
                                      //for (; index < listResponse.length;) {
                                      //   garage_lat = listResponse[index]['garageDetails']
                                      //       ['address']["coordinates"]['lat'];
                                      //   garage_lon = listResponse[index]['garageDetails']
                                      //       ['address']["coordinates"]['lon'];
                                      //   distanceInMeters = Geolocator.distanceBetween(
                                      //       current_latitude,
                                      //       current_longitude,
                                      //       garage_lat,
                                      //       garage_lon);
                                      //if (distanceInMeters < 2000) {
                                      //OurDatabase().createSampleData(_instance.garagesList[index]);
                                      distanceInMeters = 0;
                                      //print(listResponse[index]);
                                      return GestureDetector(
                                        onTap: () {
                                          print(_instance
                                              .garagesList[index].products);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShopPage(
                                                        allData: _instance
                                                            .garagesList[index],
                                                      )));
                                        },
                                        child: Container(
                                          width: 100,
                                          padding: EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: OurGarageListTileUpdated(
                                            distanceAway: distanceInMeters,
                                            name: _instance
                                                .garagesList[index].name
                                                .toString(),
                                            //sendToFunction: garageList[index],
                                            type: _instance
                                                .garagesList[index].type
                                                .toString(),
                                            vehicleServices: _instance
                                                .garagesList[index]
                                                .vehiclesServices,
                                            profileImage: _instance
                                                .garagesList[index]
                                                .images
                                                .profileImages[0],
                                            status: _instance
                                                .garagesList[index].status,
                                          ),
                                        ),
                                      );
                                      //}
                                      // else {
                                      //   return Container(
                                      //     child: Center(
                                      //       child: Text(
                                      //         "No shops near by you",
                                      //         style: MyTextStyle.heading1,
                                      //       ),
                                      //     ),
                                      //   );
                                      // }
                                      //}
                                    },
                                    itemCount: _instance.garagesList == null
                                        ? 0
                                        : _instance.garagesList.length,
                                  );
                                } else {
                                  return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                    "No Garages found near you with the selected car garages",
                                    style: MyTextStyle.referEarnText,
                                  ),
                                      ));
                                }
                                break;
                              default:
                                return Text("Some error occured");
                            }
                          }
                          //child:
                          );
                    },
                    //child: ,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// OurGarageListTileUpdated
