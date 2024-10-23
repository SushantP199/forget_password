import 'package:flutter/material.dart';
import 'package:forget_password/data/response/status.dart';
import 'package:forget_password/model/arguments_model.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/components/custom_back_button.dart';
import 'package:forget_password/res/components/custom_background_scaffold.dart';
import 'package:forget_password/res/components/custom_button.dart';
import 'package:forget_password/res/components/obscure_textformfield.dart';
import 'package:forget_password/res/components/view_sub_title.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/utils/routes/routes_name.dart';
import 'package:forget_password/utils/utils.dart';
import 'package:forget_password/view/error/error_view.dart';
import 'package:forget_password/view_model/ticket_form/ticket_view_model.dart';
import 'package:provider/provider.dart';

class TicketFormView extends StatefulWidget {
  final ArgumentsModel arguments;

  const TicketFormView({
    super.key,
    required this.arguments,
  });

  @override
  State<TicketFormView> createState() => _TicketFormViewState();
}

class _TicketFormViewState extends State<TicketFormView> {
  TextEditingController? _ticketController;
  TextEditingController? _ticketConfirmController;
  TextEditingController? _ticketConfirmAgainController;

  FocusNode? _tikcetfocusNode;
  FocusNode? _ticketConfirmfocusNode;
  FocusNode? _ticketConfirmAgaintikcetfocusNode;

  @override
  void initState() {
    super.initState();
    _ticketController = TextEditingController();
    _ticketConfirmController = TextEditingController();
    _ticketConfirmAgainController = TextEditingController();

    _tikcetfocusNode = FocusNode();
    _ticketConfirmfocusNode = FocusNode();
    _ticketConfirmAgaintikcetfocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _ticketController?.dispose();
    _ticketConfirmController?.dispose();
    _ticketConfirmAgainController?.dispose();

    _tikcetfocusNode?.dispose();
    _ticketConfirmfocusNode?.dispose();
    _ticketConfirmAgaintikcetfocusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TicketViewModel ticketViewModel =
        Provider.of<TicketViewModel>(context, listen: false);

    return Consumer<TicketViewModel>(builder: (context, value, child) {
      Status? status = ticketViewModel.isTicketSet.status;

      if (status == Status.ERROR) {
        return ErrorView(
            errorMessage: ticketViewModel.isTicketSet.message.toString());
      } else {
        return CustomBackgroundScaffold(
          shouldPop: true,
          child: Column(
            children: [
              (widget.arguments.isChangeRequest)
                  ? CustomBackButton(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RoutesName.home);
                      },
                    )
                  : Container(),
              Flexible(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (widget.arguments.isChangeRequest)
                            ? const ViewSubTitle(
                                title: AppStr.changeTicket,
                              )
                            : const ViewSubTitle(
                                title: AppStr.setTicket,
                              ),
                        SizedBox(height: Dimension.heightMultiplier * 1.5),
                        ObscureTextFormField(
                          obscureFieldController: _ticketController!,
                          hintText: widget.arguments.isChangeRequest
                              ? AppStr.enterTicketHintText
                              : AppStr.enternewTicketHintText,
                          focusNode: _tikcetfocusNode,
                          maxLength: 8,
                          onFieldSubmitted: (vlaue) {
                            Utils.focusNext(
                              context,
                              _tikcetfocusNode!,
                              _ticketConfirmfocusNode!,
                            );
                          },
                        ),
                        SizedBox(height: Dimension.heightMultiplier * 1.5),
                        ObscureTextFormField(
                          obscureFieldController: _ticketConfirmController!,
                          hintText: widget.arguments.isChangeRequest
                              ? AppStr.enterTicketConfirmHintText
                              : AppStr.enternewTicketConfirmHintText,
                          focusNode: _ticketConfirmfocusNode,
                          maxLength: 8,
                          onFieldSubmitted: (vlaue) {
                            Utils.focusNext(
                              context,
                              _ticketConfirmfocusNode!,
                              _ticketConfirmAgaintikcetfocusNode!,
                            );
                          },
                        ),
                        SizedBox(height: Dimension.heightMultiplier * 1.5),
                        ObscureTextFormField(
                          obscureFieldController:
                              _ticketConfirmAgainController!,
                          hintText: widget.arguments.isChangeRequest
                              ? AppStr.enterTicketConfirmAgainHintText
                              : AppStr.enternewTicketConfirmAgainHintText,
                          focusNode: _ticketConfirmAgaintikcetfocusNode,
                          maxLength: 8,
                          onFieldSubmitted: (value) {
                            _ticketConfirmAgaintikcetfocusNode?.unfocus();
                          },
                        ),
                        SizedBox(height: Dimension.heightMultiplier * 2),
                        CustomButton(
                          () {
                            _ticketConfirmAgaintikcetfocusNode?.unfocus();

                            ticketViewModel.set(
                              context: context,
                              ticket: _ticketController!.text,
                              confirmTicket: _ticketConfirmController!.text,
                              confirmAgaintTicket:
                                  _ticketConfirmAgainController!.text,
                              isChangeRequest: widget.arguments.isChangeRequest,
                              oldTicket: widget.arguments.oldTicket,
                            );
                          },
                          AppColors.purple,
                          AppStr.submitTicketButtonText,
                          AppColors.white,
                          Dimension.widthMultiplier * 13.5,
                          double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
