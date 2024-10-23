import 'package:flutter/material.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/dimension.dart';

class ViewTitle extends StatelessWidget {
  final String title;

  const ViewTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimension.heightMultiplier * 2,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: AppStr.fontFamily,
          fontSize: Dimension.textMultiplier * 12,
          color: AppColors.white,
        ),
      ),
    );
  }
}
