import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  String description;
  Description({this.description});
  @override
  Widget build(BuildContext context) {
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
              "Description",
              style: MyTextStyle.shopHeading1,
            ),
          ),
          Text(
            description,
            maxLines: 20,
            textAlign: TextAlign.justify,
            style: MyTextStyle.shopText2,
          )
        ],
      ),
    );
  }
}