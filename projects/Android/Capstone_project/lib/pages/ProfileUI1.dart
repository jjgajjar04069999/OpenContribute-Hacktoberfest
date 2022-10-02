import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/DatabaseManager/DatabaseManager.dart';
import 'package:flutter_login_signup/Service/AuthenticationService.dart';
import 'package:flutter_login_signup/Service/preference.dart';

import 'Home.dart';
import 'ProfileUI2.dart';
import 'loginPage.dart';

class Settings1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI1",
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();

  late String? name = '';
  late String? rollNo = '';
  dynamic uid;

  @override
  void initState() {
    super.initState();
    setState(() {
      name = preferenceHelper.preferences.getString('name');
      rollNo = preferenceHelper.preferences.getString('rollno');
    });
  }

  Future<void> fetchDatabaseList() async {
    uid = await _auth.getCurrentUID();
    if (uid == null) {
      print("UID is NULL");
    } else {
      print("uid-$uid");
      DatabaseManager databaseManager = DatabaseManager(uid: uid);
      DocumentSnapshot resultant = await databaseManager.getUsersList();

      if (resultant == null) {
        print('Unable to retrieve');
      } else {
        setState(() {
          name = resultant.get('name');
          rollNo = resultant.get('rollNo');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "Your Profile Information",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('images/profile.png')),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Full Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                name != null ? Text("$name") : Text(''),
                Divider(
                  color: Colors.grey[500],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Roll Number",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("$rollNo"),
                Divider(
                  color: Colors.grey[500],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsUI()));
                      },
                      color: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                        onPressed: () {
                          preferenceHelper.preferences.setBool('login', false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.logout,
                                size: 16,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              "Signout",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                )
              ],
            )),
      ),
    );
  }
}
