import 'package:app/core/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'buttons.dart';

Future<dynamic> showHoraLoadingBottomSheet(
  BuildContext context, {
  VoidCallback? onCancel,
}) {
  return showHoraCustomBottomSheet(
    context,
    title: tr('bottom_sheet_loading_title'),
    isDismissible: false,
    content: Center(
      child: LoadingAnimationWidget.prograssiveDots(
        color: colorBluePrimary2,
        size: 96,
      ),
    ),
    button: HoraButton(
      onPressed: onCancel != null
          ? () {
              Navigator.pop(context);
              onCancel.call();
            }
          : null,
      child: Text(tr('bottom_sheet_loading_button')),
    ),
  );
}

Future<dynamic> showHoraInfoBottomSheet(
  BuildContext context, {
  required String title,
  required String message,
  VoidCallback? onButtonClose,
}) {
  return showHoraConfirmationBottomSheet(
    context,
    title: title,
    isDismissible: false,
    message: message,
    button: HoraButton(
      onPressed: () {
        Navigator.pop(context);
        onButtonClose?.call();
      },
      child: Text(tr('bottom_sheet_info_button')),
    ),
  );
}

Future<dynamic> showHoraConfirmationBottomSheet(
  BuildContext context, {
  required String title,
  required String message,
  required HoraButton button,
  bool isDismissible = true,
}) {
  return showHoraCustomBottomSheet(
    context,
    title: title,
    isDismissible: isDismissible,
    content: Text(
      message,
      style: const TextStyle(fontSize: 18),
      textAlign: TextAlign.center,
    ),
    button: button,
  );
}

Future<dynamic> showHoraCustomBottomSheet(
  BuildContext context, {
  required String title,
  required Widget content,
  required Widget button,
  bool slideUpWithKeyboard = false,
  bool isDismissible = true,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    barrierColor: Colors.black54,
    isScrollControlled: true,
    isDismissible: isDismissible,
    builder: (context) {
      return HoraBottomSheet(
        title: title,
        content: content,
        button: button,
        slideUpWithKeyboard: slideUpWithKeyboard,
      );
    },
  );
}

class HoraBottomSheet extends StatelessWidget {
  const HoraBottomSheet({
    super.key,
    required this.title,
    required this.content,
    required this.button,
    this.slideUpWithKeyboard = false,
  });

  final String title;
  final Widget content;
  final Widget button;
  final bool slideUpWithKeyboard;

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(height: 2, width: 20, color: colorBottomSheetDrag),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        content,
        const SizedBox(height: 16),
        button,
      ],
    );

    EdgeInsets padding = const EdgeInsets.all(16);
    if (slideUpWithKeyboard) {
      final mediaQuery = MediaQuery.of(context);
      final keyboardSize = mediaQuery.viewInsets.bottom;
      padding = EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSize);
    }

    child = Padding(padding: padding, child: child);

    if (slideUpWithKeyboard) {
      child = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => dismissKeyboard(context),
        child: child,
      );
    }

    return child;
  }
}

void dismissKeyboard([BuildContext? context]) {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  if (context != null) {
    FocusScope.of(context).unfocus();
  }
}
