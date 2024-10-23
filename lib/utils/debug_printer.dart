import 'package:flutter/foundation.dart';

class DebugPrinter {
  static void log(String string) {
    if (kDebugMode) {
      print("DEBUG: $string");
    }
  }
}
