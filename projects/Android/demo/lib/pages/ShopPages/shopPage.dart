import 'package:MechGesture/models/garage/garageModel.dart';
import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';
import 'package:MechGesture/pages/ShopPages/shopConfirmPage.dart';
import 'package:MechGesture/pages/ShopPages/widgets/description.dart';
import 'package:MechGesture/pages/ShopPages/widgets/details.dart';
import 'package:MechGesture/pages/ShopPages/widgets/reviews.dart';
import 'package:MechGesture/pages/ShopPages/widgets/ImageCarousel.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';

import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  List services = [
    MechanicServices(name: "Denting & Painting", price: 40),
    MechanicServices(name: "Batteries", price: 200),
    MechanicServices(name: "Spa & Cleaning", price: 500),
    MechanicServices(name: "AC Services & repair", price: 250),
    MechanicServices(name: "Tyres & wheel repair", price: 70),
    MechanicServices(name: "Custom Service", price: 500),
    MechanicServices(name: "Detailing Service", price: 1000),
    MechanicServices(name: "Windshields & Glass", price: 70),
    MechanicServices(name: "Lights & Fitments", price: 120),
  ];
  OurGarage allData;
  ShopPage({this.allData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.purewhite,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: MyColors.pureblack,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShopConfirmPage(
                      allData: allData,
                    ))),
        child: Container(
          height: 60,
          color: MyColors.shopButton,
          child: Center(
            child: Text(
              'CONTINUE',
              style: MyTextStyle.text4,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              bottom: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Details(
                  shopName: allData.name,
                  profileImg: allData.images.profileImages[0],
                ),
                ImageCarousel(
                  imgList: allData.images.carosuelImgs,
                ),
                Description(description: allData.aboutUs),
                Reviews(),
                SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shop Services", style: MyTextStyle.headingTitle),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Repairement & \n Services",
                            style: MyTextStyle.dropdown,
                          ),
                          Text(
                            "Price Rate",
                            style: MyTextStyle.dropdown,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(width: 2, color: MyColors.yellowish),
                          //color: MyColors.yellowish,
                        ),
                        child: Column(
                          children: [
                            ...List.generate(allData.products.length, (index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 7),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      allData.products[index].name,
                                      style: MyTextStyle.report_text,
                                    ),
                                    Text(
                                      "₹" +
                                          allData.products[index].price
                                              .toString(),
                                      style: MyTextStyle.sidebarbuttontext1,
                                    )
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
