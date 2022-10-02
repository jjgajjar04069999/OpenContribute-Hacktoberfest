import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';
import 'package:MechGesture/provider/selectServices.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class CheckBox extends StatefulWidget {
  final MechanicServices text;
  bool disableCode = false;
  double textSize = 16;
  //bool checkbox;
  CheckBox({this.disableCode = false,this.text, this.textSize});

  @override
  _TextRateDisplayState createState() => _TextRateDisplayState();
}

class _TextRateDisplayState extends State<CheckBox> {
  //bool _checkbox = false;

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {

                  if(widget.disableCode == false) {
                    setState(() {
                      widget.text.selected = !widget.text.selected;
                      _instance.addServicesToList(
                          local: widget.text.selected, data: widget.text);
                    });
                  }

                },
                child: Container(
                  height: 20,
                  width: 20,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: widget.text.selected
                            ? Colors.black
                            : Colors.transparent),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {

                  if(widget.disableCode == false) {
                    setState(() {
                      widget.text.selected = !widget.text.selected;
                      _instance.addServicesToList(
                          local: widget.text.selected, data: widget.text);
                    });
                  }
                },
                child: AutoSizeText(
                  '${widget.text.name}',
                  style: TextStyle(
                    fontSize: widget.textSize,
                    fontWeight: FontWeight.w400,
                    color: widget.text.selected
                        ? Colors.black
                        : MyColors.pureblack,
                    fontFamily: 'Poppins',

                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            '₹. ${widget.text.price.toString()}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: widget.text.selected ? Colors.black : MyColors.pureblack,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
