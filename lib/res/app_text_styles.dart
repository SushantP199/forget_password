import 'package:flutter/material.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/dimension.dart';

class AppTextStyles {
  static TextStyle textFieldTextStyle(Color color) {
    return TextStyle(
      fontFamily: AppStr.fontFamily,
      fontSize: Dimension.textMultiplier * 4,
      color: color,
    );
  }

  static TextStyle errorMessageStyle() {
    return TextStyle(
      fontFamily: AppStr.fontFamily,
      fontSize: Dimension.textMultiplier * 3,
      color: AppColors.whiteOpaqueLow,
    );
  }
}
