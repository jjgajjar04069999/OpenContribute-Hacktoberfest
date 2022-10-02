import 'package:MechGesture/data/data.dart';
import 'package:MechGesture/models/garage/garageModel.dart';
import 'package:MechGesture/models/mechanicModel.dart';
import 'package:MechGesture/pages/Usage/widgets/CustomCard.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

import '../Sidebar/SideDrawer.dart';

class UsagePage extends StatefulWidget {
  final OurGarage garage;
  final OurMechanic mechanic;

  const UsagePage({Key key, this.garage, this.mechanic}) : super(key: key);

  @override
  _UsagePageState createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(elevation: 0,
        backgroundColor: MyColors.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(11.5),
            child: Image.asset('assets/images/icons/sidebar.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_outlined),
            onPressed: () {},
            color: MyColors.blue_ribbon,
          )
        ],
        title: Text(""),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Usage",
                    style: MyTextStyle.usageAge,
                  ),
                ),
                ExpansionTile(
                  title: Text(
                    "Mechanics",
                    style: MyTextStyle.dropdown,
                  ),
                  trailing: isExpanded
                      ? Icon(
                          Icons.keyboard_arrow_up_sharp,
                          color: MyColors.pureblack,
                          size: 30.0,
                        )
                      : Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: MyColors.pureblack,
                          size: 30.0,
                        ),
                  initiallyExpanded: false,
                  onExpansionChanged: (bool expanding) =>
                      setState(() => this.isExpanded = expanding),
                  children: [
                    CustomCard(
                      name: mechanicList[0].name,
                      type: "Mechnaic",
                      date: "12-10-2019",
                      amount: 520.0,
                      button_text1: "Details",
                      button_text2: "Report",
                      // path1: "/reportPage",
                      path2: '/reportPage',
                    ),
                    CustomCard(
                      name: mechanicList[1].name,
                      type: "Mechnaic",
                      date: "12-10-2019",
                      amount: 650.0,
                      button_text1: "Details",
                      button_text2: "Report",
                      // path1: "/reportPage",
                      path2: '/reportPage',
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                ExpansionTile(
                  title: Text(
                    "Garage & Service Center",
                    style: MyTextStyle.dropdown,
                  ),
                  trailing: isExpanded
                      ? Icon(
                          Icons.keyboard_arrow_up_sharp,
                          color: MyColors.pureblack,
                          size: 30.0,
                        )
                      : Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: MyColors.pureblack,
                          size: 30.0,
                        ),
                  initiallyExpanded: false,
                  onExpansionChanged: (bool expanding) =>
                      setState(() => this.isExpanded = expanding),
                  children: [
                    CustomCard(
                      name: "garageList[0].name",
                      type: "Garage",
                      date: "12-10-2019",
                      amount: 250.0,
                      button_text1: "Details",
                      button_text2: "Report",
                      // path1: "/re",
                      path2: '/reportPage',
                    ),
                    CustomCard(
                      name: "garageList[1].nam",
                      type: "Garage",
                      date: "12-10-2019",
                      amount: 9000.0,
                      button_text1: "Details",
                      button_text2: "Report",
                      // path1: "/reportPage",
                      path2: '/reportPage',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
