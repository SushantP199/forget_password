import 'package:flutter/material.dart';
import 'package:forget_password/model/arguments_model.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import 'package:forget_password/view/account_detail/account_detail_view.dart';
import 'package:forget_password/view/account_form/add_account_view.dart';
import 'package:forget_password/view/account_form/edit_account_view.dart';
import 'package:forget_password/view/error/error_view.dart';
import 'package:forget_password/view/ticket_form/ticket_form_view.dart';
import 'package:forget_password/view/splash/splash_view.dart';
import 'package:forget_password/view/home/home_view.dart';
import 'package:forget_password/view/user_guide/user_guide_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeView(),
        );
      case RoutesName.accountAddForm:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AddAccountView(),
        );
      case RoutesName.accountDetail:
        return MaterialPageRoute(
          builder: (BuildContext context) => AccountDetailView(
            dataModel: routeSettings.arguments as DataModel,
          ),
        );
      case RoutesName.accountEditForm:
        return MaterialPageRoute(
          builder: (BuildContext context) => EditAccountView(
            routeSettings.arguments as DataModel,
          ),
        );
      case RoutesName.userGuide:
        return MaterialPageRoute(
          builder: (BuildContext context) => const UserGuideView(),
        );
      case RoutesName.ticketForm:
        return MaterialPageRoute(
          builder: (BuildContext context) => TicketFormView(
            arguments: routeSettings.arguments as ArgumentsModel,
          ),
        );
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashView(),
        );
      case RoutesName.error:
        return MaterialPageRoute(
          builder: (BuildContext context) => ErrorView(
            errorMessage: routeSettings.arguments as String,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ErrorView(
            errorMessage: AppStr.navigatedToUnknownRouteErrorText,
          ),
        );
    }
  }
}
