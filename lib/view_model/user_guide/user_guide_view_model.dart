import 'package:flutter/material.dart';
import '../../model/arguments_model.dart';
import '../../utils/constants.dart';
import '../../utils/routes/routes_name.dart';

class UserGuideViewModel {
  void navigateToTicketFormView(BuildContext context) {
    Navigator.of(context).pushNamed(
      RoutesName.ticketForm,
      arguments: ArgumentsModel(
        oldTicket: KGlobal.EMPTY,
        isChangeRequest: false,
      ),
    );
  }
}
