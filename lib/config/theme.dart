import 'package:flutter/material.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/30

final darkThemeData = ThemeData.dark();

final lightThemeData = ThemeData();

bool isDarkMode(BuildContext context) {
  final currentBrightness = Theme.of(context).brightness;
  return currentBrightness == Brightness.dark;
}