//import 'package:final_wala_final_pka/screens/homeScreen%20type%202/provider/addToCartProvider.dart';
import 'package:MechGesture/currentstate/currentState.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class ScreenDisableCode extends StatefulWidget {
  @override
  _ScreenDisableCodeState createState() => _ScreenDisableCodeState();
}

class _ScreenDisableCodeState extends State<ScreenDisableCode> {
  @override
  Widget build(BuildContext context) {
    print("This is rebuidling -=-=--=-=-=============================================");
    Size size = MediaQuery.of(context).size;
    double x= 0;
    double y=0;

    //AddToCartProvider _isScreenDisable = Provider.of<AddToCartProvider>(context, listen:false);

    // we still have to provide the notify listen in the cart provider in order for this to refresh the value a
    // and check if any change has  been made or not
    var _isScreenDisable = context.select<CurrentState, bool>((value) => value.isScreenDisable);
    return Visibility(
      visible: _isScreenDisable,
      child: Stack(
          children:[
            Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: size.height * 2,
            ),
            Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 600),
                transform: Matrix4.translationValues(x, y, 0),
                height: 1500,
                child: Lottie.asset(
                    "assets/Lottie/24064-food-squeeze-with-burger-and-hot-dog (1).json"),
              ),
            )
          ]
      ),
    );
  }
}
