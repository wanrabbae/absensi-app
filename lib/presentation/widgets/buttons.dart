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
            disabledBackgroundColor: Colors.black.withOpacity(0.62),
            disabledForegroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: kGlobalFontFamily,
            ),
            minimumSize: const Size(64, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            elevation: 0,
          ),
        );

  HoraButton.withIcon({
    super.key,
    required super.onPressed,
    required Icon icon,
    required Widget label,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: kGlobalFontFamily,
            ),
            minimumSize: const Size(64, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            elevation: 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [icon, const SizedBox(width: 8), label],
          ),
        );

  HoraButton.white({
    super.key,
    required super.onPressed,
    required super.child,
  }) : super(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            disabledBackgroundColor: colorDisabled,
            disabledForegroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: kGlobalFontFamily,
            ),
            minimumSize: const Size(64, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            elevation: 0,
          ),
        );

  HoraButton.whiteWithIcon({
    super.key,
    required super.onPressed,
    required Icon icon,
    required Widget label,
  }) : super(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            disabledBackgroundColor: colorDisabled,
            disabledForegroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: kGlobalFontFamily,
            ),
            minimumSize: const Size(64, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            elevation: 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [icon, const SizedBox(width: 8), label],
          ),
        );
}
