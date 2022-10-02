import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double h = 0, h2 = 50, h3 = 80;
  bool hc = false, h2c = false, h3c = false;

  int clrBar = 0;
  Color c1 = Color(0xff0066FF), c2 = Color(0xffFFE5C6);
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        // Here you can write your code for open new view
        if (hc == false) {
          h = h + 5;
        }
        if (h > 100) {
          hc = true;
        }
        if (h <= 5) {
          hc = false;
          clrBar = 0;
        }
        if (hc == true) {
          h = h - 5;
        }

        ////////////////////////
        if (h2c == false) {
          h2 = h2 + 5;
        }
        if (h2 > 100) {
          h2c = true;
        }
        if (h2 <= 5) {
          h2c = false;
          clrBar = 1;
        }
        if (h2c == true) {
          h2 = h2 - 5;
        }

        ////////////////////////
        if (h3c == false) {
          h3 = h3 + 5;
        }
        if (h3 > 100) {
          h3c = true;
        }
        if (h3 <= 5) {
          h3c = false;
          clrBar = 2;
        }
        if (h3c == true) {
          h3 = h3 - 5;
        }
      });
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          // Provide an optional curve to make the animation feel smoother.
                          curve: Curves.fastOutSlowIn,
                          height: h,
                          width: 20,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: clrBar == 0 ? c1 : c2,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          // Provide an optional curve to make the animation feel smoother.
                          curve: Curves.fastOutSlowIn,
                          height: h2,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: clrBar == 1 ? c1 : c2,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          // Provide an optional curve to make the animation feel smoother.
                          curve: Curves.fastOutSlowIn,
                          height: h3,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: clrBar == 2 ? c1 : c2,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Please wait...',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
