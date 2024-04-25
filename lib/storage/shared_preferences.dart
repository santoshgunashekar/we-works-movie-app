import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_key.dart';

abstract class Preferences {
  late SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}

class PreferencesImpl extends Preferences {}
