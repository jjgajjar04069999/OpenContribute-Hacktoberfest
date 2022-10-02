import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: 100.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  // alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome\nBack",
                          style: MyTextStyle.heading4,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 5.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            color: MyColors.lightgrey3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Use your phone number to login \nand start earning.",
                    style: MyTextStyle.text10,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0),
                    ),
                  ),
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your phone no.',
                      icon: Icon(
                        Icons.smartphone_sharp,
                        color: MyColors.pureblack,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/homescreen");
                  },
                  child: Container(
                    height: _height / 15,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      color: MyColors.shopButton,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 150.0),
                          child: Text(
                            "Continue",
                            style: MyTextStyle.shopButton2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            color: MyColors.yellowish,
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
