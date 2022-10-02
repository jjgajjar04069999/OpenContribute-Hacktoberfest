import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/models/orderModel.dart';
import 'package:MechGesture/pages/BookingPage/booking.dart';
import 'package:MechGesture/pages/Usage/widgets/Usage_checkbox.dart';
import 'package:MechGesture/pages/subPages/widgets/selectCheckBox/checkBox.dart';
import 'package:flutter/material.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/pages/subPages/widgets/mechanicListTile/vehiclesServices.dart';
import 'package:MechGesture/data/data.dart';
import 'package:MechGesture/pages/Usage/widgets/CustomButton.dart';
import 'package:MechGesture/pages/Report/Report.dart';
import 'package:MechGesture/pages/Usage/widgets/Usage_checkbox.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {this.name,
      this.type,
      this.date,
      this.amount,
      this.button_text1,
      this.button_text2,
      this.path1,
      this.path2,
      this.fullDetails});

  OrderModel fullDetails;
  String name, type, date, button_text1, button_text2, path1, path2;
  double amount;

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    double width = mediaQueryData.size.width;
    double height = mediaQueryData.size.height;

    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20.0),
      //padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: MyColors.usageCard,
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(20.0),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPageUpdated(orderDetails: fullDetails,)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: MyTextStyle.usageAgeHeading,
                ),
                Text(
                  "${fullDetails.orderTime.day}-${fullDetails.orderTime.month}-${fullDetails.orderTime.year}",
                  //date,
                  style: MyTextStyle.usageAgeDate,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: MyTextStyle.usageAgeText,
                ),
                Row(
                  children: [
                    Text(
                      "Total",
                      style: MyTextStyle.usageAgeText,
                    ),


                    Builder(builder: (context) {
                      double total = 0;
                      fullDetails.servicesOrder.forEach((element) {
                        total += element.price;
                      });
                      return Text(
                        " ₹ $total",
                        style: MyTextStyle.usageAgeHeading,
                      );
                    }),
                    // Text(
                    //   "  ₹." "$amount",
                    //   style: MyTextStyle.usageAgeHeading,
                    // ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(
                //   child: VehiclesServiced(
                //     vehicleServices: mechanicList[2].vehiclesServices,
                //   ),
                // ),

                // Write the name of the employee that is assigned to the order
                Center(
                  child: Text(fullDetails.employeeName != null
                      ? fullDetails.employeeName
                      : "Employee yet to be assigned"),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Details button

                    button_text1 != null
                        ? GestureDetector(
                            onTap: () {
                              //showAlertDialog(context);
                            },
                            child: customButton(
                              button_text: button_text1,
                              active: true,
                            ),
                          )
                        : Container(),
                    GestureDetector(
                      onTap: () {
                        if (path2 == "ListOfServices") {
                          showAlertDialog(context, fullDetails);
                        } else {
                          Navigator.pushNamed(context, path2);
                        }
                      },
                      child: Center(
                        child: customButton(
                          button_text: button_text2,
                          active: false,
                        ),
                      ),
                    ),

                    //Report button
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, OrderModel orderDetails) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  double width = mediaQueryData.size.width;
  double height = mediaQueryData.size.height;
  double radius = 10.0;

  // Create button

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    contentPadding: EdgeInsets.all(0.0),
    content: SingleChildScrollView(
      child: Container(
        //width: context.size.width,
        //height: height / 3.35,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: MyColors.usageCard,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              //margin: EdgeInsets.only(left: width / 25, right: width / 25),
              padding: EdgeInsets.only(
                  left: width / 35, right: width / 35, top: height / 60),
              width: context.size.width,
              color: MyColors.usageCard,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Repairment &\nServices',
                        style: MyTextStyle.text1,
                      ),
                      Text(
                        'Price rate',
                        style: MyTextStyle.text1,
                      ),
                    ],
                  ),
                  Container(
                    width: width - 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: MyColors.yellowish),
                      //color: MyColors.yellowish,
                    ),
                    child: Column(
                      children: [
                        ...List.generate(orderDetails.servicesOrder.length,
                            (index) {
                          return Container(
                            width: width - 80,
                            child: CheckBox(
                              text: orderDetails.servicesOrder[index],
                              disableCode: true,
                              textSize: 8,
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height / 80, bottom: height / 80),
              height: 5,
              color: MyColors.purewhite,
            ),
            Container(
              // margin: EdgeInsets.only(
              //     left: width / 35, right: width / 35, top: height / 60),
              padding: EdgeInsets.only(
                left: width / 15,
                right: width / 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: MyTextStyle.details_text,
                  ),
                  Builder(builder: (context) {
                    double total = 0;
                    orderDetails.servicesOrder.forEach((element) {
                      total += element.price;
                    });
                    return Text(
                      "₹$total",
                      style: TextStyle(
                        color: MyColors.yellowish,
                        fontFamily: 'Roboto',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height / 90),
              padding: EdgeInsets.only(top: height / 90),
              height: height / 13,
              width: context.size.width,
              child: Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: MyColors.yellowish,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(radius),
                          bottomLeft: Radius.circular(radius)),
                    ),
                    child: Center(
                      child: Text(
                        'Close'.toUpperCase(),
                        style: MyTextStyle.text4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// height: 60,
// child: Row(
// children: [
// Expanded(
// child: GestureDetector(
// onTap: (){
// Navigator.of(context).pop();
// },
// child: Container(
// color: MyColors.service_card_border,
// child: Center(
// child: Text(
// 'Send',
// style: MyTextStyle.text4,
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// );
