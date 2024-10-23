import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/components/custom_background_scaffold.dart';
import 'package:forget_password/res/components/custom_button.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import '../../res/app_images.dart';
import '../../res/app_text_styles.dart';
import '../../res/dimension.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  const ErrorView({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundScaffold(
      shouldPop: false,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImg.error,
                width: Dimension.widthMultiplier * 40,
                height: Dimension.widthMultiplier * 40,
                fit: BoxFit.contain,
              ),
              SizedBox(height: Dimension.heightMultiplier * 0.5),
              Text(
                errorMessage,
                style: AppTextStyles.textFieldTextStyle(AppColors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Dimension.heightMultiplier * 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    () {
                      SystemNavigator.pop();
                    },
                    AppColors.purple,
                    AppStr.exitButtonText,
                    AppColors.white,
                    Dimension.widthMultiplier * 12,
                    Dimension.widthMultiplier * 30,
                  ),
                  SizedBox(width: Dimension.widthMultiplier * 2.5),
                  CustomButton(
                    () {
                      Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.home, (route) => false);
                    },
                    AppColors.white,
                    AppStr.homeButtonText,
                    AppColors.purple,
                    Dimension.widthMultiplier * 12,
                    Dimension.widthMultiplier * 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
