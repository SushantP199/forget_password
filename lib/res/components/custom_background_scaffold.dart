import 'package:flutter/material.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/dimension.dart';

class CustomBackgroundScaffold extends StatelessWidget {
  final Widget child;
  final bool shouldPop;
  const CustomBackgroundScaffold({super.key, required this.shouldPop, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => shouldPop,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.appBackgroundGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimension.widthMultiplier * 7),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
