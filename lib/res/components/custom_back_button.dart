import 'package:flutter/material.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/dimension.dart';

class CustomBackButton extends StatelessWidget {
  final void Function() onTap;

  const CustomBackButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimension.heightMultiplier * 2),
      child: Row(
        children: [
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Icon(
              Icons.cancel_rounded,
              size: Dimension.widthMultiplier * 10,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
