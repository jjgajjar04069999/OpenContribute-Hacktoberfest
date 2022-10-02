import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  List imgList;

  ImageCarousel({this.imgList});
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  // List imgList = [
  //   "https://images.unsplash.com/photo-1598420725320-50be9fb5e65d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
  //   "https://images.unsplash.com/photo-1597404294360-feeeda04612e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
  //   "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1147&q=80",
  //   "https://images.unsplash.com/photo-1485291571150-772bcfc10da5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1100&q=80",
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: CarouselSlider.builder(
        itemCount: widget.imgList.length,
        options: CarouselOptions(
          // height: 400,
          autoPlay: true,
          aspectRatio: 2.0,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 2000),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        itemBuilder: (context, index, realIdx) {
          return Container(
            child: Center(
              child:
                  Image.network(widget.imgList[index], fit: BoxFit.cover, width: 1000),
            ),
          );
        },
      ),
    );

    // return CarouselSlider(
    //   items: imgList.length,
    //   options: CarouselOptions(
    //     height: 400,
    //     aspectRatio: 16 / 9,
    //     viewportFraction: 0.8,
    //     initialPage: 0,
    //     enableInfiniteScroll: true,
    //     reverse: false,
    //     autoPlay: true,
    //     autoPlayInterval: Duration(seconds: 3),
    //     autoPlayAnimationDuration: Duration(milliseconds: 800),
    //     autoPlayCurve: Curves.fastOutSlowIn,
    //     enlargeCenterPage: true,
    //     scrollDirection: Axis.horizontal,
    //   ),
    // );
  }
}
