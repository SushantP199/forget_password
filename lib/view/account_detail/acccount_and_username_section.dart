import 'package:flutter/material.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/view/account_detail/copy_button.dart';
import 'package:forget_password/view_model/account_detail/account_detail_view_model.dart';

class AccountAndUsernameSection extends StatelessWidget {
  final String account;
  final String username;

  const AccountAndUsernameSection({
    required this.account,
    required this.username,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimension.widthMultiplier * 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            account,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontFamily: AppStr.fontFamily,
              fontSize: Dimension.textMultiplier * 10,
              color: AppColors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  username,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppStr.fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: Dimension.textMultiplier * 4,
                    color: AppColors.whiteOpaqueLow,
                  ),
                ),
              ),
              CopyButton(
                onTap: () {
                  AccountDetailViewModel().copy(context, username);
                },
                color: AppColors.purple,
                size: Dimension.widthMultiplier * 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
