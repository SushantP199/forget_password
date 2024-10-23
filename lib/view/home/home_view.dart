import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forget_password/data/response/status.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/components/view_title.dart';
import 'package:forget_password/res/components/custom_background_scaffold.dart';
import 'package:forget_password/utils/utils.dart';
import 'package:forget_password/view/home/accout_card_list_view.dart';
import 'package:forget_password/view/home/empty_accounts_view.dart';
import 'package:forget_password/view/home/search_and_add_account_bar.dart';
import 'package:forget_password/view_model/home/home_view_model.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import '../../res/components/custom_alert_dialog.dart';
import '../../utils/routes/routes_name.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController? _searchEditingController;

  @override
  void initState() {
    super.initState();
    _searchEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    /*
      start the load accounts before home view loads up
    */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeViewModel.searchedAccounts.isEmpty) {
        homeViewModel.loadAccounts(context);
      }
    });

    return CustomBackgroundScaffold(
      shouldPop: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // View title
          const ViewTitle(title: AppStr.homeViewTitle),
          // Change ticket, search and add account bar
          SearchAndAddAccountBar(
            searchEditingController: _searchEditingController!,
            homeViewModel: homeViewModel,
          ),
          // Account card list
          Flexible(
            child: Center(
              child: Consumer<HomeViewModel>(
                builder: (context, value, child) {
                  Status? status = value.totalAccounts.status;

                  if (status == Status.LOADING) {
                    return LoadingBouncingLine.square(
                      backgroundColor: AppColors.whiteOpaqueLow,
                    );
                  }
                  if (status == Status.COMPLETED) {
                    dynamic accounts;

                    if (Utils.cleanString(
                      _searchEditingController!.text,
                    ).isEmpty) {
                      accounts = homeViewModel.totalAccounts.data;
                    } else {
                      accounts = homeViewModel.searchedAccounts;
                    }

                    if (accounts.length == 0) {
                      return const EmptyAccountsView();
                    } else {
                      return AccountCardListView(
                        accounts: accounts,
                        homeViewModel: homeViewModel,
                      );
                    }
                  } else {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        const EmptyAccountsView(),
                        BackdropFilter(
                          filter: ColorFilter.mode(
                            AppColors.darkPurple.withOpacity(0.35),
                            BlendMode.darken
                          ),
                          child: CustomAlertDialog(
                            titleText: AppStr.alertErrorTitleText,
                            titleColor: AppColors.errorAlertColor,
                            bodyText: homeViewModel.totalAccounts.message.toString() + AppStr.homeErrorButtonsGuideText,
                            onTap: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.home, (route) => false);
                            },
                            onCancel: () {
                              SystemNavigator.pop();
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
