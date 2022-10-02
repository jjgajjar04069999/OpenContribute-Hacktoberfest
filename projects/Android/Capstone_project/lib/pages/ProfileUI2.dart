import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/DatabaseManager/DatabaseManager.dart';
import 'package:flutter_login_signup/Service/AuthenticationService.dart';
import 'package:flutter_login_signup/Service/preference.dart';
import 'package:flutter_login_signup/pages/ProfileUI1.dart';

import 'ProfileUI1.dart';
import 'loginPage.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  dynamic uid;
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController _nameController = TextEditingController();

  TextEditingController rollNoController = TextEditingController();

  late String? name;
  late String? rollNo;
  late String money;

  @override
  void initState() {
    super.initState();
    name = preferenceHelper.preferences.getString('name');
    rollNo = preferenceHelper.preferences.getString('rollno');
    uid = preferenceHelper.preferences.getString('uid');

    // fetchUserInfo();
  }

  fetchUserInfo() async {
    uid = await _auth.getCurrentUID();
    print(uid);
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
          // print(resultant);
          name = resultant.get('name');
          rollNo = resultant.get('rollNo');
          money = resultant.get('money');
          // String name = resultant.g;
          // String rollNo = resultant[1];
          // print("name = $name");
          // print("rollNor = $rollNo");
        });
      }
    }
  }

  updateData(String name, String rollNo, String userID) async {
    await DatabaseManager().updateProfile(name, rollNo, userID);
    fetchDatabaseList();
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
                context, MaterialPageRoute(builder: (context) => Settings1()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              preferenceHelper.login(false);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
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
                  "Edit Profile",
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
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.black,
                          ),
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onTap: () {},
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // buildTextField("Full Name", "Atiksha", false),
              // buildTextField("Roll Number", "101805794", false),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              SizedBox(
                height: 5,
              ),
              // TextField(
              //   controller: rollNoController,
              //   enabled: false,
              //   decoration: InputDecoration(hintText: 'RollNo'),
              // ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      submitAction(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings1()));
                    },
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings1()));
                    },
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  submitAction(BuildContext context) {
    updateData(_nameController.text, rollNo!, uid);
    _nameController.clear();
    rollNoController.clear();
  }

// Widget buildTextField(
//     String labelText, String placeholder, bool isPasswordTextField) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 35.0),
//     child: TextField(
//       obscureText: isPasswordTextField ? showPassword : false,
//       decoration: InputDecoration(
//           suffixIcon: isPasswordTextField
//               ? IconButton(
//             onPressed: () {
//               setState(() {
//                 showPassword = !showPassword;
//               });
//             },
//             icon: Icon(
//               Icons.remove_red_eye,
//               color: Colors.grey,
//             ),
//           )
//               : null,
//           contentPadding: EdgeInsets.only(bottom: 3),
//           labelText: labelText,
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: placeholder,
//           hintStyle: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           )),
//     ),
//   );
// }
}
