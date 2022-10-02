import 'package:flutter/material.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';

class ServiceCards extends StatelessWidget {
  double _height = MediaQueryData().size.height;
  double _width = MediaQueryData().size.width;

  ServiceCards({this.image_path, this.card_text});

  String image_path, card_text;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: Card(
        elevation: 2,
        child: Container(
          height: _height / 8,
          width: _width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: _height / 20,
                width: _width / 8,
                image: AssetImage(
                  'assets/images/servicecards/' + image_path,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                card_text,
                style: MyTextStyle.text6,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
