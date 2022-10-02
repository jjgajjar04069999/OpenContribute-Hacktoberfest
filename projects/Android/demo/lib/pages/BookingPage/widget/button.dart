import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class OurButton extends StatelessWidget {
  String textToShow;
  OurButton({this.textToShow});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 10,
        right: 10
      ),
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Center(
          child: Text(
            textToShow,
            style: MyTextStyle.buttonTextU,
          )),
    );
  }
}
