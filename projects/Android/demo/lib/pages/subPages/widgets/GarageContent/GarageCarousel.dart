import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class GarageCarousel extends StatefulWidget {

  @override
  _GarageCarouselState createState() => _GarageCarouselState();
}

class _GarageCarouselState extends State<GarageCarousel> {
  List imgList = [
    "https://images.unsplash.com/photo-1598420725320-50be9fb5e65d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1597404294360-feeeda04612e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1147&q=80",
    "https://images.unsplash.com/photo-1485291571150-772bcfc10da5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1100&q=80",
  ];


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: Carousel(
        dotSize: 8.0,
        dotSpacing: 15.0,
        dotColor: Colors.grey,
        indicatorBgPadding: 20.0,
        dotBgColor: Colors.transparent,
        dotVerticalPadding: 5.0,
        dotPosition: DotPosition.bottomRight,
        boxFit: BoxFit.cover,
        autoplay: true,
        // animationCurve: Curves.fastLinearToSlowEaseIn,
        images: imgList.map((imgUrl) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
