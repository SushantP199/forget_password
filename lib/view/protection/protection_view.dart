import 'package:flutter/material.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/components/custom_button.dart';
import 'package:forget_password/res/components/obscure_textformfield.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/utils/utils.dart';
import 'package:forget_password/view/protection/coding_view.dart';
import 'package:forget_password/view_model/protection/protection_view_view_model.dart';
import 'package:provider/provider.dart';
import '../../res/app_colors.dart';

class ProtectionView extends StatefulWidget {
  final DataModel? dataModel;
  final int incorrectTickets;
  final bool? encrypt;
  final bool? decrypt;
  final bool? isChangeRequest;

  const ProtectionView({
    this.dataModel,
    required this.incorrectTickets,
    this.encrypt,
    this.decrypt,
    this.isChangeRequest,
    super.key,
  });

  @override
  State<ProtectionView> createState() => _ProtectionViewState();
}

class _ProtectionViewState extends State<ProtectionView> {
  TextEditingController? _ticketController = TextEditingController();
  ValueNotifier<int>? _attemptsValueNotifer;
  FocusNode? _ticketFocusNode;

  @override
  void initState() {
    super.initState();
    _ticketController = TextEditingController();
    _ticketFocusNode = FocusNode();
    _attemptsValueNotifer = ValueNotifier(widget.incorrectTickets);
  }

  @override
  void dispose() {
    super.dispose();
    _ticketController?.dispose();
    _ticketFocusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        scrollable: true,
        contentPadding: EdgeInsets.all(Dimension.widthMultiplier * 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimension.widthMultiplier * 2.5,
          ),
        ),
        content: ChangeNotifierProvider<ProtectionViewViewModel>(
          create: (context) => ProtectionViewViewModel(),
          builder: (context, child) {
            return Consumer<ProtectionViewViewModel>(
              builder: (context, value, child) {
                return (value.isDataBeingCoded)
                    ? CodingView(
                        codingType: widget.encrypt == true
                            ? AppStr.encryptingLoadingText
                            : AppStr.decryptingLoadingText,
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                AppStr.protectionWallTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppStr.fontFamily,
                                  fontSize: Dimension.textMultiplier * 5,
                                  color: AppColors.purple,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.exit_to_app_rounded,
                                  color: AppColors.purple,
                                  size: Dimension.widthMultiplier * 6,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimension.widthMultiplier * 5),
                          ObscureTextFormField(
                            obscureFieldController: _ticketController!,
                            hintText: AppStr.enterTicketHintText,
                            maxLength: 8,
                            focusNode: _ticketFocusNode,
                            onFieldSubmitted: (value) {
                              _ticketFocusNode?.unfocus();

                              ProtectionViewViewModel().yield(
                                context: context,
                                attemptsValueNotifer: _attemptsValueNotifer!,
                                ticket:
                                    Utils.cleanString(_ticketController!.text),
                                dataModel: widget.dataModel,
                                encrypt: widget.encrypt,
                                decrypt: widget.decrypt,
                                isChangeRequest: widget.isChangeRequest,
                              );
                            },
                          ),
                          SizedBox(height: Dimension.heightMultiplier * 1),
                          CustomButton(
                            () {
                              _ticketFocusNode?.unfocus();

                              ProtectionViewViewModel().yield(
                                context: context,
                                attemptsValueNotifer: _attemptsValueNotifer!,
                                ticket:
                                    Utils.cleanString(_ticketController!.text),
                                dataModel: widget.dataModel,
                                encrypt: widget.encrypt,
                                decrypt: widget.decrypt,
                                isChangeRequest: widget.isChangeRequest,
                              );
                            },
                            AppColors.purple,
                            AppStr.submitTicketProtectionWallText,
                            AppColors.white,
                            Dimension.widthMultiplier * 13,
                            double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: Dimension.widthMultiplier * 4,
                            ),
                            child: ValueListenableBuilder(
                              valueListenable: _attemptsValueNotifer!,
                              builder: (context, value, child) {
                                if (_attemptsValueNotifer?.value == 0) {
                                  return Container();
                                }

                                return Text(
                                  "${AppStr.wrongTicketAttemptsCountNotifierText}${_attemptsValueNotifer?.value}",
                                  style: TextStyle(
                                    fontFamily: AppStr.fontFamily,
                                    fontSize: Dimension.textMultiplier * 3,
                                    color: AppColors.richPurple,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
