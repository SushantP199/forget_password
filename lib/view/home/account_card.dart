import 'package:flutter/material.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/view_model/home/home_view_model.dart';

class AccountCard extends StatelessWidget {
  final DataModel dataModel;
  final HomeViewModel homeViewModel;

  const AccountCard({
    super.key,
    required this.dataModel,
    required this.homeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimension.widthMultiplier,
      margin: EdgeInsets.only(bottom: Dimension.heightMultiplier * 1.5),
      padding: EdgeInsets.symmetric(
        horizontal: Dimension.widthMultiplier * 7,
        vertical: Dimension.heightMultiplier * 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.richPurple,
        borderRadius: BorderRadius.circular(
          Dimension.widthMultiplier * 7,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // FLexible over Text inside Row or Column Prevent from A Rendeflex Overflow
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataModel.userModel.account,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppStr.fontFamily,
                    fontSize: Dimension.textMultiplier * 4.5,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  dataModel.userModel.username,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppStr.fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: Dimension.textMultiplier * 3.5,
                    color: AppColors.whiteOpaqueLow,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              homeViewModel.navigateToAccountDetailView(context, dataModel);
            },
            alignment: Alignment.centerRight,
            iconSize: Dimension.widthMultiplier * 10,
            icon: Icon(
              Icons.more_horiz,
              color: AppColors.white,
              size: Dimension.widthMultiplier * 5,
            ),
          ),
        ],
      ),
    );
  }
}
