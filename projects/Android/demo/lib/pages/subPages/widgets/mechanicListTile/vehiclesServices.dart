import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class VehiclesServiced extends StatelessWidget {
  final List vehicleServices;

  VehiclesServiced({this.vehicleServices});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List<Widget>.generate(vehicleServices.length, (index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10,7,10,7),
              decoration: BoxDecoration(
                //color: Colors.black,
                border:Border.all(
                  width: 1,
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(
                  5,
                ),
                // border: Border.all(
                //   color: Colors.blue,
                //   width: 1.5,
                // )
              ),
              child: Text(
                vehicleServices[index].toUpperCase(),
                style: MyTextStyle.typeMechanic,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            //Spacer(flex: 1,)
            SizedBox(
              width: 7,
            ),
          ],
        );
      }).toList(),
      // Spacer(flex: 1,),
      // Container(
      //   decoration: BoxDecoration(
      //       color: Colors.orange,
      //       borderRadius: BorderRadius.circular(3,),
      //       border: Border.all(
      //         color: Colors.blue,
      //         width: 3,
      //       )
      //   ),
      //   child: Text("Car", style: MyTextStyle.typeMechanic,),
      // ),
      // Spacer(flex: 1,),
      //
      // Container(
      //   decoration: BoxDecoration(
      //       color: Colors.orange,
      //       borderRadius: BorderRadius.circular(3,),
      //       border: Border.all(
      //         color: Colors.blue,
      //         width: 3,
      //       )
      //   ),
      //   child: Text("Motorcycle", style: MyTextStyle.typeMechanic,),
      // ),
      // Spacer(flex: 2,),
    );
  }
}
