

import 'package:flutter/material.dart';
import 'package:yolanda/styles/app_colors.dart';
import 'package:yolanda/styles/system_styles.dart';

ThemeData lightTheme2 = ThemeData(
    // useMaterial3: false,
    primaryColor: AppColors.primary,
  disabledColor: AppColors.primary.withOpacity(0.5),
  hintColor: AppColors.red,
  appBarTheme: AppBarTheme(
    elevation: 0.5,
    systemOverlayStyle: SystemStyles.light,
  ),
  dividerColor: AppColors.steelGray,
  indicatorColor: AppColors.black,
  brightness: Brightness.light,
  dialogBackgroundColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.scaffoldBackGround,
  primaryColorDark: AppColors.primary,
  canvasColor: AppColors.primaryTextColor,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: AppColors.white,
    filled: true,
    errorMaxLines: 4,
    errorStyle: const TextStyle(
      letterSpacing: -0.4,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.gray),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(5),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.red),
      borderRadius: BorderRadius.circular(5),
    ),
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    hintStyle: const TextStyle().copyWith(
      color: AppColors.steelGray,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  textTheme: TextTheme(
    titleLarge: const TextStyle().copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    headlineSmall: const TextStyle().copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    headlineMedium: const TextStyle().copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),
    displaySmall: const TextStyle().copyWith(
      color: AppColors.primary,
      fontSize: 21,
      fontWeight: FontWeight.w500,
    ),
    displayMedium: const TextStyle().copyWith(
      color: AppColors.primary,
      fontSize: 28,
      fontWeight: FontWeight.w500,
    ),
  ),
  primarySwatch: Palette.primaryColor,
  primaryTextTheme: TextTheme(
    titleLarge: const TextStyle().copyWith(
      color: AppColors.primaryTextColor,
      fontWeight: FontWeight.w300,
      fontSize: 12,
      fontFamily: 'Poppins',
    ),
    headlineSmall: const TextStyle().copyWith(
      color: AppColors.primaryTextColor,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      fontFamily: 'Poppins',
    ),
    headlineMedium: const TextStyle().copyWith(
      color: AppColors.primaryTextColor,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      fontFamily: 'Poppins',
    ),
    displaySmall: const TextStyle().copyWith(
      color: AppColors.primaryTextColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
    displayMedium: const TextStyle().copyWith(
      color: AppColors.primaryTextColor,
      fontSize: 28,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
    bodySmall: const TextStyle().copyWith(
      color: AppColors.primaryTextColor,
      fontSize: 32,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
    labelLarge: const TextStyle().copyWith(
      color: AppColors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.steelGray,
      selectedLabelStyle: const TextStyle().copyWith(
        color: AppColors.primaryTextColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
      ),
      unselectedLabelStyle: const TextStyle().copyWith(
        color: AppColors.steelGray,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
      ),
      selectedIconTheme: const IconThemeData(
        color: AppColors.primary,
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppColors.steelGray,
      )),
  checkboxTheme: CheckboxThemeData(
      overlayColor: MaterialStateProperty.all(AppColors.primary),
      checkColor: MaterialStateProperty.all(AppColors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: AlwaysActiveBorderSide()),
    colorScheme: lightColorScheme,
    // colorScheme: ColorScheme.fromSwatch(
    //     primarySwatch: createMaterialColor(AppColors.primary))
    //     .copyWith(background: AppColors.white)
    //     .copyWith(error: AppColors.red)
);

 const ColorScheme lightColorScheme = ColorScheme(
  // primary: Color(0xFFFF8383),
  primary: Colors.black,
  secondary: AppColors.white,
  // secondary: Color(0xFF4D1F7C),
  // background: Color(0xFF241E30),
  // secondaryFixed: AppColors.darkModeBg.withOpacity(0.3),
  secondaryFixed: Color(0xFFF5F5F5),
   tertiary: Color(0xFFF5F5F5),
  surface: AppColors.white,
  primaryContainer: AppColors.disabledButton,
  onPrimaryContainer: AppColors.dot_grey,
  // onBackground: Color(0x0DFFFFFF),
  error: Colors.redAccent,
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  brightness: Brightness.light,
);

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(states) =>
      const BorderSide(color: AppColors.primary, width: 1);
}