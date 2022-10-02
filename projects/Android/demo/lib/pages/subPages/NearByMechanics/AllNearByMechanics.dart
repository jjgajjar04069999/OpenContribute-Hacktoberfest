import 'package:MechGesture/data/data.dart';
import 'package:MechGesture/pages/HomePage/widgets/SearchBox.dart';
import 'package:MechGesture/pages/subPages/widgets/mechanicListTile/mechanicListTileCustom.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class AllNearByMechanics extends StatefulWidget {
  @override
  _AllNearByMechanicsState createState() => _AllNearByMechanicsState();
}

class _AllNearByMechanicsState extends State<AllNearByMechanics> {
  var typeSelected = [true, false, false]; //car, truck, motorcycle respectively
  var sortSelected = [true, false]; //nearest, farthest respectively

  void _showFilters(double w) {
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
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: Icon(
                          Icons.close_sharp,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type',
                          style: MyTextStyle.headingTitle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    typeSelected[0] = !typeSelected[0];
                                  });
                                },
                                child: FilterButton(
                                  text: 'Car',
                                  status: typeSelected[0],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    typeSelected[1] = !typeSelected[1];
                                  });
                                },
                                child: FilterButton(
                                  text: 'Truck',
                                  status: typeSelected[1],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    typeSelected[2] = !typeSelected[2];
                                  });
                                },
                                child: FilterButton(
                                    status: typeSelected[2],
                                    text: 'Motorcycle'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Sort',
                          style: MyTextStyle.headingTitle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sortSelected[0] = !sortSelected[0];
                                  });
                                },
                                child: FilterButton(
                                  text: 'Nearest',
                                  status: sortSelected[0],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sortSelected[1] = !sortSelected[1];
                                  });
                                },
                                child: FilterButton(
                                    status: sortSelected[1], text: 'Farthest'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: w * 0.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Color(0xffEFEFEF),
                          ),
                          child: Center(
                              child: Text('RESET', style: MyTextStyle.text3)),
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
                                child: Text('APPLY', style: MyTextStyle.text4)),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Image.asset("assets/images/icons/backArrow.png"),
          ),
        ),
        title: Text("Near By Mechanics", style: MyTextStyle.appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              SearchBox(),
              //Sized

              Padding(
                padding: EdgeInsets.only(left: 13, right: 13, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Results",
                      style: MyTextStyle.headingTitle,
                    ),
                    FlatButton(
                      onPressed: () {
                        var w = MediaQuery.of(context).size.height / 3 + 50;
                        _showFilters(w);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(width: 1, color: Color(0xFFD8D8D8))),
                      child: Text(
                        "Filters",
                        style: MyTextStyle.nameStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: mechanicList.length,
                  itemBuilder: (context, index) {
                    //print(mechanicList[index].type);
                    return Container(
                      //width: 100,
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: OurMechanicListTileCustom(
                        distanceAway: mechanicList[index].distanceAway,
                        name: mechanicList[index].name,
                        sendToFunction: mechanicList[index],
                        type: mechanicList[index].type,
                        vehicleServices: mechanicList[index].vehiclesServices,
                        //mechanicList[index].distanceAway,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  FilterButton({@required this.text, @required this.status});
  bool status;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            !status ? Border.all(width: 1, color: MyColors.blue_ribbon) : null,
        color: status ? MyColors.darkishBlue : Colors.white,
      ),
      child: Center(
          child: Text(
        '$text',
        style: status ? MyTextStyle.text4 : MyTextStyle.text3,
      )),
    );
  }
}
