
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  static const buttonGradient = LinearGradient(
    colors: [
      AppColors.secondary,
      AppColors.primary,
    ],
  );
  static const progressBar = LinearGradient(
    colors: [
      AppColors.primary,
      AppColors.secondary,
      AppColors.primary,
    ],
  );
  static final landingPage = LinearGradient(colors: [
    AppColors.fullGradient,
    AppColors.primary,
    AppColors.transparentGradient.withOpacity(0),
    //  Colors.transparent
  ], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient getStartedPageGradient = const LinearGradient(
      colors: [AppColors.gray, AppColors.altYellow],
      begin: FractionalOffset(0.0, 0.0),
      end: FractionalOffset(1.9, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
}