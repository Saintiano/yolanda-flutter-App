import 'package:flutter/material.dart';

class SizeConfig {
  static double yMargin(BuildContext context, double height) {
    double screenHeight = MediaQuery.sizeOf(context).height / 100;
    return height * screenHeight;
  }

  static double xMargin(BuildContext context, double width) {
    double screenWidth = MediaQuery.sizeOf(context).width / 100;
    return width * screenWidth;
  }

  static double textSize(BuildContext context, double textSize) {
    double screenHeight = MediaQuery.sizeOf(context).height / 100;
    double screenWidth = MediaQuery.sizeOf(context).width / 100;
    if (screenWidth > screenHeight) return textSize * screenHeight;
    return textSize * screenWidth;
  }

  static SizedBox space = const SizedBox(height: 10);

  static SizedBox spaceTextFieldLabel = const SizedBox(height: 4);
  static SizedBox spaceTextFieldHeaderLabel = const SizedBox(height: 8);
}
