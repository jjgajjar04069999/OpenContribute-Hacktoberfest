import 'package:MechGesture/data/data.dart';
import 'package:MechGesture/models/mechanicModel.dart';
import 'package:MechGesture/pages/subPages/widgets/mechanicListTile/vehiclesServices.dart';
import 'package:MechGesture/pages/subPages/widgets/selectCheckBox/checkBox.dart';
import 'package:MechGesture/provider/selectServices.dart';

//import 'package:MechGesture/pages/subPages/widgets/selectCheckBox/checkbox.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'DescribeScreen.dart';

class OurMechanicDetails extends StatefulWidget {
  final OurMechanic mechanic;

  const OurMechanicDetails({Key key, this.mechanic}) : super(key: key);

  @override
  _OurMechanicDetailsState createState() => _OurMechanicDetailsState();
}

class _OurMechanicDetailsState extends State<OurMechanicDetails> {
  @override
  Widget build(BuildContext context) {
    SelectServices _instance =
        Provider.of<SelectServices>(context, listen: false);
    print(widget.mechanic.vehiclesServices);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Image.asset("assets/images/icons/backArrow.png"),
          ),
        ),
        title: Text(widget.mechanic.name, style: MyTextStyle.appBarTitle),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height / 7,
                  ),
                  Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    elevation: 240,
                    //color: Colors.black,
                    shadowColor: Colors.black,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height / 11,
                          ),
                          Center(
                            child: Text(
                              widget.mechanic.name,
                              style: MyTextStyle.headingTitle,
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.mechanic.age.toString() +
                                  "yrs.old/" +
                                  widget.mechanic.gender,
                              style: MyTextStyle.text6,
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: 13, right: 13, top: 13),
                            child: Container(
                              //margin: EdgeInsets.only(top: 20.0),
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  left: 30.0,
                                  right: 30.0,
                                  bottom: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: MyColors.service_card_background,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.mechanic.type,
                                        style: MyTextStyle.text1,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      VehiclesServiced(
                                        vehicleServices:
                                            garageList[0].vehiclesServices,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 80.0,
                                        lineWidth: 7.0,
                                        percent: 1.0,
                                        center: Text("100%"),
                                        progressColor:
                                            MyColors.circularProgressIndicator,
                                      ),
                                      Text(
                                        "Customer",
                                        style: MyTextStyle.text6,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Satisfaction",
                                        style: MyTextStyle.text6,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),

                                  // VehiclesServiced(vehicleServices: vehicleServices,),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 20.0, left: 10, right: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 30, bottom: 10, top: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    children: [
                                      ...List<Widget>.generate(
                                        widget.mechanic.services.length,
                                        (index) => CheckBox(
                                          //text: widget.mechanic.product[index],
                                          //rate: widget.mechanic.services[index].price.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                //bottom: 100,
                left: 10,
                right: 10,
                top: size.height / 7 - 50,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 100,
                    width: 100,
                    //color: Colors.black,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // Navigate the user to the next screen
          if (_instance.selectedServices.isEmpty) {
          } else {
            // show a snack bar to the user that he has not selected anything yet
            Navigator.pushNamed(context, '/describePage');
          }
        },
        child: Container(
          height: 60,
          color: MyColors.blue_ribbon,
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
