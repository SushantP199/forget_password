import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/repository/base_repository.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import 'package:forget_password/utils/utils.dart';
import '../../model/result_model.dart';

class AccountDetailViewModel {
  Future<void> copy(BuildContext context, String text) async {
    await Clipboard.setData(
      ClipboardData(text: text),
    ).then((value) {
      Utils.successAlert(
        context: context,
        text: AppStr.dataCopiedSuccessfullyAlertText,
      );
    }).onError((error, stackTrace) {
      Utils.errorAlert(
        context: context,
        text: AppStr.dataCopiedErrorAlertText,
      );
    });
  }

  Future<void> edit(BuildContext context, DataModel dataModel) async {
    try {
      await Navigator.of(context).pushNamed(
        RoutesName.accountEditForm,
        arguments: dataModel,
      );
    } catch (e) {
      Utils.navigateToErrorView(context: context, errorMessage: AppStr.editButtonErrorText);
    }
  }

  Future<void> delete(BuildContext context, String id) async {
    Utils.warningAlert(
      context: context,
      text: AppStr.deleteAccountWarningText,
      onTap: () async {
        BaseRepository baseRepository = BaseRepository();
        Result accountDeleteResult = await baseRepository.deleteUserDetail(id);

        if (!accountDeleteResult.success && context.mounted) {
          Utils.navigateToErrorView(context: context, errorMessage: accountDeleteResult.error);
          return;
        } else if (!context.mounted) {
          Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
          return;
        }

        if (context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.home, (route) => false);
        } else {
          Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
          return;
        }
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
    );
  }
}
