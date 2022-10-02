import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'Provider/currentData.dart';
import 'Screens/homeScreen/homepage.dart';
import 'models/GameModel.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(GameModelHiveGen());   // this will store the stats things

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentData>(create: (context) =>CurrentData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OurHomePage(),
      ),
    );
  }
}
