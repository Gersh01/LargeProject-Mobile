import 'package:flutter/material.dart';
import '../themes/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;

  ThemeData? get themeData => _themeData;

  set themeData(ThemeData? themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    if (_themeData == null) {
      themeData = (isDark) ? darkMode : lightMode;
    } else if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  // void setToggleTheme(ThemeData themeData) {
  //   _themeData = themeData;
  // }
}
