import 'package:core/common/styles/text_styles.dart';
import 'package:flutter/material.dart';

enum AppTheme { LightTheme, DarkTheme }

final appThemeData = {
  AppTheme.LightTheme:
      ThemeData(brightness: Brightness.light, primaryColor: Colors.white, fontFamily: 'Ubuntu'),
  AppTheme.DarkTheme:
      ThemeData(brightness: Brightness.dark, primaryColor: Colors.black54, fontFamily: 'Ubuntu'),
};
