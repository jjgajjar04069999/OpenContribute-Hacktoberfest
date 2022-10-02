import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'How it works ?',
            style: MyTextStyle.headingTitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 15, bottom: 15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        ImageSlideShow(),
        ButtonHome(),
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
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          itemBuilder: (context, i, realIdx) {
            return Center(
              child: Stack(
                children: [
                  Image.asset(
                    listimg[i],
                    fit: BoxFit.contain,
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Container(
                      color: Color(0xffFDD651),
                    ),
                  ),
                  Container(
                    //padding: EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 20, bottom: 5, top: 15, right: 20),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white),
                            color: Color(0xffFDD651),
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              child: Text(
                                '${_destext[i]}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  height: 1.3,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //   bottom: 12,
                  //   right: 10,
                  //   child: Container(
                  //     height: 30,
                  //     width: 30,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50),
                  //       color: Colors.yellow,
                  //     ),
                  //     child: Icon(
                  //       Icons.arrow_forward,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ));
  }
}

class ButtonHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 60,
      width: double.infinity,
      child: Card(
        color: Color(0xff3F425E),
        elevation: 5,
        child: Center(
          child: Text(
            'Become a professional',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
