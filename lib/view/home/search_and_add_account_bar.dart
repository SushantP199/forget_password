import 'package:flutter/material.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/components/custom_textformfield.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/utils/utils.dart';
import 'package:forget_password/view_model/home/home_view_model.dart';

class SearchAndAddAccountBar extends StatelessWidget {
  final TextEditingController searchEditingController;
  final HomeViewModel homeViewModel;

  const SearchAndAddAccountBar({
    super.key,
    required this.searchEditingController,
    required this.homeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            homeViewModel.navigateToChangeTicketView(context);
          },
          child: Container(
            width: Dimension.widthMultiplier * 14,
            height: Dimension.widthMultiplier * 14,
            decoration: BoxDecoration(
              color: AppColors.richPurple,
              borderRadius:
                  BorderRadius.circular(Dimension.widthMultiplier * 4),
            ),
            child: Center(
              child: Icon(
                Icons.segment_sharp,
                color: AppColors.purple,
                size: Dimension.widthMultiplier * 6,
              ),
            ),
          ),
        ),
        SizedBox(width: Dimension.widthMultiplier * 2.5),
        Flexible(
          child: CustomTextFormField(
            searchEditingController,
            AppStr.searchTextFieldHintText,
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.white,
              size: Dimension.widthMultiplier * 6,
            ),
            onChanged: (value) {
              homeViewModel.searchAccounts(context, Utils.cleanString(value));
            },
            onFieldSubmitted: (value) {
              homeViewModel.searchAccounts(context, Utils.cleanString(value));
            },
          ),
        ),
        SizedBox(width: Dimension.widthMultiplier * 2.5),
        InkWell(
          onTap: () {
            homeViewModel.navigateToAddAccountView(context);
          },
          child: Container(
            width: Dimension.widthMultiplier * 14,
            height: Dimension.widthMultiplier * 14,
            decoration: BoxDecoration(
              color: AppColors.richPurple,
              borderRadius: BorderRadius.circular(
                Dimension.widthMultiplier * 4,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: AppColors.white,
                size: Dimension.widthMultiplier * 6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
