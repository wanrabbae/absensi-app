import 'package:app/core/themes.dart';
import 'package:app/helpers/constant.dart';
import 'package:flutter/material.dart';

class HoraButton extends ElevatedButton {
  HoraButton({
    super.key,
    required super.onPressed,
    required super.child,
  }) : super(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorBluePrimary2,
            foregroundColor: Colors.white,
            disabledBackgroundColor: colorDisabled,
            disabledForegroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: kGlobalFontFamily,
            ),
            minimumSize: const Size.fromHeight(44),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            elevation: 0,
          ),
        );
}
