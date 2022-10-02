import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  late SharedPreferences preferences;

  init() async {
    preferences = await SharedPreferences.getInstance();
  }

  login(val) {
    preferences.setBool('login', val);
  }
}

PreferenceHelper preferenceHelper = PreferenceHelper();
