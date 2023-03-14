// ignore_for_file: depend_on_referenced_packages

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<void> hasAlreadyRegisteredToFirebase(
      {required bool hasRegistered}) async {
    if (hasRegistered) {
      await preferences?.setInt("hasAlreadyRegisteredToFirebase", 1);
      return;
    }
    await preferences?.setInt("hasAlreadyRegisteredToFirebase", 0);
  }

  static bool getRegistrationStatus() {
    int? index = preferences!.getInt("hasAlreadyRegisteredToFirebase");

    if (index == null) {
      return false;
    }
    return true;
  }

}
