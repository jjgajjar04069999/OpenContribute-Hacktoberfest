import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/Service/preference.dart';
import 'package:flutter_login_signup/pages/AddMoney.dart';
import 'package:flutter_login_signup/pages/Home.dart';
import 'package:flutter_login_signup/pages/loginPage.dart';
import 'package:flutter_login_signup/pages/signup.dart';
import 'package:flutter_login_signup/pages/verify.dart';
import 'package:flutter_login_signup/pages/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preferenceHelper.init();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool? login = preferenceHelper.preferences.getBool('login');
    print(
        '${preferenceHelper.preferences.getBool('login')}++++++++++++++++++++++');
    return MaterialApp(
      routes: {
        '/welcomepage': (context) => WelcomePage(),
        '/Home': (context) => Home(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/verify': (context) => VerifyScreen(),
        '/AddMoney': (context) => AddMoney(),
      },
      title: 'Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: login == true && login != null ? Home() : WelcomePage(),
    );
  }
}
