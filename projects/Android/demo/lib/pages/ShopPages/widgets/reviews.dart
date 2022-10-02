import 'package:MechGesture/pages/ShopPages/widgets/ReviewCarousel.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: 400.0,
          width: double.infinity,
          color: MyColors.bluishGrey,
          child: ReviewCarousel(),
        ),
        Positioned(
          top: -30,
          left: _width / 2.3,
          child: ClipOval(
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: MyColors.shopButton,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/shopPage/reviewStar.png",
                  fit: BoxFit.fill,
                ),
              ),
              // radius: 25.0,
            ),
          ),
        ),
      ],
    );
  }
}

// Container(
//             height: _height / 13,
//             width: _width / 6,
//             decoration: BoxDecoration(
//               color: MyColors.shopButton,
//               borderRadius: BorderRadius.circular(100),
//               image: DecorationImage(
//                 image: AssetImage('assets/images/shopPage/reviewStar.png'),
//               ),
//             ),
//           ),
