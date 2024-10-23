import 'package:flutter/material.dart';
import 'package:forget_password/data/response/status.dart';
import 'package:forget_password/res/app_images.dart';
import 'package:forget_password/res/components/custom_background_scaffold.dart';
import 'package:forget_password/view/error/error_view.dart';
import 'package:forget_password/view/home/home_view.dart';
import 'package:forget_password/view/user_guide/user_guide_view.dart';
import 'package:forget_password/view_model/splash/splash_view_model.dart';
import 'package:provider/provider.dart';
import '../../res/dimension.dart';
import '../../utils/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(AppImg.appLogo), context);

    final splashViewModel =
        Provider.of<SplashViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: KGlobal.KSplashTimeInMilliSec),
        () {
          splashViewModel.loadUserPreferences(context);
        },
      );
    });

    return Consumer<SplashViewModel>(
      builder: (context, value, child) {
        switch (splashViewModel.isSplashSeen.status) {
          case Status.LOADING:
            return CustomBackgroundScaffold(
              shouldPop: true,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: const AssetImage(AppImg.appLogo),
                        width: Dimension.widthMultiplier * 35,
                        height: Dimension.widthMultiplier * 35,
                      ),
                    ],
                  ),
                ),
              ),
            );
          case Status.COMPLETED:
            if (splashViewModel.isSplashSeen.data == true) {
              return const HomeView();
            } else {
              return const UserGuideView();
            }
          default:
            return ErrorView(errorMessage: splashViewModel.isSplashSeen.message.toString());
        }
      },
    );
  }
}
