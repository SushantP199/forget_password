import 'package:flutter/material.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/components/custom_alert_dialog.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import '../res/app_strings.dart';

class Utils {
  /*
    Alerts
  */

  static successAlert({
    required BuildContext context,
    required String text,
    void Function()? onTap,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleText: AppStr.alertSucessTitleText,
          titleColor: AppColors.sucessAlertColor,
          bodyText: text,
          onTap: onTap,
        );
      },
    );
  }

  static warningAlert({
    required BuildContext context,
    required String text,
    void Function()? onTap,
    void Function()? onCancel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleText: AppStr.alertWarningTitleText,
          titleColor: AppColors.warningAlertColor,
          bodyText: text,
          onTap: onTap,
          onCancel: onCancel,
        );
      },
    );
  }

  static errorAlert({
    required BuildContext context,
    required String text,
    void Function()? onTap,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          titleText: AppStr.alertErrorTitleText,
          titleColor: AppColors.errorAlertColor,
          bodyText: text,
          onTap: onTap,
        );
      },
    );
  }

  /*
    Protection alert
  */

  static showProtectionWall(BuildContext context, Widget widget) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => widget,
    );
  }

  /*
    TextFormField utils
  */

  static void focusNext(BuildContext context, FocusNode currrentFocusNode,
      FocusNode nextFocusNode) {
    currrentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  static String cleanString(String text) {
    return text.trim();
  }

  static String setSpaceSafePassword(String password) {
    return password.replaceAll(" ", "<U+0020>");
  }

  static String getSpaceSafePassword(String password) {
    return password.replaceAll("<U+0020>", " ");
  }

  /*
    Go to error view
  */
  static void navigateToErrorView({required BuildContext context, required String errorMessage}) {
    Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.error, (route) => false, arguments: errorMessage);
  }
}
