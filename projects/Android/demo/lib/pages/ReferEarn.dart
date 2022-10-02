import 'package:MechGesture/pages/Sidebar/SideDrawer.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:clipboard/clipboard.dart';
//import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';

class ReferEarnPage extends StatefulWidget {
  @override
  _ReferEarnPageState createState() => _ReferEarnPageState();
}

class _ReferEarnPageState extends State<ReferEarnPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Image.asset('assets/images/icons/sidebar.png'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_outlined),
            onPressed: () {},
            color: MyColors.blue_ribbon,
          )
        ],
        title: Text(""),
      ),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //Spacer(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        "Refer & Invite",
                        style: MyTextStyle.usageAge,
                      ),
                    ),
                  ),
                  Image.asset("assets/images/referEarn.png"),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Invite your friends, family, relatives to download \n"
                    "this app, Using this app helps them to locate \n"
                    "nearby mechanics and garages/service \n"
                    "centers to repair their vehicles. Your little help\n"
                    "makes their lives easy and comfortable",
                    style: MyTextStyle.referEarnText,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Your Referal Code",
                    style: MyTextStyle.dropdown,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                    width: size.width / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "ASXG12ASD",
                          style: MyTextStyle.usageAgeHeading,
                        ),
                        Container(
                          height: 25,
                          color: Colors.blue,
                          width: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            FlutterClipboard.copy("ASXG12ASD").then(( value ) =>
                                print('copied'));

                            final snackBar = SnackBar(
                            content: Text('Copied to Clipboard'),
                            action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                            ),
                            );
                            //Scaffold.of(context).showSnackBar(snackBar);
                            _scaffoldKey.currentState.showSnackBar(snackBar);


                          },
                            child: Text(
                          "COPY",
                          style: MyTextStyle.copy,
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //Spacer(),
                  Text(
                    "Or share your Referal Code via",
                    style: MyTextStyle.text3,
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: MyColors.blue_ribbon),
                        ),
                        child: Image.asset("assets/images/icons/whatsapp.png"),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: MyColors.blue_ribbon),
                        ),
                        child: Image.asset("assets/images/icons/facebook.png"),
                      ),
                      Spacer(flex: 1),
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: MyColors.blue_ribbon),
                        ),
                        child: Image.asset("assets/images/icons/twitter.png"),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
