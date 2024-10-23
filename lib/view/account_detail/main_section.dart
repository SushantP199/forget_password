import 'package:flutter/material.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/components/custom_button.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/view/account_detail/copy_button.dart';
import 'package:forget_password/view_model/account_detail/account_detail_view_model.dart';

class MainSection extends StatelessWidget {
  final DataModel dataModel;

  const MainSection({required this.dataModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: Dimension.heightMultiplier * 55,
      decoration: BoxDecoration(
        color: AppColors.richPurple,
        borderRadius: BorderRadius.circular(Dimension.widthMultiplier * 6),
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimension.widthMultiplier * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStr.copyToClipboardHintText,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppStr.fontFamily,
                    fontSize: Dimension.textMultiplier * 5,
                    color: AppColors.whiteOpaqueLow,
                  ),
                  maxLines: 3,
                ),
                CopyButton(
                  onTap: () {
                    AccountDetailViewModel().copy(
                      context,
                      dataModel.userModel.password,
                    );
                  },
                  color: AppColors.white,
                  size: Dimension.widthMultiplier * 7,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimension.heightMultiplier * 1),
              child: const Divider(
                color: AppColors.white,
              ),
            ),
            Text(
              dataModel.userModel.password,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppStr.fontFamily,
                fontSize: Dimension.textMultiplier * 10,
                color: AppColors.purple,
              ),
              maxLines: 3,
            ),
            const Spacer(),
            Row(
              children: [
                Flexible(
                  child: CustomButton(
                    () {
                      AccountDetailViewModel().delete(context, dataModel.id);
                    },
                    AppColors.purple,
                    AppStr.removeButtonText,
                    AppColors.white,
                    Dimension.widthMultiplier * 13.5,
                    Dimension.widthMultiplier * 100,
                  ),
                ),
                SizedBox(width: Dimension.widthMultiplier * 5),
                Flexible(
                  child: CustomButton(
                    () {
                      AccountDetailViewModel().edit(context, dataModel);
                    },
                    AppColors.white,
                    AppStr.updateButtonText,
                    AppColors.darkPurple,
                    Dimension.widthMultiplier * 13.5,
                    Dimension.widthMultiplier * 100,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
