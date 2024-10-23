import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/res/app_text_styles.dart';
import 'package:forget_password/utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final int? maxLength;

  const CustomTextFormField(
    this.controller,
    this.hintText, {
    super.key,
    this.focusNode,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimension.widthMultiplier * 14,
      decoration: BoxDecoration(
        color: AppColors.richPurple,
        borderRadius: BorderRadius.circular(Dimension.widthMultiplier * 5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimension.widthMultiplier * 3,
          vertical: Dimension.heightMultiplier * 0.7,
        ),
        child: Center(
          child: TextFormField(
            cursorColor: AppColors.whiteOpaqueHigh,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle:
                  AppTextStyles.textFieldTextStyle(AppColors.whiteOpaqueLow),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              counterText: "",
            ),
            style: AppTextStyles.textFieldTextStyle(AppColors.white),
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            autofocus: autofocus,
            obscureText: obscureText,
            onChanged: onChanged,
            maxLength: maxLength,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter(
                RegExp(KGlobal.KPassRegEx),
                allow: true,
              ),
            ],
            enableInteractiveSelection: false,
          ),
        ),
      ),
    );
  }
}
