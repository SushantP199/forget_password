import 'package:flutter/material.dart';
import 'package:forget_password/res/app_images.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/res/app_text_styles.dart';

class EmptyAccountsView extends StatelessWidget {
  const EmptyAccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppImg.error,
          height: Dimension.widthMultiplier * 35,
          width: Dimension.widthMultiplier * 35,
        ),
        SizedBox(height: Dimension.heightMultiplier * 0.5),
        Text(
          AppStr.messageForEmptyAccounts,
          style: AppTextStyles.textFieldTextStyle(AppColors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
