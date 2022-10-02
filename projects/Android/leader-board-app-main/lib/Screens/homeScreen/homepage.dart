import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaderboard_app/Provider/currentData.dart';
import 'package:leaderboard_app/theme/mycolors.dart';
import 'package:leaderboard_app/theme/mytextStyles.dart';
import 'package:provider/provider.dart';

class OurHomePage extends StatefulWidget {
  @override
  _OurHomePageState createState() => _OurHomePageState();
}

class _OurHomePageState extends State<OurHomePage> {
  String selectedGameName;

  // These will be used to add a new game with check that it does not already exist then add data to the existing list man
  TextEditingController gameNameG = TextEditingController();
  TextEditingController userNameG = TextEditingController();
  TextEditingController scoreG = TextEditingController();

  // These will be used for adding the score to an existing game
  TextEditingController userNameS = TextEditingController();
  TextEditingController scoreS = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();

    CurrentData _instance = Provider.of<CurrentData>(context, listen: false);
    _instance.onStartUp();
  }

  bool isExpanded = false;

  void _addVehicles(double w, String name) {
    CurrentData _instance = Provider.of<CurrentData>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), //this right here
            child: Container(
              height: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      name,
                      style: MyTextStyle.AddVehicles,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'USER NAME',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: TextField(
                      controller: userNameS,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'Yamaha',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'SCORE',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: scoreS,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //hintText: ,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left:20, right:20),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       //Spacer(flex:1),
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: w * 0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Color(0xffEFEFEF),
                            ),
                            child: Center(
                                child:
                                    Text('CANCEL', style: MyTextStyle.text3)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print("thish sihgt a");
                            if (userNameS.text.isEmpty || scoreS.text.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Enter correct data"),
                                        content: Text(
                                            "You have missed out some information, please check and enter that too."),
                                        actions: [
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("OK"),
                                          )
                                        ],
                                      ));
                            } else {
                              print("Inside the elese");
                              // _instance.addAGame(
                              //   gameName: gameNameG.text,
                              //   score: scoreG.text,
                              //   userName: userNameG.text,
                              // );
                              _instance.updateLeaderBoard(
                                  userName: userNameS.text,
                                  score: scoreS.text,
                                  gameName: selectedGameName);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: w * 0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                              color: MyColors.darkishBlue,
                            ),
                            child: Center(
                                child: Text('SAVE', style: MyTextStyle.text4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _addNewGame(double w, String name) {
    CurrentData _instance = Provider.of<CurrentData>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), //this right here
            child: Container(
              height: w + 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      name,
                      style: MyTextStyle.AddVehicles,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'GAME NAME',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: TextField(
                      controller: gameNameG,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'Yamaha',
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'USER NAME',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: TextField(
                      controller: userNameG,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'Yamaha',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'SCORE',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: TextFormField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: scoreG,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //hintText: ,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left:20, right:20),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       //Spacer(flex:1),
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: w * 0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Color(0xffEFEFEF),
                            ),
                            child: Center(
                                child:
                                    Text('CANCEL', style: MyTextStyle.text3)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print("thish sihgt a");
                            if (gameNameG.text.isEmpty ||
                                userNameG.text.isEmpty ||
                                scoreG.text.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Enter correct data"),
                                        content: Text(
                                            "You have missed out some information, please check and enter that too."),
                                        actions: [
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("OK"),
                                          )
                                        ],
                                      ));
                            } else {
                              print("Inside the elese");
                              _instance.addAGame(
                                gameName: gameNameG.text,
                                score: scoreG.text,
                                userName: userNameG.text,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: w * 0.20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                              color: MyColors.darkishBlue,
                            ),
                            child: Center(
                                child: Text('SAVE', style: MyTextStyle.text4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CurrentData _instance = Provider.of<CurrentData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Games"),
        actions: [
          IconButton(
            icon: Icon(Icons.plus_one),
            onPressed: () {
              // Navigate to the screen that will add a new game to the list of games
              _addNewGame(size.width, "Add Game");
            },
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                //padding: EdgeInsets.all(10.0)
                // alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    "View all your games",
                    style: MyTextStyle.usageAge,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    "Update your game leaderBoard details here",
                    style: MyTextStyle.text5,
                  ),
                ),
              ),
              Consumer<CurrentData>(
                builder: (context, _, Widget child) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:_instance.gamesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ExpansionTile(
                          title: Text(
                            _instance.gamesList[index].name,
                            style: MyTextStyle.dropdown,
                          ),
                          trailing: isExpanded
                              ? Icon(
                                  Icons.keyboard_arrow_up_sharp,
                                  color: MyColors.pureblack,
                                  size: 30.0,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: MyColors.pureblack,
                                  size: 30.0,
                                ),
                          initiallyExpanded: false,
                          onExpansionChanged: (bool expanding) =>
                              setState(() => this.isExpanded = expanding),
                          children: [
                            Column(children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(left:10.0, right: 10),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       ...List<Widget>.generate(motorCycleList.length, (index) =>
                              //           Container(
                              //             padding: EdgeInsets.all(20),
                              //             decoration: BoxDecoration(
                              //               borderRadius: BorderRadius.circular(10),
                              //               border: Border.all(color: Colors.grey, width: 1),
                              //             ),
                              //             width: size.width/2.5,
                              //             child: Column(
                              //               children: [
                              //                 Text(motorCycleList[index].brand, style: MyTextStyle.text4roboto,),
                              //                 Text(motorCycleList[index].model, style: MyTextStyle.text4roboto,),
                              //               ],
                              //             ),
                              //           ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "UserName",
                                            style: MyTextStyle.timing,
                                          ),
                                          Text(
                                            "Score",
                                            style: MyTextStyle.timing,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ...List.generate(
                                        _instance.gamesList[index].scoreBoard
                                            .length, (index2) {
                                      return Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              "#" + "${index2 + 1}",
                                              style: MyTextStyle.appBarTitle,
                                            ),
                                            Expanded(
                                              child: Card(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        _instance
                                                                .gamesList[index]
                                                                .scoreBoard[
                                                            index2]["name"],
                                                        style: MyTextStyle
                                                            .referEarnText,
                                                      ),
                                                      Text(
                                                          _instance
                                                              .gamesList[index]
                                                              .scoreBoard[
                                                                  index2]
                                                                  ["score"]
                                                              .toString(),
                                                          style: MyTextStyle
                                                              .referEarnText),

                                                      //Text("Score", style: MyTextStyle.timing,),
                                                      //Text(_instance.gamesList[index].scoreBoard[index2]["name"], style: MyTextStyle.referEarnText,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              GestureDetector(
                                onTap: () {
                                  selectedGameName =
                                      _instance.gamesList[index].name;
                                  _addVehicles(
                                      size.height / 3 + 70, "Add Score");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: size.width - 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColors.darkGrey),
                                  child: Center(
                                      child: Text(
                                    "Add Score",
                                    style: MyTextStyle.text4white,
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ]),
                          ],
                        ),
                      );
                    },
                  );
                },
                //child: ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
