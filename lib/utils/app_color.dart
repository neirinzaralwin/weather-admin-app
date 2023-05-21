import 'package:flutter/material.dart';

class AppColor {
  static const Color swatch = Color(0xff000000);
  static const Color primaryColor = Color.fromARGB(255, 0, 45, 129);
  static const Color secondaryColor = Color.fromARGB(255, 51, 102, 255);
  static const Color primaryColorLight = Color.fromARGB(255, 140, 169, 255);
  static const Color mildGreen = Color.fromARGB(255, 205, 221, 213);
  static const Color extremeGreen = Color.fromARGB(255, 0, 252, 8);
  static const Color mintGreen = Color.fromARGB(255, 38, 187, 172);
  static const Color iosGreen = Color.fromARGB(255, 20, 232, 87);
  static const Color blueColor = Color.fromARGB(255, 4, 165, 226);
  static const Color buttonColor = Color(0xffba7967);
  static const Color redColor = Color.fromARGB(255, 189, 44, 4);
  static const Color mildRed = Color.fromARGB(255, 230, 205, 198);
  static const Color scaffoldBackgroundColor = Color(0xffEEEEEE);
  static const Color activeIconColorLight = Colors.white;
  static const Color disableIconColorLight = Colors.white54;
  static const Color activeIconColorDark = Colors.black;
  static const Color disableIconColorDark = Colors.black54;
}

const Gradient g1 = LinearGradient(
  colors: [AppColor.secondaryColor, AppColor.primaryColor],
);
