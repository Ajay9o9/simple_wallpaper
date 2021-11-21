import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ThisThemeOptions implements AppThemeOptions {
  final Color searchBgColor;
  final Color appBarTextColor;
  final Color appbarIconColor;
  final Color placeHolderColor;

  ThisThemeOptions({
    required this.searchBgColor,
    required this.appBarTextColor,
    required this.appbarIconColor,
    required this.placeHolderColor,
  });
}

List<AppTheme> appThemes = [
  AppTheme(
    id: "light_theme",
    description: "Light Theme",
    data: ThemeData.light(),
    options: ThisThemeOptions(
      searchBgColor: Color(0xffe4e7ee),
      appBarTextColor: Colors.black,
      appbarIconColor: Colors.black,
      placeHolderColor: Colors.white54,
    ),
  ),
  AppTheme(
    id: "dark_theme",
    description: "dark Theme 2",
    data: ThemeData.dark(),
    options: ThisThemeOptions(
      searchBgColor: Colors.black38,
      appBarTextColor: Colors.white,
      appbarIconColor: Colors.white,
      placeHolderColor: Colors.black38,
    ),
  ),
];
