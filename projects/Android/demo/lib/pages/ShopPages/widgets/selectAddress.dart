import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class SelectAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select address",
              style: MyTextStyle.shopHeading1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sector no 1/2 meerut, \n noida",
                style: MyTextStyle.shopText1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                height: _height / 15,
                width: _width / 3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  color: MyColors.shopButton,
                ),
                child: Text(
                  "Change address",
                  style: MyTextStyle.shopButton1,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}