import 'package:hive/hive.dart';

part 'GameModel.g.dart';

@HiveType(typeId: 111, adapterName: "GameModelHiveGen")


class GameModel{

  @HiveField(0)
  String name;
  
  @HiveField(1)
  List<Map> scoreBoard; // this map will contain
  // 1. name of the user, 2. Score given by the user

  GameModel({this.name,this.scoreBoard});
}