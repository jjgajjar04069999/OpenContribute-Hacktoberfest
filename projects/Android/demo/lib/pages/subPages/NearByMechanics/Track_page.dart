import 'package:MechGesture/pages/HomePage/HomeScreen.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class TrackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var details = ModalRoute.of(context).settings.arguments
        as Map; // containes isGarage, isMechanice key

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                child: Image.asset(
                  'assets/images/maps.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '57 mins away',
              style: MyTextStyle.text1,
            ),
            SizedBox(
              height: 20,
            ),
            if (details['isGarage'] == true)
              Container(
                // margin: EdgeInsets.only(left: 50, right: 50),
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: MyColors.blue_ribbon),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'BOOKING ID',
                      style: MyTextStyle.copy,
                    ),
                    VerticalDivider(
                      color: MyColors.blue_ribbon,
                      thickness: 2,
                      endIndent: 10,
                      indent: 10,
                    ),
                    Text(
                      'USER - 010',
                      style: MyTextStyle.text1,
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 115,
                        width: 115,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: MyColors.blue_ribbon),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: MyColors.blue_ribbon,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Suresh Kumar',
                        style: MyTextStyle.headingTitle,
                      ),
                      Text(
                        '30 yrs. old/Male',
                        style: MyTextStyle.text3,
                      ),
                      Text('Near Noida', style: MyTextStyle.text3),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff48D27F),
                      ),
                      child: Center(
                          child: Text(
                        'CALL',
                        style: MyTextStyle.text4,
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      var w = MediaQuery.of(context).size.width / 2 + 50;

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ), //this right here
                            child: Container(
                              height: w,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: w * 0.30,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      color: Color(0xffD3E5FF),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Booking Cancel',
                                        style: TextStyle(
                                          color: MyColors.darkishBlue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/icons/sad.png'),
                                      Text('Are you sure?',
                                          style: MyTextStyle.text3),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  HomeScreen(),
                                            ),
                                            (route) => false,
                                          ),
                                          child: Container(
                                            height: w * 0.25,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: MyColors.darkishBlue,
                                            ),
                                            child: Center(
                                                child: Text('Yes',
                                                    style: MyTextStyle.text4)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: 0.5, right: 0.5),
                                            height: w * 0.25,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  width: 2,
                                                  color: MyColors.darkishBlue,
                                                )),
                                            child: Center(
                                                child: Text('NO',
                                                    style: MyTextStyle.text2)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      child: Center(
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
          (route) => false,
        ),
        child: Container(
          height: 60,
          color: MyColors.service_card_border,
          child: Center(
            child: Text(
              'CONTINUE',
              style: MyTextStyle.text4,
            ),
          ),
        ),
      ),
    );
  }
}
