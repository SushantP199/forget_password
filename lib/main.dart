import 'package:flutter/material.dart';
import 'package:forget_password/app.dart';

void main() async {
  /*
    Binding so that we connect flutter engine
    so that we access Shared Preferences of app
    even before app ui with that runApp method
  */
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ForgetPassword());

  /*
    Code to check reponsiveness of app
  */
  // runApp(
  //     DevicePreview(
  //       enabled: true,
  //       builder: (context) => const ForgetPassword(),
  //     ),
  //   );
}
