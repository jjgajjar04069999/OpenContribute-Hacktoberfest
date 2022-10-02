import 'package:MechGesture/currentstate/currentState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomListTile.dart';
import 'navigation_model.dart';
import 'package:MechGesture/provider/selectServices.dart';
class TileContainer extends StatefulWidget {
  @override
  _TileContainerState createState() => _TileContainerState();
}

class _TileContainerState extends State<TileContainer> {
  //int currentSelectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //drawerId();
    print("-----------*************");
    //print(currentSelectedIndex);
  }

  // drawerId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     //currentSelectedIndex = (prefs.getInt('IndexValue') ?? 0);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SelectServices _instanceDrawer = Provider.of(context, listen: false);
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, counter) {
          return CustomListTile(
            onTap: () async {
              if (navigation_item[counter].path != null) {
                // if (navigation_item[counter].path == "Login") {
                //   String retVal = await _instance.signOut();
                //   if (retVal == "success") {
                //     // Navigate the user to the Login Page
                //     Navigator.pushNamedAndRemoveUntil(
                //         context, "/register", (route) => false);
                //   }
                // }
                // else {
                //   // Navigator.pushNamedAndRemoveUntil(context,
                //   //     navigation_item[counter].path, (route) => false);
                //
                //   // Navigator.pushNamedAndRemoveUntil(context,
                //   //     navigation_item[counter].path, (route) => false);
                //   String retVal = await _instance.signOut();
                //   if (retVal == "success") {
                //     // Navigate the user to the Login Page
                //     Navigator.pushNamedAndRemoveUntil(
                //         context, "/register", (route) => false);
                //   }
                //   // Navigator.pushReplacementNamed(
                //   //     context, navigation_item[counter].path);
                //   print("----------");
                //   //print(currentSelectedIndex);
                // }
              }
              setState(() {
                _instanceDrawer.selectedDrawerIndex = counter;
                print("**********");
                Navigator.pushNamed(context, navigation_item[counter].path);
                //print(currentSelectedIndex);
                //SharedPreferences prefs = await SharedPreferences.getInstance();
                //prefs.setInt('IndexValue', currentSelectedIndex);
              });
            },
            isSelected: _instanceDrawer.selectedDrawerIndex == counter,
            title: navigation_item[counter].title,
            icon: navigation_item[counter].icon,
          );
        },
        itemCount: navigation_item.length,
      ),
    );
  }
}
