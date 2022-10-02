import 'package:flutter/material.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:MechGesture/values/MyColors.dart';


class customButton extends StatelessWidget {
  customButton({this.button_text, this.active});

  String button_text;
  bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 7),

      decoration: BoxDecoration(
        color: active ? MyColors.darkishBlue : Colors.transparent,
        border: Border.all(
          width: 1,
          color: active ? MyColors.darkishBlue : MyColors.pureblack,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
        child: Text(
          button_text.toUpperCase(),
          style: TextStyle(
            color: active ? MyColors.purewhite : MyColors.pureblack,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}