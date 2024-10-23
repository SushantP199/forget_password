import 'package:flutter/material.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/view/home/account_card.dart';
import 'package:forget_password/view_model/home/home_view_model.dart';

class AccountCardListView extends StatelessWidget {
  final dynamic accounts;
  final HomeViewModel homeViewModel;

  const AccountCardListView({
    super.key,
    required this.accounts,
    required this.homeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimension.heightMultiplier * 3,
      ),
      child: ListView.builder(
        itemCount: accounts.length as int,
        itemBuilder: (context, index) {
          return AccountCard(
            dataModel: accounts[index],
            homeViewModel: homeViewModel,
          );
        },
      ),
    );
  }
}
