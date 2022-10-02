import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/pages/AvailableServices/Car/car.dart';
import 'package:MechGesture/pages/BookingPage/booking.dart';
import 'package:MechGesture/pages/HomePage/HomeScreen.dart';
import 'package:MechGesture/pages/ReferEarn.dart';
import 'package:MechGesture/pages/ShopPages/shopConfirmPage.dart';
import 'package:MechGesture/pages/ShopPages/shopPage.dart';
import 'package:MechGesture/pages/Vehicles/myvehicles.dart';
import 'package:MechGesture/pages/authentication/screen/Login.dart';
import 'package:MechGesture/pages/authentication/screen/Register.dart';
import 'package:MechGesture/pages/authentication/screen/Verification.dart';
import 'package:MechGesture/pages/loading.dart';
import 'package:MechGesture/pages/subPages/NearByGarage/AllNearByGarage.dart';
import 'package:MechGesture/pages/subPages/NearByGarage/detailGaragePage.dart';
import 'package:MechGesture/pages/subPages/NearByMechanics/AllNearByMechanics.dart';
import 'package:MechGesture/pages/subPages/NearByMechanics/detailsPageMechanic.dart';
import 'package:MechGesture/provider/selectServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'models/ourUser.dart';
import 'pages/AboutUs.dart';
import 'pages/BookingStatus/booking_status.dart';
import 'pages/Report/Report.dart';
import 'pages/Usage/usagePage.dart';
import 'pages/subPages/NearByMechanics/DescribeScreen.dart';
import 'pages/subPages/NearByMechanics/Track_page.dart';
import 'pages/subPages/profileScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(OurUserHiveGen());

  await Firebase.initializeApp();

  print('gotcha');
  runApp(
    MyApp(),
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentState>(
          create: (context) => CurrentState(),
        ),
        ChangeNotifierProvider<SelectServices>(
          create: (context) => SelectServices(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff000000),
          buttonColor: Color(0xff3E5BFB),
          textSelectionColor: Color(0xff1F1F1F),
          backgroundColor: Color(0xffE5E5E5),
          fontFamily: 'Roboto',
          iconTheme: IconThemeData(color: Colors.white),
        ),
        //initialRoute: '/homescreen',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            // if (userSnapshot.connectionState == ConnectionState.waiting) {
            //   return LoginScreen();
            // }
            if (userSnapshot.hasData) {
              FocusScope.of(context).unfocus();
              var ph = FirebaseAuth.instance.currentUser.phoneNumber;
              //print(ph);
              // var token = FirebaseAuth.instance.currentUser.getIdToken();
              // print(token);
              return HomeScreen();
            }
            // return AdminScreen();
            return Register();
          },
        ),
        routes: {
          //'/registe': (context) => Register(),
          // "/loginPage": (context) => OurLoginPage(),
          "/login": (context) => Login(), //new Login Page
          "/register": (context) => Register(), //new Registeration Page
          "/verify": (context) => Verification(), // New Verify page
          // "/forgotPage": (context) => ForgotPasswordPage(),
          "/homescreen": (context) => HomeScreen(),
          "/profileScreen": (context) => ProfileScreen(),
          "/nearbygarage": (context) => DetailGaragePage(),
          "detailsMechanic": (context) => OurMechanicDetails(),
          "/nearByMechanicsAll": (context) => AllNearByMechanics(),
          "/nearByGarageAll": (context) => AllNearByGarage(),
          "/describePage": (context) => DescribePage(),
          "/trackPage": (context) => TrackPage(),
          "/usagePage": (context) => UsagePage(),
          "/bookingStatus": (context) => BookingStatus(),
          "/reportPage": (context) => ReportPage(),
          "/myVehicles": (context) => MyVehicles(),
          "/referEarnPage": (context) => ReferEarnPage(),
          "/aboutUs": (context) => AboutUs(),
          "/loading": (context) => Loading(),
          "/availableServices/car": (context) => SelectCarBrand(),
          "/shopPage": (context) => ShopPage(),
          "/shopConfirmPage": (context) => ShopConfirmPage(),
          "/bookPage": (context) => BookingPageUpdated(),
        },
      ),
    );
  }
}
