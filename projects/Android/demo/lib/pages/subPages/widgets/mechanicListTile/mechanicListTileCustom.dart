import 'package:MechGesture/models/mechanicModel.dart';
import 'package:MechGesture/pages/subPages/NearByMechanics/detailsPageMechanic.dart';
import 'package:MechGesture/pages/subPages/NearByGarage/detailGaragePage.dart';
import 'package:MechGesture/pages/subPages/widgets/mechanicListTile/vehiclesServices.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurMechanicListTileCustom extends StatelessWidget {
  final String name;
  final String type;
  final List vehicleServices;
  final String distanceAway;
  final OurMechanic sendToFunction;

  const OurMechanicListTileCustom(
      {Key key,
      this.name,
      this.type,
      this.vehicleServices,
      this.distanceAway,
      this.sendToFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => OurMechanicDetails(
                      mechanic: sendToFunction,
                    )));
      },
      child: Container(
        //width: 100,
        padding: EdgeInsets.only(top: 7),

        // child: Stack(
        //   children: [
        //     Row(
        //       children: [
        //         Text("name"),
        //         Column(
        //           children: [
        //             Text("tjoej"),
        //             Text("tjoej"),
        //           ],
        //         )
        //       ],
        //     )
        //   ],
        // ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: ClipRRect(
                child: Container(
                  padding: EdgeInsets.only(left: 40, top: 30, bottom: 15),
                  //color: Colors.black,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(30),
                    ),
                    color: MyColors.pinkishGrey,
                    // color: Colors.red,
                  ),
                  width: size.width * 2.5 / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 4,
                              child: Text(
                                name,
                                style: MyTextStyle.nameStyle,
                                overflow: TextOverflow.ellipsis,
                              )),
                          //Spacer(flex:1),

                          Flexible(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      distanceAway.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: MyColors.parrotGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Spacer(flex: 3,),

                          //Spacer(flex: 1,)
                        ],
                      ),
                      Text(
                        type,
                        style: TextStyle(color: Colors.grey),
                      ),
                      VehiclesServiced(
                        vehicleServices: vehicleServices,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              //bottom: 20,
              //left: ,
              left: 13,
              child: Container(
                //width: size.width - size.width * 2.1 / 3,
                width:size.width - size.width * 2.4 / 3,
                height: size.width - size.width * 2.4 / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blue,
                ),
              ),
            ),
            // Flexible(
            //   flex: 3,
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Flexible(
            //               child: Text(
            //                 "1.3km away", style: TextStyle(fontSize: 14,color: Colors.orange),
            //                 overflow: TextOverflow.ellipsis,
            //               )),
            //           Flexible(
            //               child: Text("Available",style:TextStyle(fontSize: 14,color: Colors.green),
            //                   overflow: TextOverflow.ellipsis)),
            //         ],
            //       ),
            //       // FlatButton(
            //       //   onPressed: () {
            //       //     // send the user to the details page of the mechanic
            //       //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OurMechanicDetails(mechanic: sendToFunction,)));
            //       //
            //       //   },
            //       //   shape: RoundedRectangleBorder(
            //       //       borderRadius: BorderRadius.circular(5),
            //       //       side: BorderSide(
            //       //           width: 2,
            //       //           color: Colors.blue
            //       //       )),
            //       //   color: MyColors.soapStoneGrey,
            //       //   child: Text("Select", overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue),),
            //       // )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
