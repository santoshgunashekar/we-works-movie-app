import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_works_movie_app/model/user_location.dart';

part 'preferences_key.dart';

abstract class Preferences {
  late SharedPreferences sharedPreferences;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setLocation(UserLocation locationData);

  Future<UserLocation?> getLocation();
}

class PreferencesImpl extends Preferences {
  @override
  Future<UserLocation?> getLocation() async {
    final result = sharedPreferences.getString(PreferencesKey.locationData);
    if (result == null) {
      return null;
    }
    return UserLocation.fromJson(jsonDecode(result) as Map<String, dynamic>);
  }

  @override
  Future<void> setLocation(UserLocation locationData) async {
    sharedPreferences.setString(
      PreferencesKey.locationData,
      jsonEncode(locationData.toJson()),
    );
  }
}
