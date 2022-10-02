import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/Service/AuthenticationService.dart';
import 'package:flutter_login_signup/pages/reset.dart';
import 'package:flutter_login_signup/pages/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  late String _email, _password;

  late String _error;
  bool visible = false;

  bool validate() {
    final form = _key.currentState;
    form!.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  final AuthenticationService _auth = AuthenticationService();
  final auth = FirebaseAuth.instance;

  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                // image: DecorationImage(
                //     image: AssetImage("images/pic.jpg"), fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: <BoxShadow>[
                  // BoxShadow(
                  //     color: Colors.grey.shade500,
                  //     offset: Offset(2, 4),
                  //     blurRadius: 5,
                  //     spreadRadius: 2)
                ],
              ),
              child: Center(
                child: Form(
                  key: _key,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'images/logo.png',
                            height: size.height * 0.2,
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.indigo[900],
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                TextFormField(
                                  controller: _emailContoller,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains("@")) {
                                      return 'Email is invalid';
                                    } else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        color: Colors.indigo[900],
                                        fontSize: 17,
                                      )),
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 30),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return 'Password is invalid';
                                    } else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Colors.indigo[900],
                                        fontSize: 17,
                                      )),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetScreen()),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                FlatButton(
                                  child: Text(
                                    'Not registerd? Sign up',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => SignUpPage(),
                                      ),
                                    );
                                  },
                                  textColor: Colors.white,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                        ),
                                      ),
                                      onPressed: () => signInUser(),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                          visible: visible,
                          child: Container(
                              color: Colors.white.withOpacity(0.5),
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void signInUser() async {
    if (validate()) {
      try {
        setState(() {
          visible = true;
        });
        dynamic authResult = await _auth.loginUser(
            _emailContoller.text, _passwordController.text);
        if (authResult == null) {
          setState(() {
            visible = false;
          });
          Fluttertoast.showToast(msg: 'Email or Password is invalid');
          print('Sign in error. could not be able to login');
        } else {
          _emailContoller.clear();
          _passwordController.clear();
          setState(() {
            visible = false;
          });
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => Home()));
        }
      } catch (e) {
        setState(() {
          visible = false;
          Fluttertoast.showToast(msg: e.toString());
          _error = e.toString();
        });
      }
    }
  }

  void _showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
