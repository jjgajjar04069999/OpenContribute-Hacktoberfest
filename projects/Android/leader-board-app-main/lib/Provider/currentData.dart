import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:leaderboard_app/models/GameModel.dart';

class CurrentData extends ChangeNotifier {
  Box gameBox;
  List<dynamic> gamesList = [
    GameModel(
        name: "PokeMonData",
        scoreBoard: [
          {
            "name": "1234",
            "score" : "10000",
          },
          {
            "name": "134",
            "score" : "1020",
          },
          {
            "name": "124",
            "score" : "1010",
          }
        ]
    ),
    GameModel(
        name: "Clash Of Clans",
        scoreBoard: [
          {
            "name": "1234",
            "score" : "19000",
          },
          {
            "name": "134",
            "score" : "1020",
          },
          {
            "name": "124",
            "score" : "1010",
          }
        ]
    )
  ];
  onStartUp() async{
    // this function will run in the beginning and fetch all the data from hive
    gameBox = await Hive.openBox("games");
    gamesList = gameBox.get("userData");
    if(gamesList == null) {
      gamesList = [
        GameModel(
            name: "PokeMonData",
            scoreBoard: [
              {
                "name": "1234",
                "score" : "10000",
              },
              {
                "name": "134",
                "score" : "1020",
              },
              {
                "name": "124",
                "score" : "1010",
              }
            ]
        ),
        GameModel(
            name: "Clash Of Clans",
            scoreBoard: [
              {
                "name": "1234",
                "score" : "19000",
              },
              {
                "name": "134",
                "score" : "1020",
              },
              {
                "name": "124",
                "score" : "1010",
              }
            ]
        )
      ];
    }
    //print(gamesList);
    //print(gamesList[0].name);
    //gameBox.put("userData", gamesList);
  }


  addAGame({String gameName, String userName, String score}) {
    int intScore;
    bool duplicateGame = false;
    intScore = int.parse(score);
    print(intScore);

    gamesList.forEach((element) {
      if(element.name == gameName) {
        print("this is a duplicate Game halt all other process and add the data to the existing game scoreBoard");
        updateLeaderBoard(gameName: gameName, userName: userName, score: score);
        duplicateGame = true;
      }
    });

    if(duplicateGame == false){
      gamesList.add(
          GameModel(
            name: gameName,
            scoreBoard: [{
              "name":userName,
              "score":score
            }],
          )
      );
      gameBox.put("userData", gamesList);
      print(gamesList);

      notifyListeners();
    }
  }

  updateLeaderBoard({String gameName, String userName, String score}) {
    gamesList.forEach((element) {
      if(element.name == gameName) {
        print("Found the game that is to be updated");
        if(element.scoreBoard.length <10) {
          element.scoreBoard.add({
            "name":userName,
            "score":score,
          });
          List<int> scores=[];

          element.scoreBoard.forEach((el) {
            scores.add(int.parse(el["score"]));
          });
          scores.sort();
          List<Map> replace = [];
          bool active = true;
          scores.forEach((elemet) {
            active = true;
            element.scoreBoard.forEach((hj) {
              if(int.parse(hj["score"]) == elemet && active == true) {
                active = false;
                replace.insert(0, {
                  "name":hj["name"],
                  "score":elemet.toString(),
                });
              }
            });
          });

          element.scoreBoard = replace;
          print(element.scoreBoard);

          //someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
          print(scores);
          //print(element2.scoreBoard["score"]);
          //scores.add(int.parse(element2.scoreBoard["score"]));
          print(scores);
        } else{
          // return this message to the user that the maximum scores that can be added are 10
        }
      }
    });
    gameBox.put("userData", gamesList);

    notifyListeners();
  }


}
