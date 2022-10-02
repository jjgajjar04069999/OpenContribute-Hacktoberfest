import 'package:MechGesture/pages/Sidebar/SideDrawer.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  var dt =
      'The MechGesture team worked hard to develop this app. This app helps the customer to find nearby mechanics, and garages/service centers. We constantly improve the products and are determined with your moral to provide 100% transparency to the user. We are dedicated hours & hours to improve the products so that you could use the product effortlessly. ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Image.asset('assets/images/icons/sidebar.png'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_outlined),
            onPressed: () {},
            color: MyColors.blue_ribbon,
          )
        ],
        title: Text(""),
      ),
      drawer: SideDrawer(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: MyTextStyle.headingTitle,
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/aboutUs.png'),
            SizedBox(
              height: 20,
            ),
            Flexible(
                child: Text(
              '$dt',
              style: TextStyle(
                letterSpacing: 1,
                height: 1.5,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'For any query or business-related',
                style: MyTextStyle.text1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contact us',
                style: MyTextStyle.report_text,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'mechgesture@gmail.com',
                style: MyTextStyle.text1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
