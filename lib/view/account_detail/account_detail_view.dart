import 'package:flutter/material.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/res/components/custom_back_button.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/res/components/custom_background_scaffold.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import 'package:forget_password/view/account_detail/acccount_and_username_section.dart';
import 'package:forget_password/view/account_detail/main_section.dart';

class AccountDetailView extends StatefulWidget {
  final DataModel dataModel;

  const AccountDetailView({required this.dataModel, super.key});

  @override
  State<AccountDetailView> createState() => _AccountDetailViewState();
}

class _AccountDetailViewState extends State<AccountDetailView> {
  @override
  Widget build(BuildContext context) {
    return CustomBackgroundScaffold(
      shouldPop: false,
      child: Column(
        children: [
          // Back button
          CustomBackButton(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                RoutesName.home,
              );
            },
          ),
          Flexible(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountAndUsernameSection(
                      account: widget.dataModel.userModel.account,
                      username: widget.dataModel.userModel.username,
                    ),
                    SizedBox(height: Dimension.heightMultiplier * 3),
                    MainSection(dataModel: widget.dataModel),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
