import 'package:flutter/material.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:loading_animations/loading_animations.dart';
import '../../res/dimension.dart';

class CodingView extends StatelessWidget {
  final String codingType;

  const CodingView({required this.codingType, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimension.widthMultiplier * 2.5),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: Dimension.widthMultiplier * 2.5),
            LoadingBouncingGrid.square(
              backgroundColor: AppColors.richPurple,
            ),
            SizedBox(height: Dimension.widthMultiplier * 2.5),
            Text(
              codingType,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppStr.fontFamily,
                fontSize: Dimension.textMultiplier * 3,
                color: AppColors.richPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
