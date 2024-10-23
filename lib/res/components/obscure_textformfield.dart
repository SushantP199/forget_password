import 'package:flutter/material.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/components/custom_textformfield.dart';
import 'package:forget_password/res/dimension.dart';

class ObscureTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController obscureFieldController;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final int maxLength;

  ObscureTextFormField({
    required this.obscureFieldController,
    required this.hintText,
    this.focusNode,
    this.onFieldSubmitted,
    required this.maxLength,
    super.key,
  });

  final ValueNotifier<bool> _obscureFieldValueNotifer = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _obscureFieldValueNotifer,
      builder: (context, value, child) {
        return CustomTextFormField(
          obscureFieldController,
          hintText,
          obscureText: _obscureFieldValueNotifer.value,
          maxLength: maxLength,
          suffixIcon: IconButton(
            onPressed: () {
              _obscureFieldValueNotifer.value =
                  !_obscureFieldValueNotifer.value;
            },
            icon: Icon(
              _obscureFieldValueNotifer.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: AppColors.white,
              size: Dimension.widthMultiplier * 4,
            ),
          ),
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
        );
      },
    );
  }
}
