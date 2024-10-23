import 'package:flutter/material.dart';
import 'package:forget_password/res/app_images.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/components/custom_button.dart';
import 'package:forget_password/res/app_text_styles.dart';
import 'package:forget_password/res/components/custom_background_scaffold.dart';
import 'package:forget_password/view_model/user_guide/user_guide_view_model.dart';
import '../../res/app_colors.dart';
import '../../res/dimension.dart';

class UserGuideView extends StatelessWidget {
  const UserGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundScaffold(
      shouldPop: true,
      child: ListView(
        children: [
          SizedBox(height: Dimension.heightMultiplier * 5),
          Image.asset(
            AppImg.appLogo,
            width: Dimension.widthMultiplier * 35,
            height: Dimension.widthMultiplier * 35,
          ),
          SizedBox(height: Dimension.heightMultiplier * 5),
          Text(
            AppStr.read_with_care_text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppStr.fontFamily,
              fontSize: Dimension.textMultiplier * 4,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: Dimension.heightMultiplier * 2.5),
          Text(
            AppStr.app_guide_lines,
            textAlign: TextAlign.center,
            style: AppTextStyles.textFieldTextStyle(AppColors.purple),
          ),
          SizedBox(height: Dimension.heightMultiplier * 2),
          Text(
            AppStr.aggrement_text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppStr.fontFamily,
              fontSize: Dimension.textMultiplier * 4,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: Dimension.heightMultiplier * 6),
          CustomButton(
            () {
              UserGuideViewModel().navigateToTicketFormView(context);
            },
            AppColors.purple,
            AppStr.getStarted,
            AppColors.white,
            Dimension.widthMultiplier * 15,
            double.infinity,
          ),
          SizedBox(height: Dimension.heightMultiplier * 5),
        ],
      ),
    );
  }
}
