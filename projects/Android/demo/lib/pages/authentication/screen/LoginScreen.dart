import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/pages/HomePage/HomeScreen.dart';
import 'package:MechGesture/pages/authentication/widgets/button.dart';
import 'package:MechGesture/pages/authentication/widgets/header.dart';
import 'package:MechGesture/pages/authentication/widgets/textFieldcustom.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../widgets/bottomwave.dart';
import 'package:MechGesture/values/MyTextStyle.dart';

class OurLoginPage extends StatefulWidget {
  @override
  _OurLoginPageState createState() => _OurLoginPageState();
}

class _OurLoginPageState extends State<OurLoginPage> {
  final _formKeyLogin = GlobalKey<FormState>();
  var isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<String> _LoginUser() async {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    final isvalid = _formKeyLogin.currentState.validate();
    final _auth = FirebaseAuth.instance;
    String retVal;
    _formKeyLogin.currentState.save();
    if (isvalid) {
      try {
        setState(() {
          isLoading = true;
        });
        // String retVal = await _instance.loginUserWithEmail(
        //     email.text.trim(), pass.text.trim());
        //UserCredential _authResult = await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: pass.text.trim());
        if (retVal == "success") {
          retVal = "Login Successful";
          // Navigate the user to the page
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false);
          Fluttertoast.showToast(
              msg: retVal,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: retVal,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    MediaQueryData mediaQueryData = MediaQuery.of(context);

    double width = mediaQueryData.size.width;
    double height = mediaQueryData.size.height;
    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      width: width,
                      height: height / 3.3 > 270 ? 280 : height / 3.3,
                      padding: EdgeInsets.only(
                        left: width > 360 ? 20 : 10,
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/loginTop.png"),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: height > 700 ? 90 : 60,
                            //right: width > 360 ? 20 : 10,
                            left: width > 360 ? 25 : 15,
                            child: Text('Welcome \n Back',
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
                    key: _formKeyLogin,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: height / 16,
                        // ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: MyColors.blue_ribbon,
                            ),
                            labelText: 'Email address',
                            labelStyle: MyTextStyle.text1,
                          ),
                          style: MyTextStyle.text2,
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
                        SizedBox(
                          height: height / 40,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/forgotPage');
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Forgot password?",
                              style: MyTextStyle.text1,
                            ),
                          ),
                        ),
                        !isLoading
                            ? GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .unfocus(); //closes keyboard
                                  _LoginUser();
                                },
                                child: Button(
                                  text: "Log In",
                                  color: 1,
                                ),
                              )
                            : Center(child: CircularProgressIndicator()),
                        SizedBox(
                          height: height /
                              40, // Use the same height after 'Or text'
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
                            String retVal =
                                await _instance.loginUserWithGoogle();
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
                            color: 2,
                            iconPath: 'assets/images/icons/Google.png',
                          ),
                        ),
                        //SizedBox(height: height / 7),

                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed('/register'),
                          child: Button(
                            text: "Create a account",
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
      ),
    );
  }
}
