import 'package:MechGesture/values/MyColors.dart';
import 'package:flutter/material.dart';

class ReportCategory extends StatefulWidget {
  final String text;

  ReportCategory({Key key, @required this.text}) : super(key: key);

  @override
  _ReportCategoryState createState() => _ReportCategoryState(text);
}

class _ReportCategoryState extends State<ReportCategory> {
  String  text;
  _ReportCategoryState(this. text);
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
        active = !active;
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: (active) ? MyColors.darkishBlue : MyColors.purewhite,
          border: Border.all(color: (active) ? MyColors.purewhite : MyColors.darkishBlue,),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,


          children: [
            Text(widget.text,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,color: (active) ? MyColors.purewhite : MyColors.darkishBlue,),
            ),
            SizedBox(
              width: 2.0,
            ),
            (active)? Icon(Icons.check): Container(),
          ],
        ),
      ),
    );
  }
}
