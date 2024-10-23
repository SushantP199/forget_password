import 'package:flutter/material.dart';
import 'package:forget_password/res/app_strings.dart';
import 'package:forget_password/res/app_colors.dart';
import 'package:forget_password/res/components/custom_back_button.dart';
import 'package:forget_password/res/components/custom_button.dart';
import 'package:forget_password/res/components/custom_textformfield.dart';
import 'package:forget_password/res/components/obscure_textformfield.dart';
import 'package:forget_password/res/components/view_sub_title.dart';
import 'package:forget_password/res/dimension.dart';
import 'package:forget_password/utils/constants.dart';
import 'package:forget_password/utils/utils.dart';
import 'package:forget_password/res/components/custom_background_scaffold.dart';
import 'package:forget_password/view/error/error_view.dart';
import 'package:forget_password/view_model/account_form/account_form_model.dart';
import 'package:provider/provider.dart';
import '../../data/response/status.dart';

// ignore: must_be_immutable
class AccountFormView extends StatelessWidget {
  final TextEditingController accountController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final FocusNode accountFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  final String accountId;

  const AccountFormView({
    required this.accountController,
    required this.usernameController,
    required this.passwordController,
    required this.accountFocusNode,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    required this.accountId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AccountFormViewModel accountFormViewModel = Provider.of<AccountFormViewModel>(context, listen: false);

    return Consumer<AccountFormViewModel>(
      builder: (context, value, child) {
        if (accountFormViewModel.saveAccount.status == Status.ERROR) {
          return ErrorView(errorMessage: accountFormViewModel.saveAccount.message.toString());
        } else {
          return CustomBackgroundScaffold(
            shouldPop: true,
            child: Column(
              children: [
                CustomBackButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Flexible(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (accountId == KGlobal.EMPTY)
                              ? const ViewSubTitle(
                                  title: AppStr.addAccount,
                                )
                              : const ViewSubTitle(
                                  title: AppStr.editAccount,
                                ),
                          // Account
                          CustomTextFormField(
                            accountController,
                            AppStr.accountTextFieldHintText,
                            focusNode: accountFocusNode,
                            onFieldSubmitted: (value) {
                              usernameFocusNode.requestFocus();
                            },
                          ),
                          SizedBox(height: Dimension.heightMultiplier * 1.5),
                          // User or email id
                          CustomTextFormField(
                            usernameController,
                            AppStr.usernameTextFieldHintText,
                            focusNode: usernameFocusNode,
                            onFieldSubmitted: (value) {
                              passwordFocusNode.requestFocus();
                            },
                          ),
                          SizedBox(height: Dimension.heightMultiplier * 1.5),
                          // Password
                          ObscureTextFormField(
                            obscureFieldController: passwordController,
                            hintText: AppStr.passwordTextFieldHintText,
                            maxLength: KGlobal.KMaxPassLen,
                            focusNode: passwordFocusNode,
                            onFieldSubmitted: (value) {
                              passwordFocusNode.unfocus();
                            },
                          ),
                          SizedBox(height: Dimension.heightMultiplier * 2),
                          // Save
                          CustomButton(
                            () {
                              passwordFocusNode.unfocus();

                              AccountFormViewModel().save(
                                context: context,
                                account:  Utils.cleanString(accountController.text),
                                username:  Utils.cleanString(usernameController.text),
                                password: passwordController.text,
                                accountId: accountId
                              );
                            },
                            AppColors.purple,
                            AppStr.submitAcccountButtonText,
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
      },
    );
  }
}
