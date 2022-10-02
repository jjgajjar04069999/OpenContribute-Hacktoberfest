import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';

class MembershipPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Membership Plan',
            style: MyTextStyle.headingTitle,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.50,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/membershipBG.png',
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.50,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Text(
                            'Lorem ipsum sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Text(
                            'Lorem ipsum sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Text(
                            'Lorem ipsum sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Buttonmember(),
      ],
    );
  }
}

class Buttonmember extends StatelessWidget {
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
