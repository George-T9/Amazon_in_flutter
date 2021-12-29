import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      backgroundColor: Colors.deepPurple,
      primaryColor: Colors.deepPurple,
      secondaryHeaderColor: Colors.deepPurple[150],
      brightness: Brightness.light);

  static ThemeData darkTheme(BuildContext context) => ThemeData();
}
