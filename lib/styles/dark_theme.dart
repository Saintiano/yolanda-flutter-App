

import 'package:flutter/material.dart';
import 'package:yolanda/styles/app_colors.dart';
import 'package:yolanda/styles/system_styles.dart';

ThemeData darkTheme2 = ThemeData(
    // useMaterial3: false,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: AppColors.white,
    dividerColor: AppColors.white,
    indicatorColor: AppColors.white,
    disabledColor: AppColors.primary.withOpacity(0.5),
    hintColor: AppColors.white,
    appBarTheme: AppBarTheme(
      elevation: 0.5,
      systemOverlayStyle: SystemStyles.dark,
    ),
    brightness: Brightness.dark,
    dialogBackgroundColor: AppColors.darkModeBg,
    scaffoldBackgroundColor: AppColors.darkModeBg,
    primaryColorDark: AppColors.primaryTextColorDark,
    canvasColor: AppColors.primaryTextColorDark,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.steelGray,
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
        borderSide: const BorderSide(color: AppColors.white),
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
        color: AppColors.primaryTextColorDark,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      headlineSmall: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      headlineMedium: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      displaySmall: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontSize: 21,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
    ),
    primarySwatch: Palette.primaryColor,
    primaryTextTheme: TextTheme(
      titleLarge: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontWeight: FontWeight.w300,
        fontSize: 12,
        fontFamily: 'Poppins',
      ),
      headlineSmall: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        fontFamily: 'Poppins',
      ),
      headlineMedium: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontWeight: FontWeight.w400,
        fontSize: 18,
        fontFamily: 'Poppins',
      ),
      displaySmall: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      displayMedium: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      bodySmall: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontSize: 32,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
      labelLarge: const TextStyle().copyWith(
        color: AppColors.primaryTextColorDark,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkModeBg,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.steelGray,
        selectedLabelStyle: const TextStyle().copyWith(
          color: AppColors.primaryTextColorDark,
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
          color: AppColors.white,
        ),
        unselectedIconTheme: const IconThemeData(
          color: AppColors.steelGray,
        )),
    checkboxTheme: CheckboxThemeData(
        overlayColor: MaterialStateProperty.all(AppColors.white),
        checkColor: MaterialStateProperty.all(AppColors.darkModeBg),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: AlwaysActiveBorderSide()),
    colorScheme: darkColorScheme,
    // colorScheme: ColorScheme.fromSwatch(
    //     primarySwatch: createMaterialColor(AppColors.primary))
    //     .copyWith(background: AppColors.white)
    //     .copyWith(error: AppColors.red)
);

const ColorScheme darkColorScheme = ColorScheme(
  // primary: Color(0xFFFF8383),
  primary: Colors.white,
  secondary: AppColors.darkModeBg,
  // secondary: Color(0xFF4D1F7C),
  // background: Color(0xFF241E30),
  secondaryFixed: AppColors.darkModeBg,
  tertiary: AppColors.bottomSheetBg,
  surface: AppColors.darkModeBg,
  primaryContainer: AppColors.disabledButton,
  onPrimaryContainer: AppColors.dot_grey,
  // onBackground: Color(0x0DFFFFFF),
  error: Colors.redAccent,
  onError: Colors.white,
  onPrimary: Colors.black,
  onSecondary: Colors.white,
  onSurface: Colors.black,
  brightness: Brightness.dark,
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