import 'package:MechGesture/values/MyColors.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int index = 0;
  PageController controller = PageController(initialPage: 0);

  var align = [Alignment.centerLeft, Alignment.center, Alignment.centerRight];
  var clr = [
    Colors.black,
    MyColors.blue_ribbon,
    Colors.orange[200],
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: controller,
          onPageChanged: (val) {
            setState(() {
              index = val;
            });
          },
          children: [
            SplashStructure(
              title: 'Locate mechanics',
              description:
                  'Connect with the mechanics near by you, ready to repair your vehicle.',
              page: 1,
            ),
            SplashStructure(
              title: 'Inventory Products',
              description:
                  'Buy affortable vehicle maintanence product in minimum & affortable price rate.',
              page: 2,
            ),
            SplashStructure(
              title: '100% Transparency',
              description:
                  'We assure you to deliver great service experience, all the mechanics are professional in their respective field.',
              page: 3,
            ),
          ],
        ),
        Positioned(
            left: 20,
            bottom: 20,
            child: index != 0
                ? MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.grey[200],
                    onPressed: () {
                      controller.jumpToPage(index - 1);
                    },
                    child: Text(
                      'PREV',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  )
                : Container()),
        Positioned(
          right: 20,
          bottom: 20,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () {
              if (index == 2)
                Navigator.of(context).popAndPushNamed('/loginPage');
              else
                controller.jumpToPage(index + 1);
            },
            color: MyColors.blue_ribbon,
            child: Text(
              'Next',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 80),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 15,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: align[index],
                child: Container(
                  height: 15,
                  width: MediaQuery.of(context).size.width * 0.3 / 3,
                  decoration: BoxDecoration(
                      color: clr[index],
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SplashStructure extends StatelessWidget {
  SplashStructure({this.description, this.title, this.page});
  String title, description;
  int page;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: Container(
        // color: Colors.green,
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Center(
          child: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: _height * 0.4,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/splashScreen/p$page.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        '$title',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 25, top: 5),
                        child: Text(
                          '$description',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.10,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 25,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/loginPage');
                  },
                  child: Text(
                    'SKIP',
                    style: TextStyle(color: MyColors.text2, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
