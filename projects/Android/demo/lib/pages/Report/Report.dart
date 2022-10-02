import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import './widgets/ReportCategory.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        iconTheme: IconThemeData(
          color: MyColors.darkishBlue, //change your color here
        ),
        title: Text("Report".toUpperCase(), style: MyTextStyle.report_text,),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'CANCEL',
                  style: MyTextStyle.text3,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  color: MyColors.service_card_border,
                  child: Center(
                    child: Text(
                      'Send',
                      style: MyTextStyle.text4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text("Select & Help us understand the problem",
                          style: MyTextStyle.report_text),
                    ),
                  ),
                ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReportCategory(text: "Misbehave",),
                            ReportCategory(text: "Spam",),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReportCategory(text: "Abusive",),
                            ReportCategory(text: "Demand high price",),
                          ],
                        ),
                      ],
                    ),
                  ),
                //Input text area
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Describe your report',
                        style: MyTextStyle.text1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            hintText: 'Describe the problem here.'),
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
