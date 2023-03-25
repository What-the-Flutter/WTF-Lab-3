import 'package:flutter/material.dart';

class Utilities {
  static bool isKeyboardShowing() {
    return WidgetsBinding.instance.window.viewInsets.bottom > 0;
  }

  static void closeKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
