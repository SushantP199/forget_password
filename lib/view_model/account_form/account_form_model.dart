import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/model/result_model.dart';
import 'package:forget_password/repository/store_repository.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/utils/constants.dart';
import 'package:forget_password/utils/utils.dart';
import 'package:forget_password/view/protection/protection_view.dart';
import 'package:uuid/uuid.dart';
import '../../data/response/data_response.dart';

class AccountFormViewModel extends ChangeNotifier {
  DataResponse _saveAccount = DataResponse.loading();

  DataResponse get saveAccount {
    return _saveAccount;
  }

  setSaveAccount(DataResponse value) {
    _saveAccount = value;
    notifyListeners();
  }

  Future save({
    required BuildContext context,
    required String account,
    required String username,
    required String password,
    required String accountId,
  }) async {
    try {
      if (account.isEmpty) {
        Utils.warningAlert(
          context: context,
          text: AppStr.accountTextFieldErrorWarningText,
        );
      } else if (username.isEmpty) {
        Utils.warningAlert(
          context: context,
          text: AppStr.usernameTextFieldHErrorWarningText,
        );
      } else if (password.isEmpty) {
        Utils.warningAlert(
          context: context,
          text: AppStr.passwordTextFieldErrorWarningText,
        );
      } else {
        UserModel userModel = UserModel(
          account.toUpperCase(),
          username.toLowerCase(),
          password,
        );

        DataModel dataModel = DataModel(
          accountId == KGlobal.EMPTY ? const Uuid().v1() : accountId,
          userModel,
        );

        StoreRepository storeRepository = StoreRepository();
        Result incorrectTicketsResult = await storeRepository.get(KPrefs.KIncorrectTickets);

        if (!incorrectTicketsResult.success) {
          setSaveAccount(DataResponse.error(incorrectTicketsResult.error));
          return;
        }

        if (context.mounted) {
          Utils.showProtectionWall(
            context,
            ProtectionView(
              dataModel: dataModel,
              incorrectTickets: int.parse(incorrectTicketsResult.data),
              encrypt: true,
            ),
          );
        } else {
          setSaveAccount(DataResponse.error(AppStr.contextMountingErrorText));
        }
      }
    } catch (e) {
      setSaveAccount(DataResponse.error(KError.TECHERROR));
    }
  }
}
