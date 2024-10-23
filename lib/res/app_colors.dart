import 'package:flutter/material.dart';

class AppColors {
  static const Gradient appBackgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.deepPurple,
      AppColors.darkPurple,
      AppColors.darkPurple,
      AppColors.deepPurple,
    ],
    stops: [-0.3, 0.3, 0.7, 1],
  );

  static const Color transparent = Color(0x00000000);

  static const Color silver = Color(0xFFFFFFFF);

  static const Color darkPurple = Color(0xFF030309);
  static const Color deepPurple = Color(0xFF282466);
  static const Color purple = Color(0xff6153fa);
  static const Color richPurple = Color(0xff16152b);

  static const Color white = Color(0xFFD9DADB);
  static const Color whiteOpaqueHigh = Color(0x13FFFFFF);
  static const Color whiteOpaqueHigest = Color(0x09FFFFFF);
  static const Color whiteOpaqueLow = Color(0x8FFFFFFF);

  static Color sucessAlertColor = Colors.green.shade700;
  static Color warningAlertColor = Colors.blue.shade700;
  static Color errorAlertColor = Colors.red.shade800;
}
