
import 'package:MechGesture/values/MyColors.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Usage_CheckBox extends StatefulWidget {

  Usage_CheckBox({this.name, this.price});

  final String  name;
  int price;

  @override
  _TextRateDisplayState createState() => _TextRateDisplayState();
}

class _TextRateDisplayState extends State<Usage_CheckBox> {


  @override
  Widget build(BuildContext context) {

    var price;
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   _checkbox = !_checkbox;
                  // });
                },
                child: Container(
                  height: 20,
                  width: 20,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      width: 2,
                      color: Colors.blue
                    ),
                  ),
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color:  Colors.blue),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   _checkbox = !_checkbox;
                  // });
                },
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          Text(
            '₹. ${widget.price.toString()}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}