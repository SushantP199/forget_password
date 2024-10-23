import 'package:flutter/material.dart';
import 'package:forget_password/model/data_model.dart';
import 'package:forget_password/view/account_form/account_form_view.dart';

class EditAccountView extends StatefulWidget {
  final DataModel dataModel;

  const EditAccountView(this.dataModel, {super.key});

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
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

    _accountController?.text = widget.dataModel.userModel.account;
    _usernameController?.text = widget.dataModel.userModel.username;
    _passwordController?.text = widget.dataModel.userModel.password;

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
      accountId: widget.dataModel.id,
    );
  }
}
