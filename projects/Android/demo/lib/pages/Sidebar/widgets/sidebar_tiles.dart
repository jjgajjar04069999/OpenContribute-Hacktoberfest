import 'package:MechGesture/currentstate/currentState.dart';
import 'package:flutter/material.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:provider/provider.dart';

class Sidebar_tiles extends StatefulWidget {
  Sidebar_tiles({this.text, this.path, this.icons, this.focus});

  String text, path;
  final IconData icons;

  bool focus;

  @override
  _Sidebar_tilesState createState() => _Sidebar_tilesState();
}

class _Sidebar_tilesState extends State<Sidebar_tiles> {
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of(context, listen: false);
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    double width = mediaQueryData.size.width;
    double height = mediaQueryData.size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: height > 720 ? 0 : 0,
          left: width > 720 ? 10 : 5,
          right: width > 720 ? 10 : 5,
          bottom: height > 720 ? 0 : 0),
      child: GestureDetector(
        onTap: () async{
          if(widget.path!=null) {
            if(widget.path == "Login") {
              String retVal = await _instance.signOut();
              if (retVal == "success") {
                // Navigate the user to the Login Page
                Navigator.pushNamedAndRemoveUntil(
                    context, "/loginPage", (route) => false);
              }
            } else{
              setState(() {
               widget.focus = !widget.focus;
              });
              Navigator.pushNamedAndRemoveUntil(
                  context, widget.path, (route) => false);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.focus ? MyColors.sidebargrey : Colors.transparent,
            // border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: ListTile(
            autofocus: widget.focus,
            // tileColor: Colors.grey[400],
            title: Text(widget.text, style: MyTextStyle.sidebartext3),
            leading: Icon(widget.icons),
            enabled: true,

          ),
        ),
      ),
    );
  }
}
