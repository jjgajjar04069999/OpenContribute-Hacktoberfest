import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerForCategories extends StatelessWidget {
  double _height;
  double _width;


  ShimmerForCategories(this._height, this._width);
  int _offSet = 0;
  int _time = 800;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: _height,
      child: ListView.builder(
        //shrinkWrap: true,
        //scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 6, // list length
        itemBuilder: (context, index) {
          print("Rebuilding ...........................................");
          _offSet +=20;
          _time = 800+_offSet;
          return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey[300],
            period: Duration(milliseconds: _time),

            child: Column(
              children: [
                Container(
                  height: _height,
                  width: _width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    //borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          );
        },
      ),
    );
  }
}
