import 'package:flutter/material.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:MechGesture/values/MyColors.dart';

class CustomListTile extends StatefulWidget {
  CustomListTile(
      {@required this.title,
      @required this.icon,
      this.isSelected = false,
      this.onTap});

  final String title;
  final IconData icon;
  bool focus = true;
  final bool isSelected;
  final Function onTap;

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    double width = mediaQueryData.size.width;
    double height = mediaQueryData.size.height;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 60.0,
        padding: EdgeInsets.only(
            top: height > 720 ? 0 : 0,
            left: width > 720 ? 20 : 5,
            right: width > 720 ? 10 : 5,
            bottom: height > 720 ? 0 : 0),
        // margin: EdgeInsets.all(20.0),
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        decoration: BoxDecoration(
          color: widget.isSelected ? MyColors.sidebargrey : Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20.0,
            ),
            Icon(
              widget.icon,
              color: Colors.grey,
              size: 30.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              widget.title,
              style: MyTextStyle.sidebartext3,
            )
          ],
        ),
      ),
    );
  }
}
