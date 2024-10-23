import 'package:flutter/material.dart';
import 'package:forget_password/data/response/data_response.dart';
import 'package:forget_password/model/result_model.dart';
import 'package:forget_password/repository/store_repository.dart';
import 'package:forget_password/utils/constants.dart';

class SplashViewModel extends ChangeNotifier {
  final StoreRepository _storeRepository = StoreRepository();

  DataResponse<bool> _isSplashSeen = DataResponse.loading();

  DataResponse<bool> get isSplashSeen {
    return _isSplashSeen;
  }

  void setIsSplashSeen(DataResponse<bool> value) {
    _isSplashSeen = value;
    notifyListeners();
  }

  loadUserPreferences(BuildContext context) async {

    /*
      Below line of code commented to avoid
      double rendering of splash with same loading state only
    */
    // setIsSplashSeen(DataResponse.loading());
 
    Result isSplashSeenResult = await _storeRepository.get(KPrefs.KIsSplashSeen);

    if (!isSplashSeenResult.success && context.mounted) {
      setIsSplashSeen(DataResponse.error(isSplashSeenResult.error));
      return;
    }

    if (isSplashSeenResult.data == null) {
      Result incorrectTicketsSetResult = await _storeRepository.set(KPrefs.KIncorrectTickets, KGlobal.KAllowedIncorrectTickets.toString());
          
      if (!incorrectTicketsSetResult.success && context.mounted) {
        setIsSplashSeen(DataResponse.error(incorrectTicketsSetResult.error));
        return;
      }

      setIsSplashSeen(DataResponse.completed(false));

    } else if (isSplashSeenResult.data.toLowerCase() == "true") {
      Result lastTimeTicketEntryFailedResult = await _storeRepository.get(KPrefs.KLastTimeTicketEntryFailed);

      if (!lastTimeTicketEntryFailedResult.success && context.mounted) {
        setIsSplashSeen(DataResponse.error(lastTimeTicketEntryFailedResult.error));
        return;
      }

      if (lastTimeTicketEntryFailedResult.data != null) {
        DateTime currentTime = DateTime.now();

        Duration timeGone = currentTime.difference(DateTime.parse(lastTimeTicketEntryFailedResult.data));

        int timeRemaining = KGlobal.KTicketEntryDeniedHours - timeGone.inHours;

        if (timeRemaining == 0) {

          Result incorrectTicketsSetResult = await _storeRepository.set(KPrefs.KIncorrectTickets, KGlobal.KAllowedIncorrectTickets.toString());
          
          if (!incorrectTicketsSetResult.success && context.mounted) {
            setIsSplashSeen(DataResponse.error(incorrectTicketsSetResult.error));
            return;
          }

          Result lastTimeTicketEntryFailedDeleteResult = await _storeRepository.delete(KPrefs.KLastTimeTicketEntryFailed);

          if (!lastTimeTicketEntryFailedDeleteResult.success && context.mounted) {
            setIsSplashSeen(DataResponse.error(lastTimeTicketEntryFailedDeleteResult.error));
            return;
          } 
        }
      }

      setIsSplashSeen(DataResponse.completed(true));
    }
  }
}