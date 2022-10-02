import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/pages/HomePage/widgets/SearchBox.dart';
import 'package:MechGesture/provider/location.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Sidebar/SideDrawer.dart';
import 'LookingFor.dart';
import 'widgets/HowitWorks.dart';
import 'widgets/membershipPlan.dart';
import 'widgets/popularService.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  SharedPreferences _prefs;
  double current_latitude;
  double current_longitude;
  String currentAddress = " "; //complete Address
  String currentLocality = " "; // Locality
  String currentState = " "; //State (adminArea)
  String currentCountryCode = " "; //countryCode
  String currentCountryName = " "; //countryName
  String currentPostalCode = " "; //PostalCode
  String currentRoadName = " ";

  getLocationData() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      try {
        currentAddress = _prefs.getString("currentAddress");
        current_latitude = _prefs.getDouble('current_latitude');
        current_longitude = _prefs.getDouble("current_longitude");
      } catch (e) {
        //  print(e);
      }
    });

    //print("Latitude--> " + current_latitude.toString());
    //print("Longitude --> " + current_longitude.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LocationData().determinePosition();
    getLocationData();
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    _instance.onStartUp2();
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    //_instance.onStartUp2();
    //_instance.signOut();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: MyColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: MyColors.backgroundColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(11.5),
              child: Image.asset(
                'assets/images/icons/sidebar.png',
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.location_on_outlined),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              color: Colors.black,
            )
          ],
          title: currentAddress != null
              ? Text(
                  currentAddress.toString(),
                  overflow: TextOverflow.ellipsis,
                  // maxLines: 3,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Roboto",
                    color: Colors.black,
                  ),
                )
              : Text(
                  "Loading...",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Roboto",
                    color: Colors.black,
                  ),
                ),
        ),
        drawer: SideDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (a, b, c) => HomeScreen(),
                transitionDuration: Duration(seconds: 1),
                maintainState: true,
              ),
            );
            return Future.value(false);
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.only(bottom: 50.0),
                //margin: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SearchBox(),
                    SizedBox(
                      height: 40,
                    ),
                    PopularService(),
                    Container(
                        width: size.width,
                        child: Image.asset('assets/images/lineCircle.png')),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      // color: MyColors.service_card_background,
                      child: LookingFor(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        width: size.width,
                        child: Image.asset('assets/images/lineCircle.png')),
                    SizedBox(
                      height: 40,
                    ),
                    HowItWorks(),
                    SizedBox(
                      height: 40,
                    ),
                    MembershipPlan(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
