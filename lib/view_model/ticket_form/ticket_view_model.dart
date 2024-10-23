import 'package:flutter/material.dart';
import 'package:forget_password/data/response/data_response.dart';
import 'package:forget_password/model/result_model.dart';
import 'package:forget_password/repository/base_repository.dart';
import 'package:forget_password/repository/crypto_repository.dart';
import 'package:forget_password/repository/store_repository.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/utils/constants.dart';
import 'package:forget_password/utils/debug_printer.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import 'package:forget_password/utils/utils.dart';
import '../../model/data_model.dart';

class TicketViewModel extends ChangeNotifier{

  DataResponse _isTicketSet = DataResponse.loading();

  DataResponse get isTicketSet {
    return _isTicketSet;
  }

  void setIsTicketSet(DataResponse value) {
    _isTicketSet = value;
    notifyListeners();
  }

  Future<void> set({
    required BuildContext context,
    required String ticket,
    required String confirmTicket,
    required String confirmAgaintTicket,
    required bool isChangeRequest,
    required String oldTicket,
  }) async {
    try {
      if (ticket.isEmpty) {
        Utils.warningAlert(
          context: context,
          text: AppStr.emptyTicketErrorText,
        );
      }
      /*
        To check whether ticket is following 
        constraints given in isTikcetCompliant method
      */
      else if (isTikcetCompliant(ticket)) {
        if (ticket == confirmTicket && confirmTicket == confirmAgaintTicket) {

          setIsTicketSet(DataResponse.loading());

          /*
            If new ticket is following all the above conditions,
            then
            first we will DECRYPT all the accounts with OLD TICKET along with auth verifier,
            and
            second we will again encrypt all the account with NEW TICKET along with auth verifier.
          */
          if (isChangeRequest && oldTicket != KGlobal.EMPTY) {
            BaseRepository baseRepository = BaseRepository();
            Result userAccountsResult = await baseRepository.getUserAccounts();

            if (!userAccountsResult.success) {
              setIsTicketSet(DataResponse.error(userAccountsResult.error));
              return;
            }

            for (var userAccount in userAccountsResult.data) {
              DataModel dataModel = await userAccount;
              String encryptedPassword = dataModel.userModel.password;

              CryptoRepository cryptoRepository = CryptoRepository();
              Result decryptionResult = cryptoRepository.decrypt(encryptedPassword, oldTicket);

              if (!decryptionResult.success) {
                setIsTicketSet(DataResponse.error(decryptionResult.error));
                return;
              }

              Result newlyEncryptedPasswordResult = cryptoRepository.encrypt(decryptionResult.data, ticket);

              if (!newlyEncryptedPasswordResult.success) {
                setIsTicketSet(DataResponse.error(newlyEncryptedPasswordResult.error));
                return;
              }

              dataModel.userModel.password = newlyEncryptedPasswordResult.data;

              Result saveUserAccountResult = await baseRepository.saveUserDetail(dataModel);

              if (!saveUserAccountResult.success) {
                setIsTicketSet(DataResponse.error(saveUserAccountResult.error));
                return;
              }
            }
          }

          CryptoRepository cryptoRepository = CryptoRepository();
          Result ticketHashResult = cryptoRepository.hash(ticket);

          if (!ticketHashResult.success) {
            setIsTicketSet(DataResponse.error(ticketHashResult.error));
            return;
          }

          StoreRepository storeRepository = StoreRepository();

          Result isAuthVerifierSet = await storeRepository.set(KPrefs.KAuthVerifier, ticketHashResult.data);

          if(!isAuthVerifierSet.success) {
            setIsTicketSet(DataResponse.error(isAuthVerifierSet.error));
            return;
          }

          Result isSplashSeenResult = await storeRepository.set(KPrefs.KIsSplashSeen, true.toString());
      
          if (!isSplashSeenResult.success) {
            setIsTicketSet(DataResponse.error(isSplashSeenResult.error));
            return;
          }

          setIsTicketSet(DataResponse.completed(KGlobal.VOID));

          if (context.mounted) {
            Utils.successAlert(context: context, text: AppStr.submitTicketButtonSuccessText, onTap: (){
              Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.home, (route) => false);
            });
          } else {
            setIsTicketSet(DataResponse.error(AppStr.contextMountingErrorText));
          }
        } else {
          Utils.warningAlert(
            context: context,
            text: AppStr.ticketAndTicketConfirmsUnmatchErrorText,
          );
        }
      } else {
        Utils.warningAlert(
          context: context,
          text: AppStr.ticketCompliantUnsatisfiedErrorText,
        );
      }
    } catch (e) {
      DebugPrinter.log(e.toString());
      Utils.navigateToErrorView(context: context, errorMessage: KError.TECHERROR);
    }
  }

  /*
    To cross check if ticket or any string field satisfy it
  */
  bool isTikcetCompliant(String ticket) {
    bool hasExactLength = ticket.length == 8;
    bool hasLowerCase = ticket.contains(RegExp(r'[a-z]'));
    bool hasUpperCase = ticket.contains(RegExp(r'[A-Z]'));
    bool hasDigits = ticket.contains(RegExp(r'[0-9]'));
    bool hasSpecialCase =
        ticket.contains(RegExp(r'''[!@#$%^&*(),.?'":;{}|<>~`\-_+=\[\]\\/ ]'''));

    bool isCompliant = hasExactLength &&
        hasLowerCase &&
        hasUpperCase &&
        hasDigits &&
        hasSpecialCase;

    return isCompliant;
  }
}
