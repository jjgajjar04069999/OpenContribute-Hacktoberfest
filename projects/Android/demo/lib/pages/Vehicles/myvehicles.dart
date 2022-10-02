import 'package:MechGesture/data/data.dart';
import 'package:MechGesture/pages/Sidebar/SideDrawer.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class MyVehicles extends StatefulWidget {
  @override
  _MyVehiclesState createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isExpanded = false;

  void _addVehicles(double w, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), //this right here
            child: Container(
              height: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      name,
                      style: MyTextStyle.AddVehicles,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'BRAND NAME',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'Yamaha',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'MODEL NAME',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //hintText: ,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left:20, right:20),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       //Spacer(flex:1),
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: w * 0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Color(0xffEFEFEF),
                            ),
                            child: Center(
                                child:
                                    Text('CANCEL', style: MyTextStyle.text3)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: w * 0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                              color: MyColors.darkishBlue,
                            ),
                            child: Center(
                                child: Text('SAVE', style: MyTextStyle.text4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,elevation: 0,
        leading: GestureDetector(
          onTap: () {
            print("------------------------------------");
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              Container(
                //padding: EdgeInsets.all(10.0)
                // alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    "My Vehicles",
                    style: MyTextStyle.usageAge,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    "Store your vehicles details here",
                    style: MyTextStyle.text5,
                  ),
                ),
              ),
              ExpansionTile(
                title: Text(
                  "Motorcycles",
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
                initiallyExpanded: true,
                onExpansionChanged: (bool expanding) =>
                    setState(() => this.isExpanded = expanding),
                children: [
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List<Widget>.generate(
                            motorCycleList.length,
                            (index) => Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              width: size.width / 2.5,
                              child: Column(
                                children: [
                                  Text(
                                    motorCycleList[index].brand,
                                    style: MyTextStyle.text4roboto,
                                  ),
                                  Text(
                                    motorCycleList[index].model,
                                    style: MyTextStyle.text4roboto,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        _addVehicles(size.height / 3 + 70, "Add Motorcycle");
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: size.width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.darkGrey),
                        child: Center(
                            child: Text(
                          "Add Motorcycle",
                          style: MyTextStyle.text4white,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Cars",
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
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List<Widget>.generate(
                            carsList.length,
                            (index) => Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              width: size.width / 2.5,
                              child: Column(
                                children: [
                                  Text(
                                    carsList[index].brand,
                                    style: MyTextStyle.text4roboto,
                                  ),
                                  Text(
                                    carsList[index].model,
                                    style: MyTextStyle.text4roboto,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        _addVehicles(size.height / 3 + 70, "Add Car");
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: size.width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.darkGrey),
                        child: Center(
                            child: Text(
                          "Add Car",
                          style: MyTextStyle.text4white,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Trucks",
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
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List<Widget>.generate(
                            trucksList.length,
                            (index) => Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              width: size.width / 2.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    trucksList[index].brand,
                                    style: MyTextStyle.text4roboto,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    trucksList[index].model,
                                    style: MyTextStyle.text4roboto,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        _addVehicles(size.height / 3 + 70, "Add Truck");
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: size.width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.darkGrey),
                        child: Center(
                            child: Text(
                          "Add Truck",
                          style: MyTextStyle.text4white,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
