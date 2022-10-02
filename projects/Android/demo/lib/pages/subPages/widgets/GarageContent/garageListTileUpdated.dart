
import 'package:MechGesture/models/garage/garageModel.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OurGarageListTileUpdated extends StatelessWidget {
  final String name;
  final String type;
   var vehicleServices;
  final double distanceAway;
  final String profileImage;
  final OurGarage sendToFunction;
  final bool status;

   OurGarageListTileUpdated(
      {Key key,
      this.name,
      this.type,
      this.vehicleServices,
      this.distanceAway,
      this.profileImage,
      this.status,
      this.sendToFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width / 4,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                ),
                //Spacer(),
                Container(
                  width: size.width - size.width / 4 - 50,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: AutoSizeText(
                          name,
                          style: MyTextStyle.appBarTextSupporting,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/icons/star.png"),
                            Image.asset("assets/images/icons/star.png"),
                            Image.asset("assets/images/icons/star.png"),
                            Image.asset("assets/images/icons/star.png"),
                            Text(
                              "4.4 out of 5",
                              style: MyTextStyle.text6,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Spacer(),
              ],
            ),
            //Spacer(flex: 1,),
            SizedBox(
              height: 10,
            ),

            Row(
              children: List.generate(size.width ~/ 6, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: 1.5),
                  child: Container(
                    height: 1,
                    width: index == 0 || index == size.width ~/ 6 - 1 ? 1.9 : 4,
                    color: Colors.grey,
                  ),
                );
              }),
            ),
            SizedBox(
              height: 10,
            ),
            //Spacer(flex: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                distanceAway >= 1000
                    ? Text(
                        distanceAway.toStringAsFixed(0) + " KMS",
                        style: MyTextStyle.dropdown,
                      )
                    : Text(
                        distanceAway.toStringAsFixed(0) + " Mtrs",
                        style: MyTextStyle.dropdown,
                      ),
                status != false
                    ? Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1.3,
                              color: MyColors.lightGreen,
                            )),
                        child: Text(
                          "Opened".toUpperCase(),
                          style: MyTextStyle.open,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1.3,
                              color: MyColors.red,
                            )),
                        child: Text(
                          "Closed".toUpperCase(),
                          style: MyTextStyle.Close,
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
