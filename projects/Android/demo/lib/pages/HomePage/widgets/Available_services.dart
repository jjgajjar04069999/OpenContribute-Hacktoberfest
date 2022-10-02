import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Available_services extends StatelessWidget {
  const Available_services({
    Key key,
    @required double height,
    @required double width,
    this.icon_path,
    this.card_text,
  })  : _height = height,
        _width = width,
        super(key: key);

  final double _height;
  final double _width;
  final String icon_path;
  final String card_text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height / 5,
      width: _width / 2.5,
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: MyColors.available_servics,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(color: MyColors.available_servics),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: _height / 12,
            width: _width / 8,
            image: AssetImage('assets/images/available_service/' + icon_path),
          ),
          SizedBox(
            height: 5,
          ),
          AutoSizeText(
            card_text,
            style: MyTextStyle.text8,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
