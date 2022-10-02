import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Problem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen:false);
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
            margin: EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Text(
              "Describe the problem",
              style: MyTextStyle.shopHeading1,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              border: Border.all(
                color: MyColors.pureblack,
              ),
            ),
            child: TextFormField(
              onChanged: (value) {
                _instance.description = value;
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              maxLength: 2000,
              // textCapitalization: TextCapitalization.words,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "What's the issue ?"),
            ),
          ),
        ],
      ),
    );
  }
}