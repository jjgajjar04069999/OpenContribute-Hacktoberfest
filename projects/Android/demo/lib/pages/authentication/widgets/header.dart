import 'package:MechGesture/pages/authentication/widgets/bottomwave.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({this.height, this.width, this.text});
  double height, width;
  String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          child: Container(
            width: width,
            height: height,
            child: Image.asset(
              "assets/images/mainBg.jpg",
              height: height,
              width: width,
              fit: BoxFit.fill,
            ),
          ),
          clipper: BottomWaveClipper(),
        ),
        Positioned(
          top: 5,
          left: 5,
          //alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Text('$text', style: Theme.of(context).textTheme.headline1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
