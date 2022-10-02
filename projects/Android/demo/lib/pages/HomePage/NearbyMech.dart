//contains code that should be displayed in home screen

//on clicking 'see all' button show the screen in /subPages/NearByMechanics folder

import 'package:MechGesture/data/data.dart';
import 'package:MechGesture/pages/subPages/widgets/mechanicListTile/mechanicListTileCustom.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class NearByMechancs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Near By Mechanics",
                    style: MyTextStyle.headingTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Find all the mechanics near by \n within your location",
                      overflow: TextOverflow.ellipsis,
                      style: MyTextStyle.informationText),
                ],
              ),
              Flexible(
                child: FlatButton(
                    padding: EdgeInsets.all(0),
                    minWidth: 70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: MyColors.darkishBlue,
                    onPressed: () {
                      Navigator.pushNamed(context, "/nearByMechanicsAll");
                    },
                    child: Text("See all",
                        style: TextStyle(color: MyColors.soapStoneWhite),
                        overflow: TextOverflow.ellipsis)),
              )
            ],
          ),
        ),
        Container(
          //width: 100,
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          child: OurMechanicListTileCustom(
            distanceAway: mechanicList[0].distanceAway,
            name: mechanicList[0].name,
            sendToFunction: mechanicList[0],
            type: mechanicList[0].type,
            vehicleServices: mechanicList[0].vehiclesServices,
            //mechanicList[index].distanceAway,
          ),
        ),
        Container(
          //width: 100,
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          child: OurMechanicListTileCustom(
            distanceAway: mechanicList[1].distanceAway,
            name: mechanicList[1].name,
            sendToFunction: mechanicList[1],
            type: mechanicList[1].type,
            vehicleServices: mechanicList[1].vehiclesServices,
            //mechanicList[index].distanceAway,
          ),
        ),
      ],
    );
  }
}
