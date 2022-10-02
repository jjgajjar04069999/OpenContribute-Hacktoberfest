import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/pages/AvailableServices/localWidgets/vehicleCard.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCarBrand extends StatefulWidget {
  List brands = [];

  SelectCarBrand({this.brands});

  @override
  _SelectCarBrandState createState() => _SelectCarBrandState();
}

class _SelectCarBrandState extends State<SelectCarBrand> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    _instance.selectedBrand = widget.brands[0]['text'].toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          _instance.vehicleType,
          style: MyTextStyle.appBarTextSupporting,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            //mainAxisSize: ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Expanded(child:Text("thios sthat ")),
              Container(
                child: Center(
                    child: Image.asset(
                  "assets/images/available_service/carIcons/header.png",
                  width: size.width - 100,
                  height: size.height / 4,
                )),
              ),
              Container(padding: EdgeInsets.all(20),
                child: Text(
                  "Select a ${_instance.vehicleType} brand",
                  style: MyTextStyle.availableServicesHeading,
                ),
              ),
              Container(
                //height: size.height/2,
                child: GridView.count(
                  shrinkWrap: true,
                  //scrollDirection: ,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      ((size.height / 6) - 10) / ((size.width / 3) - 10),
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 3,
                  children: List.generate(widget.brands.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          _instance.selectedBrand =
                              widget.brands[index]["text"].toLowerCase();
                        });
                      },
                      child: VehicleCardCustom(
                        colorC: selectedIndex == index
                            ? MyColors.lightYellowish
                            : Colors.white,
                        image_path: widget.brands[index]["imageL"],
                        card_text: widget.brands[index]["text"],
                      ),
                    );
                  }),
                ),
              ),
              //Spacer(flex:2),
              SizedBox(
                height: size.height / 15,
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Padding(
              //     padding: EdgeInsets.only(right: 20),
              //     child: Container(
              //       padding: EdgeInsets.all(20),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(100),
              //         color: MyColors.available_servics,
              //       ),
              //       child: Icon(Icons.forward, color: MyColors.yellowish,),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.available_servics,
        ),
        child: GestureDetector(
            onTap: () {
              //_instance.fetchParticularGarages();
              Navigator.pushNamed(context, "/nearByGarageAll");
            },
            child: Icon(
              Icons.arrow_forward,size: 30,
              color: MyColors.yellowish,
            )),
      ),
    );
  }
}
