import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void dismissKeyboard([BuildContext? context]) {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  if (context != null) {
    FocusScope.of(context).unfocus();
  }
}