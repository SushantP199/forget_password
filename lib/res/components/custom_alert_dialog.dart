import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/components/custom_button.dart';
import 'package:forget_password/res/dimension.dart';

class CustomAlertDialog extends StatelessWidget {
  final String titleText;
  final Color titleColor;
  final String bodyText;
  final void Function()? onTap;
  final void Function()? onCancel;

  const CustomAlertDialog({
    required this.titleText,
    required this.titleColor,
    required this.bodyText,
    this.onTap,
    this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: AlertDialog(
            iconPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            scrollable: true,
            contentPadding: EdgeInsets.all(Dimension.widthMultiplier * 2.5),
            insetPadding: EdgeInsets.all(Dimension.widthMultiplier * 0),
            backgroundColor: AppColors.whiteOpaqueHigest,
            elevation: 0,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppStr.fontFamily,
                    fontSize: Dimension.textMultiplier * 5,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: Dimension.widthMultiplier * 4),
                Text(
                  bodyText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppStr.fontFamily,
                    fontSize: Dimension.textMultiplier * 3.5,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: Dimension.widthMultiplier * 4.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap ??
                          () {
                            Navigator.of(context).pop();
                          },
                      AppColors.purple,
                      AppStr.alertButtonText,
                      AppColors.white,
                      Dimension.widthMultiplier * 10,
                      Dimension.widthMultiplier * 20,
                    ),
                    SizedBox(width: Dimension.widthMultiplier * 2.5),
                    onCancel != null
                        ? CustomButton(
                            onCancel ??
                                () {
                                  Navigator.of(context).pop();
                                },
                            AppColors.white,
                            AppStr.alertCancelButtonText,
                            AppColors.purple,
                            Dimension.widthMultiplier * 10,
                            Dimension.widthMultiplier * 20,
                          )
                        : Container()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
