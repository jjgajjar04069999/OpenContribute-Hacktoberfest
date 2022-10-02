import 'package:flutter/material.dart';

class OurTextFieldCustom extends StatelessWidget {
  final Icon prefixIcon;
  final Icon suffixIcon;
  final String hintText;
  final TextEditingController
      c1; // when you will need to get the value from the text field pass in the controller
  OurTextFieldCustom(
      {this.prefixIcon, this.suffixIcon, this.hintText, this.c1});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        //disabledBorder:,
        //labelText: "water@gmail.com",
        hintText: hintText,
        prefix: prefixIcon,
        suffix: suffixIcon,
        enabled: true,
        contentPadding: EdgeInsets.only(left: 5),
        hintStyle: TextStyle(color: Colors.blueAccent),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
