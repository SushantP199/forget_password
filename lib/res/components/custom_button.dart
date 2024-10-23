import 'package:flutter/material.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/dimension.dart';

class CustomButton extends StatelessWidget {
  final void Function() onTap;
  final Color backgroundColor;
  final String name;
  final Color foregroundColor;
  final double? width;
  final double? height;

  const CustomButton(
    this.onTap,
    this.backgroundColor,
    this.name,
    this.foregroundColor,
    this.height,
    this.width, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimension.widthMultiplier * 5),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: AppStr.fontFamily,
              fontWeight: FontWeight.bold,
              color: foregroundColor,
              fontSize: Dimension.textMultiplier * 3.5,
            ),
          ),
        ),
      ),
    );
  }
}
