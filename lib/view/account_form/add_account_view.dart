import 'package:flutter/material.dart';
import 'package:forget_password/utils/constants.dart';
import 'package:forget_password/view/account_form/account_form_view.dart';

class AddAccountView extends StatefulWidget {
  const AddAccountView({super.key});

  @override
  State<AddAccountView> createState() => _AddAccountViewState();
}

class _AddAccountViewState extends State<AddAccountView> {
  TextEditingController? _accountController;
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;

  FocusNode? _accountFocusNode;
  FocusNode? _usernameFocusNode;
  FocusNode? _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _accountFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _accountController?.dispose();
    _usernameController?.dispose();
    _passwordController?.dispose();

    _accountFocusNode?.dispose();
    _usernameFocusNode?.dispose();
    _passwordFocusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AccountFormView(
      accountController: _accountController!,
      usernameController: _usernameController!,
      passwordController: _passwordController!,
      accountFocusNode: _accountFocusNode!,
      usernameFocusNode: _usernameFocusNode!,
      passwordFocusNode: _passwordFocusNode!,
      accountId: KGlobal.EMPTY,
    );
  }
}
