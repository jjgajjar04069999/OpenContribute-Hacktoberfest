import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  final String textValue;

  MyCustomButton({
    @required this.textValue,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlatButton(

        padding: EdgeInsets.all(15),
        minWidth: size.width - 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:BorderSide(width: 1, color: Color(0xff323232))

        ),
        onPressed: () {},
        child: Text(textValue, style: MyTextStyle.text4roboto)
    );
  }
}
