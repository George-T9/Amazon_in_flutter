import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    primarySwatch: Colors.amber,
    backgroundColor: Colors.amber,
    primaryColor: Colors.amberAccent,
    secondaryHeaderColor: Colors.amberAccent[150],
    brightness: Brightness.light



  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(

  );
}