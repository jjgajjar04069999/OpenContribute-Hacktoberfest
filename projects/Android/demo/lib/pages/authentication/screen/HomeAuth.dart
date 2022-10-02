// import 'package:MechGesture/currentstate/currentState.dart';
// import 'package:MechGesture/pages/HomePage/HomeScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widgets/button.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// void main() {
//   runApp(HomeAuth());
// }

// class HomeAuth extends StatefulWidget {
//   @override
//   _HomeAuthState createState() => _HomeAuthState();
// }

// class _HomeAuthState extends State<HomeAuth> {
//   @override
//   Widget build(BuildContext context) {
    
//     MediaQueryData mediaQueryData = MediaQuery.of(context);

//     double width = mediaQueryData.size.width;
//     double height = mediaQueryData.size.height;

//     return Scaffold(
//       //backgroundColor: Theme.of(context).primaryColor,
//       body: Stack(
//         children: [
//           Container(
//             width: width,
//             height: height,
//             child: Image.asset(
//               "assets/images/mainBg.jpg",
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 40.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Mech Gesture",
//                   style: Theme.of(context).textTheme.headline1,
//                 ),
//                 Text(
//                   "Providing mechanical service!",
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // take the user to the login page
//                     //Navigator.of(context, MaterialPageBuilder())
//                     Navigator.of(context).pushNamed('/loginPage');
//                   },
//                   child: Button(
//                     text: "Log in",
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // take the user to the login page
//                     //Navigator.of(context, MaterialPageBuilder())
//                     Navigator.of(context).pushNamed('/singupPage');
//                   },
//                   child: Button(
//                     text: "Sign up",
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
