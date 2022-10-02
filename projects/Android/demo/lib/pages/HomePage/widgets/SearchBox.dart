import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Card(
      margin: EdgeInsets.only(left: 20, right: 20),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        height: height * 0.072,
        child: Row(
          children: [
            FittedBox(
              child: Icon(
                Icons.search_outlined,
                color: Colors.grey[400],
                size: 30,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                'Search',
                style: MyTextStyle.heading2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
