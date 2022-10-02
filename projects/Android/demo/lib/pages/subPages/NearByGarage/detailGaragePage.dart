import 'package:MechGesture/models/garage/garageModel.dart';
import 'package:MechGesture/models/mechanicModel.dart';
import 'package:MechGesture/pages/subPages/profileScreen.dart';
import 'package:MechGesture/pages/subPages/widgets/GarageContent/GarageCarousel.dart';
import 'package:MechGesture/pages/subPages/widgets/selectCheckBox/checkBox.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:MechGesture/data/data.dart';
import '../widgets/mechanicListTile/vehiclesServices.dart';
import 'package:MechGesture/provider/selectServices.dart';

//on clicking 'see all' button show the screen in /subPages/NearByGarage folder
class DetailGaragePage extends StatefulWidget {
  final OurGarage garage;
  final OurMechanic mechanic;

  const DetailGaragePage({Key key, this.garage, this.mechanic})
      : super(key: key);

  @override
  _DetailGaragePageState createState() => _DetailGaragePageState();
}

class _DetailGaragePageState extends State<DetailGaragePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.purewhite,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: MyColors.red,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          widget.garage.name,
          style: MyTextStyle.text3,
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () =>
            Navigator.popAndPushNamed(context, "/trackPage", arguments: {
          'isGarage': true,
          'isMechanic': false,
        }),
        child: Container(
          height: height * 0.08,
          color: MyColors.blue_ribbon,
          child: Center(
            child: Text(
              'CONTINUE',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GarageCarousel(),
            Container(
              margin: EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Text(
                          widget.garage.name,
                          style: MyTextStyle.headingTitle,
                        ),
                        Text(
                          "Established in " + widget.garage.establishedYear,
                          style: MyTextStyle.text6,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.only(
                        top: 20.0, left: 30.0, right: 30.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: MyColors.service_card_background,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Garage",
                              style: MyTextStyle.text1,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            VehiclesServiced(
                              vehicleServices: garageList[0].vehiclesServices,
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            CircularPercentIndicator(
                              radius: 80.0,
                              lineWidth: 7.0,
                              percent: widget.garage.satisfaction / 100,
                              center:
                                  Text(widget.garage.satisfaction.toString()),
                              progressColor: MyColors.circularProgressIndicator,
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
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Row(
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
                                widget.garage.products.length,
                                (index) => CheckBox(
                                    //text: widget.garage.services[index],
                                    //rate: widget.mechanic.services[index].price.toString(),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "About us",
                              style: MyTextStyle.text1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.garage.aboutUs,
                          style: MyTextStyle.aboutus,
                          maxLines: 50,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(30.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            color: MyColors.garage_timing,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Open Time",
                                style: MyTextStyle.time_heading,
                              ),
                              Text(
                                widget.garage.openTime.hours + " AM",
                                style: MyTextStyle.timing,
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(30.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            color: MyColors.garage_timing,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Close time",
                                style: MyTextStyle.time_heading,
                              ),
                              Text(
                                widget.garage.closeTime.hours + " PM",
                                style: MyTextStyle.timing,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// // Contain checkbox text and price structure
// class TextRateDisplay extends StatefulWidget {
//   TextRateDisplay({this.text, this.rate});
//
//   String text, rate;
//
//   @override
//   _TextRateDisplayState createState() => _TextRateDisplayState();
// }
//
// class _TextRateDisplayState extends State<TextRateDisplay> {
//   bool _checkbox = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _checkbox = !_checkbox;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
//         child:
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//
//                 Container(
//                     height: 20,
//                     width: 20,
//                     padding: EdgeInsets.all(1),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       border: Border.all(
//                         width: 2,
//                         color: _checkbox ? Colors.blue : Colors.grey,
//                       ),
//                     ),
//                     child: Container(
//                       height: 15,
//                       width: 15,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(2),
//                           color: _checkbox ? Colors.blue : Colors.transparent),
//                     ),
//                   ),
//
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   '${widget.text}',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w400,
//                     color: _checkbox ? Colors.blue : MyColors.pureblack,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ],
//             ),
//             Text(
//               '₹. ${widget.rate}',
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w400,
//                 color: _checkbox ? Colors.blue : MyColors.pureblack,
//                 fontFamily: 'Poppins',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Contain checkbox text and price structure

