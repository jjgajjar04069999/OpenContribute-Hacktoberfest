import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PopularService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 15),
          child: Text(
            'Popular Services',
            style: MyTextStyle.headingTitle,
          ),
        ),
        ImageSlideShow(),
      ],
    );
  }
}

class ImageSlideShow extends StatelessWidget {
  final listimg = [
    'assets/images/popularService/img1.png',
    'assets/images/popularService/img1.png',
    'assets/images/popularService/img1.png',
  ];
  final _destext = [
    "This service includes all\ntypes of car repair with\nminimum price rates",
    "This service includes all\ntypes of car repair with\nminimum price rates",
    "This service includes all\ntypes of car repair with\nminimum price rates",
  ];

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;

    return Container(
        margin: EdgeInsets.all(10),
        height: _height * 0.25,
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: 3,
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          itemBuilder: (context, i, realIdx) {
            return Center(
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        listimg[i],
                        fit: BoxFit.cover,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        gradient: LinearGradient(
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
                            colors: [
                              Color(0xff25273F),
                              Colors.indigo.withOpacity(0.0),
                            ],
                            stops: [
                              0.0,
                              1.0
                            ])),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Car Repair',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 3),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 10),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              child: Text(
                                '${_destext[i]}',
                                style: TextStyle(height:1.3 ,
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.yellow,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
