import 'package:flutter/material.dart';
import 'package:forget_password/model/arguments_model.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/model/result_model.dart';
import 'package:forget_password/repository/base_repository.dart';
import 'package:forget_password/repository/crypto_repository.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/utils/constants.dart';
import 'package:forget_password/utils/debug_printer.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import '../../repository/store_repository.dart';
import '../../utils/utils.dart';

class ProtectionViewViewModel extends ChangeNotifier {
  bool _isDataBeingCoded = false;

  bool get isDataBeingCoded {
    return _isDataBeingCoded;
  }

  void setIsDataBeingCoded(bool value) {
    _isDataBeingCoded = value;
    notifyListeners();
  }

  Future yield({
    required BuildContext context,
    required ValueNotifier<int> attemptsValueNotifer,
    required String ticket,
    required DataModel? dataModel,
    required bool? encrypt,
    required bool? decrypt,
    required bool? isChangeRequest,
  }) async {
    try {
      if (ticket.isEmpty) {
        Utils.warningAlert(
          context: context,
          text: AppStr.emptyTicketErrorText,
        );
      } else if (ticket.length < 8) {
        Utils.warningAlert(
          context: context,
          text: AppStr.lesserLengthTicketErrorText,
        );
      } else if (isChangeRequest == true ||
          encrypt == true ||
          decrypt == true) {
        /*
          To start loading animation before encryption & decryption
        */
        context.read<ProtectionViewViewModel>().setIsDataBeingCoded(true);

        CryptoRepository cryptoRepository = CryptoRepository();
        Result ticketHashResult = cryptoRepository.hash(ticket);

        if (!ticketHashResult.success) {
          Utils.navigateToErrorView(context: context, errorMessage: ticketHashResult.error);
          return;
        }

        StoreRepository storeRepository = StoreRepository();
        Result getAuthVerifierResult = await storeRepository.get(KPrefs.KAuthVerifier);

        if (!getAuthVerifierResult.success && context.mounted) {
          Utils.navigateToErrorView(context: context, errorMessage: getAuthVerifierResult.error);
          return;
        } else if (!context.mounted) {
          Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
          return;
        }

        if (ticketHashResult.data == getAuthVerifierResult.data) {
          /*
            If user attempt correct ticket within 5 attempts to ENCRYPT,
            then we have reset incorrect count and last time ticket entry failed
          */
          Result lastTimeTicketEntryFailedResult = await storeRepository.get(KPrefs.KLastTimeTicketEntryFailed);

          if (!lastTimeTicketEntryFailedResult.success && context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: lastTimeTicketEntryFailedResult.error);
            return;
          } else if (!context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            return;
          }

          Result incorrectTicketsGetResult = await storeRepository.get(KPrefs.KIncorrectTickets);

          if (!incorrectTicketsGetResult.success && context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: incorrectTicketsGetResult.error);
            return;
          } else if (!context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            return;
          }

          if (int.parse(incorrectTicketsGetResult.data as String) < KGlobal.KAllowedIncorrectTickets) {
            Result incorrectTicketsSetResult = await storeRepository.set(KPrefs.KIncorrectTickets, KGlobal.KAllowedIncorrectTickets.toString());

            if (!incorrectTicketsSetResult.success && context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: incorrectTicketsSetResult.error);
              return;
            } else if (!context.mounted) {
               Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
              return;
            }

            Result lastTimeTicketEntryFailedDeleteResult = await storeRepository.delete(KPrefs.KLastTimeTicketEntryFailed);

            if (!lastTimeTicketEntryFailedDeleteResult.success && context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: lastTimeTicketEntryFailedDeleteResult.error);
              return;
            } else if (!context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
              return;
            }
          }

          if (isChangeRequest == true && isChangeRequest != null) {
            if (context.mounted) {
              context.read<ProtectionViewViewModel>().setIsDataBeingCoded(false);

              Navigator.of(context).pushNamedAndRemoveUntil(
                RoutesName.ticketForm,
                (routes) => false,
                arguments: ArgumentsModel(
                  oldTicket: ticket,
                  isChangeRequest: isChangeRequest,
                ),
              );
            } else if (!context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            }
            return;
          }

          if (encrypt != null && dataModel != null && encrypt == true) {
            Result encryptionResult = cryptoRepository.encrypt(dataModel.userModel.password, ticket);

            if (!encryptionResult.success && context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: encryptionResult.error);
              return;
            } else if (!context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
              return;
            }

            dataModel.userModel.password = encryptionResult.data as String;

            BaseRepository baseRepository = BaseRepository();
            Result saveAccountResult = await baseRepository.saveUserDetail(dataModel);

            if (!saveAccountResult.success && context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: saveAccountResult.error);
              return;
            } else if (!context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
              return;
            }

            if (context.mounted) {
              Future.delayed(
                  const Duration(milliseconds: KGlobal.KCodingTimeInMilliSec),
                  () {
                context
                    .read<ProtectionViewViewModel>()
                    .setIsDataBeingCoded(false);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(RoutesName.home, (route) => false);
              });
              return;
            } else if (!context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
              return;
            }
          }

          if (decrypt != null && dataModel != null && decrypt == true) {
            Result decryptionResult = cryptoRepository.decrypt(dataModel.userModel.password, ticket);

            if (!decryptionResult.success && context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: decryptionResult.error);
              return;
            } else if (!context.mounted) {
              Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
              return;
            }

            UserModel sendUserModel = UserModel(
              dataModel.userModel.account,
              dataModel.userModel.username,
              decryptionResult.data as String,
            );

            DataModel sendDataModel = DataModel(dataModel.id, sendUserModel);

            Future.delayed(
                const Duration(milliseconds: KGlobal.KCodingTimeInMilliSec),
                () {
              context.read<ProtectionViewViewModel>().setIsDataBeingCoded(false);

              Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutesName.accountDetail, (route) => false,
                  arguments: sendDataModel);
            });
          }
        } else {
          /*
            To stop loading animation after wrong ticket entered
          */
          if (context.mounted) {
            context.read<ProtectionViewViewModel>().setIsDataBeingCoded(false);

            incorrectTicketTrackerAndEntryLimiter(
              context: context,
              attemptsValueNotifer: attemptsValueNotifer,
            );
          } else if (!context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            return;
          }
        }
      }
    } catch (e) {
      DebugPrinter.log(e.toString());
      Utils.errorAlert(context: context, text: KError.TECHERROR);
    }
  }

  Future incorrectTicketTrackerAndEntryLimiter({
    required BuildContext context,
    required ValueNotifier<int> attemptsValueNotifer,
  }) async {
    try {
      if (attemptsValueNotifer.value > 0) {
        /*
          If incorrect attempts available (upto 6 to 1),
          then decrement it after every wrong ticket attempt
        */
        StoreRepository storeRepository = StoreRepository();
        Result setIncorrectTicketsResult = await storeRepository.set(KPrefs.KIncorrectTickets, "${--attemptsValueNotifer.value}");

        if (!setIncorrectTicketsResult.success && context.mounted) {
          Utils.navigateToErrorView(context: context, errorMessage: setIncorrectTicketsResult.error);
          return;
        } else if (!context.mounted) {
          Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
          return;
        }
      } else if (attemptsValueNotifer.value == 0) {
        /*
          If incorrect attempts are not available (becomes 0),
          then restrict ticket entry for next 6 hours or 
          remaining hours iff already restricted
        */
        StoreRepository storeRepository = StoreRepository();
        Result lastTimeTicketEntryFailedResult = await storeRepository.get(KPrefs.KLastTimeTicketEntryFailed);

        if (!lastTimeTicketEntryFailedResult.success && context.mounted) {
          Utils.navigateToErrorView(context: context, errorMessage: lastTimeTicketEntryFailedResult.error);
          return;
        } else if (!context.mounted) {
          Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
          return;
        }

        if (lastTimeTicketEntryFailedResult.data == null) {
          Result lastTimeTicketEntryFailedSetResult = await storeRepository.set(KPrefs.KLastTimeTicketEntryFailed,DateTime.now().toIso8601String());

          if (!lastTimeTicketEntryFailedSetResult.success && context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: lastTimeTicketEntryFailedSetResult.error);
            return;
          } else if (!context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            return;
          }
 
          lastTimeTicketEntryFailedResult = await storeRepository.get(KPrefs.KLastTimeTicketEntryFailed);

          if (!lastTimeTicketEntryFailedResult.success && context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: lastTimeTicketEntryFailedResult.error);
            return;
          } else if (!context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            return;
          }
        }

        DateTime currentTime = DateTime.now();

        Duration timeGone = currentTime.difference(DateTime.parse(lastTimeTicketEntryFailedResult.data));

        int timeRemaining = KGlobal.KTicketEntryDeniedHours - timeGone.inHours;

        if (timeRemaining == 0) {
          Result incorrectTicketsSetResult = await storeRepository.set(KPrefs.KIncorrectTickets, KGlobal.KAllowedIncorrectTickets.toString());

          if (!incorrectTicketsSetResult.success && context.mounted) {
           Utils.navigateToErrorView(context: context, errorMessage: incorrectTicketsSetResult.error);
            return;
          } else if (!context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            return;
          }

          Result lastTimeTicketEntryFailedDeleteResult = await storeRepository.delete(KPrefs.KLastTimeTicketEntryFailed);

          if (!lastTimeTicketEntryFailedDeleteResult.success && context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: lastTimeTicketEntryFailedDeleteResult.error);
            return;
          } else if (!context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            return;
          }
        } else {
          if (context.mounted) {
            Utils.errorAlert(context: context, text: "${AppStr.wrongTicketAttemptsErrorText} $timeRemaining ${timeRemaining > 1 ? 'hours' : 'hour'}.");
            return;
          } else if (!context.mounted) {
            Utils.navigateToErrorView(context: context, errorMessage: AppStr.contextMountingErrorText);
            return;
          }
        }
        // }
      }
    } catch (e) {
      DebugPrinter.log(e.toString());
      Utils.errorAlert(context: context, text: KError.TECHERROR);
    }
  }
}
