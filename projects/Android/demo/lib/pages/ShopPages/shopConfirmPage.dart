import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/models/garage/garageModel.dart';
import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';
import 'package:MechGesture/pages/BookingPage/booking.dart';
import 'package:MechGesture/pages/BookingPage/widget/screenDisableCode.dart';
import 'package:MechGesture/pages/ShopPages/widgets/problem.dart';
import 'package:MechGesture/pages/ShopPages/widgets/selectAddress.dart';
import 'package:MechGesture/pages/subPages/widgets/selectCheckBox/checkBox.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'widgets/details.dart';

class ShopConfirmPage extends StatefulWidget {
  OurGarage allData;

  ShopConfirmPage({this.allData});

  @override
  _ShopConfirmPageState createState() => _ShopConfirmPageState();
}

class _ShopConfirmPageState extends State<ShopConfirmPage> {
  int total;
  List<MechanicServices> selectedServices = [];

  @override
  void initState() {
    super.initState();
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    if (_instance.selectedProducts.isNotEmpty) {
      if (widget.allData.uid == _instance.selectedProducts[0].id) {
        _instance.totalAmount = 0;
        _instance.selectedProducts.forEach((element) {
          _instance.totalAmount += element.price;
        });
        // do nothing
      } else {
        widget.allData.products.forEach((element) {
          if (element.selected == true) {
            element.selected = false;
          }
        });
        _instance.selectedProducts.clear();
        _instance.totalAmount = 0;
      }
    } else {
      _instance.totalAmount = 0;
      widget.allData.products.forEach((element) {
        if (element.selected == true) {
          element.selected = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.purewhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: _instance.isScreenDisable
              ? NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          child: Container(
              margin: EdgeInsets.only(
                top: 20.0,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Details(
                        shopName: widget.allData.name,
                        profileImg: widget.allData.images.profileImages[0],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select the services",
                              style: MyTextStyle.headingTitle),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Repairement & \n Services",
                                  style: MyTextStyle.dropdown,
                                ),
                                Text(
                                  "Price Rate",
                                  style: MyTextStyle.dropdown,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: MyColors.yellowish),
                                //color: MyColors.yellowish,
                              ),
                              child: Column(
                                children: [
                                  ...List.generate(
                                      widget.allData.products.length, (index) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 7),
                                        child: CheckBox(
                                          text: widget.allData.products[index],
                                        ));
                                  })
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: size.height / 15,
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.all(
                                //   Radius.circular(10.0),
                                // ),
                                color: MyColors.shopButton,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Total",
                                    style: MyTextStyle.shopButton2,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Consumer<CurrentState>(
                                    builder: (context, _, Widget child) {
                                      return Text(
                                      "₹" + _instance.totalAmount.toString(),
                                        style: MyTextStyle.shopButton2,
                                      );
                                    },
                                    //child: ,
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 20.0),
                                  //   child: Icon(
                                  //     Icons.arrow_forward_sharp,
                                  //     color: MyColors.yellowish,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Problem(),
                      SelectAddress(),
                      AbsorbPointer(
                        absorbing: false,
                        child: GestureDetector(
                          onTap: () async {
                            if (_instance.selectedProducts.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "you have not selected any service",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              print("dgiodsgndsngsd");
                              String _retVal = await _instance.order(
                                  shopData: widget.allData);
                              if (_retVal == "success") {
                                //Navigator.pushName(context, "/bookPage");
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPageUpdated(allData: widget.allData,orderDetails: null,)));

                              } else {
                                Fluttertoast.showToast(
                                    msg: "someThing went wrong",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              bottom: 20.0,
                            ),
                            height: size.height / 15,
                            width: double.infinity,
                            //margin: EdgeInsets.only(top: 20.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              color: MyColors.shopButton,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 150.0),
                                  child: Text(
                                    "Confirm",
                                    style: MyTextStyle.shopButton2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Icon(
                                    Icons.arrow_forward_sharp,
                                    color: MyColors.yellowish,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ScreenDisableCode(),
                ],
              )),
        ),
      ),
    );
  }
}
