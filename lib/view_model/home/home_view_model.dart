import 'package:flutter/material.dart';
import 'package:forget_password/data/response/data_response.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/model/result_model.dart';
import 'package:forget_password/repository/base_repository.dart';
import 'package:forget_password/repository/store_repository.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/utils/constants.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import 'package:forget_password/utils/utils.dart';
import '../../view/protection/protection_view.dart';

class HomeViewModel extends ChangeNotifier {
  /*
    Load accounts from database
  */
  DataResponse _totalAccounts = DataResponse.loading();

  DataResponse get totalAccounts {
    return _totalAccounts;
  }

  setTotalAccounts(DataResponse value) {
    _totalAccounts = value;
    notifyListeners();
  }

  Future loadAccounts(BuildContext context) async {
    try {
      setTotalAccounts(DataResponse.loading());

      BaseRepository baseRepository = BaseRepository();
      Result getUserAccountsResult = await baseRepository.getUserAccounts();

      if (!getUserAccountsResult.success) {
        setTotalAccounts(DataResponse.error(getUserAccountsResult.error));
        return;
      }

      List<DataModel> accounts = <DataModel>[];

      for (var userAccount in getUserAccountsResult.data) {
        DataModel dataModel = await userAccount;
        accounts.add(dataModel);
      }

      setTotalAccounts(DataResponse.completed(accounts));
    } catch (e) {
      setTotalAccounts(DataResponse.error(KError.TECHERROR));
    }
  }

  /*
    Go to change ticket view
  */
  Future<void> navigateToChangeTicketView(BuildContext context) async {
    try {
      StoreRepository storeRepository = StoreRepository();

      Result incorrectTicketsResult =
          await storeRepository.get(KPrefs.KIncorrectTickets);

      if (!incorrectTicketsResult.success) {
        setTotalAccounts(DataResponse.error(incorrectTicketsResult.error));
        return;
      }

      if (context.mounted) {
        Utils.showProtectionWall(
          context,
          ProtectionView(
            incorrectTickets: int.parse(incorrectTicketsResult.data),
            isChangeRequest: true,
          ),
        );
      } else {
        setTotalAccounts(DataResponse.error(AppStr.contextMountingErrorText));
      }
    } catch (e) {
      setTotalAccounts(DataResponse.error(KError.TECHERROR));
    }
  }

  /*
    Filter accounts from accounts (list) already laoded from database
  */
  List<DataModel> _searchedAccounts = <DataModel>[];

  List<DataModel> get searchedAccounts => _searchedAccounts;

  void setSearchedAccounts(List<DataModel> value) {
    _searchedAccounts = value;
    notifyListeners();
  }

  void searchAccounts(BuildContext context, String keyword) {
    List<DataModel> searchedAccounts = <DataModel>[];

    for (var account in totalAccounts.data) {
      if (account.userModel.account.toLowerCase().contains(keyword) ||
          account.userModel.username.contains(keyword)) {
        searchedAccounts.add(account);
      }
    }

    setSearchedAccounts(searchedAccounts);
  }

  /*
    Go to add account view
  */
  void navigateToAddAccountView(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.accountAddForm);
  }

  /*
    Go to account detail view
  */
  Future<void> navigateToAccountDetailView(
    BuildContext context,
    DataModel dataModel,
  ) async {
    try {
      StoreRepository storeRepository = StoreRepository();
      Result incorrectTicketsResult =
          await storeRepository.get(KPrefs.KIncorrectTickets);

      if (!incorrectTicketsResult.success) {
        setTotalAccounts(DataResponse.error(incorrectTicketsResult.error));
        return;
      }

      if (context.mounted) {
        Utils.showProtectionWall(
          context,
          ProtectionView(
            incorrectTickets: int.parse(incorrectTicketsResult.data),
            decrypt: true,
            dataModel: dataModel,
          ),
        );
      } else {
        setTotalAccounts(DataResponse.error(AppStr.contextMountingErrorText));
      }
    } catch (e) {
      setTotalAccounts(DataResponse.error(KError.TECHERROR));
    }
  }
}
