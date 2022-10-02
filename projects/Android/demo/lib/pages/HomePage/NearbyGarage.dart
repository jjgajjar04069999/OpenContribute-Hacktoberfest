import 'package:MechGesture/data/data.dart';
import 'package:MechGesture/pages/subPages/widgets/GarageContent/garageListTileCustom.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class NearByGarage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //margin: EdgeInsets.only(left: 40.0),
          margin: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Near by Garages &",
                    style: MyTextStyle.headingTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Service centers",
                    style: MyTextStyle.headingTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Find all the garages & service centers ",
                      overflow: TextOverflow.ellipsis,
                      style: MyTextStyle.informationText),
                  Text(" near by within your location",
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
                      Navigator.pushNamed(context, "/nearByGarageAll");
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
          child: OurGarageListTileCustom(
            distanceAway: garageList[0].distanceAway,
            name: garageList[0].name,
            sendToFunction: garageList[0],
            type: garageList[0].type,
            vehicleServices: garageList[0].vehiclesServices,
            //mechanicList[index].distanceAway,
          ),
        ),
        Container(
          //width: 100,
          padding: EdgeInsets.only(
            bottom: 10,
          ),
          child: OurGarageListTileCustom(
            distanceAway: garageList[1].distanceAway,
            name: garageList[1].name,
            sendToFunction: garageList[1],
            type: garageList[1].type,
            vehicleServices: garageList[1].vehiclesServices,
            //mechanicList[index].distanceAway,
          ),
        ),
      ],
    );
  }
}
