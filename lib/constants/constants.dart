import 'package:flutter/cupertino.dart';

class AppColors {
  static Color pinkLight = Color(0xFFFF6099);
  static Color pinkDark = Color(0xFFFF2F7A);

  static Color blueDark = Color(0xFF004BD4);
  static Color blueMedium = Color(0xFF4364F7);
  static Color blueLight = Color(0xFF6FB1FC);
  static Color backGroundColor = Color(0xFFF5F8FF);
}

class AppFonts {
  static String INTER_MEDIUM = "inter-medium";
  static String INTER_REGULAR = "inter-regular";
  static String POPPINS_BOLD = "poppins-bold";
  static String POPPINS_SEMI_BOLD = "poppins-semi-bold";
  static String URBANIST_BOLD = "urbanist-bold";
  static String URBANIST_MEDIUAM = "urbanist-medium";
}

var kPinkGadient = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
      AppColors.pinkDark,
      AppColors.pinkLight,
      AppColors.pinkLight
    ]));

const String publishableKey = 'pk_live_51MVaGMDOKnpmF4HS1AVcAHaLlT49vDEgRbYUbSo7GdVegyhBcahdNoI0l2BjCDXk5elZ7l0xwu8xzDj33uecL9rY00aEaumTgW';
