import 'package:flutter/material.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/utils/routes/routes.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import 'package:forget_password/view_model/account_form/account_form_model.dart';
import 'package:forget_password/view_model/home/home_view_model.dart';
import 'package:forget_password/view_model/splash/splash_view_model.dart';
import 'package:forget_password/view_model/ticket_form/ticket_view_model.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SplashViewModel>(
          create: (context) => SplashViewModel(),
        ),
        ChangeNotifierProvider<TicketViewModel>(
          create: (context) => TicketViewModel(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider<AccountFormViewModel>(
          create: (context) => AccountFormViewModel(),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              /*
                Initialize device dimesions horizontal & vertical parts
              */
              Dimension().init(constraints, orientation);

              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: AppStr.appTitleName,
                onGenerateRoute: Routes.generateRoute,
                initialRoute: RoutesName.splash,
              );
            },
          );
        },
      ),
    );
  }
}
