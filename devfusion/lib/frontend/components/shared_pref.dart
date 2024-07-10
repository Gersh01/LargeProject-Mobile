import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future writeToken({required String jwtToken}) async {
    print("WRITE TOKEN START");
    final SharedPreferences pref = await SharedPreferences.getInstance();

    bool isSaved = await pref.setString("token", jwtToken);
    // debugPrint(isSaved.toString());
    print("WRITE TOKEN END");
  }

  Future<String?> readToken() async {
    print("READ TOKEN START");
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? value = pref.getString("token");
    if (value != null) {
      debugPrint(value.toString());
    }
    print("READ TOKEN END");
    return value;
  }

  Future<bool> removeToken() async {
    print("REMOVE TOKEN START");
    final SharedPreferences pref = await SharedPreferences.getInstance();

    bool isCleared = await pref.setString("token", "");

    print("REMOVE TOKEN END");
    return isCleared;
  }
}
