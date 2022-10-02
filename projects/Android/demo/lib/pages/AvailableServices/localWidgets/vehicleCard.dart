import 'package:MechGesture/currentstate/currentState.dart';
import 'package:flutter/material.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:provider/provider.dart';

class VehicleCardCustom extends StatelessWidget {
  double _height = MediaQueryData().size.height;
  double _width = MediaQueryData().size.width;
  Color colorC;

  VehicleCardCustom({this.image_path, this.card_text, this.colorC});

  final String image_path, card_text;

  @override
  Widget build(BuildContext context) {

    CurrentState _instance = Provider.of<CurrentState>(context, listen:false);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Container(
      // padding: EdgeInsets.only(
      //   left: 10.0,
      //   right: 10.0,
      //   bottom: 10.0,
      // ),
      child: Card(
        elevation: 2,
        child: Container(
          color: colorC.withOpacity(0.9),
          //height: 10,
          //width: _width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image_path != "none"
                  ? Image(
                      height: _height / 20,
                      width: _width / 8,
                      image: AssetImage(
                        image_path,
                      ),
                      fit: BoxFit.fill,
                    )
                  : Container(),
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
