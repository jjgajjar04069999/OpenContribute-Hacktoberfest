import 'dart:async';

import 'package:MechGesture/pages/authentication/widgets/header.dart';
import 'package:flutter/material.dart';
import '../widgets/bottomwave.dart';
import '../widgets/textFieldcustom.dart';
import '../widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var isCustomerSelected = true;
  var loading = false;
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();

  void resetpassword(email) async {
    print("***********");
    final isvalid = _formKey.currentState.validate();
    final _auth = FirebaseAuth.instance;
    _formKey.currentState.save();
    try {
      // await _auth.sendPasswordResetEmail(email: email.text.trim());
      // loading = false;
      // Navigator.of(context).pushNamed('/homescreen');

      if (isvalid) {
        setState(() {
          loading = true;
        });
        await _auth.sendPasswordResetEmail(email: email.text.trim());
        loading = false;

        Fluttertoast.showToast(
            msg: "Please check your register email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.of(context).pushNamed('/loginPage');
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      var mes = "Invalid Credentials";
      setState(() {
        loading = false;
      });

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override

  // TextEditingController email = TextEditingController();
  // var isLoading = false;

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    double height = mediaQueryData.size.height;
    double width = mediaQueryData.size.width;

    final _auth = FirebaseAuth.instance;
    String retVal;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Header(
                    height: height / 2,
                    width: width,
                    text: "Forgotten password",
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height > 360 ? 50 : 20,
                      right: width > 360 ? 20 : 10,
                      left: width > 360 ? 20 : 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email_outlined),
                            labelText: 'Email',
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
                        !loading
                            ? GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  resetpassword(email);
                                },
                                child: Button(
                                  text: "Submit",
                                  color: 1,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CircularProgressIndicator(),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
