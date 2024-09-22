import 'package:app/core/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'buttons.dart';
import 'loading.dart';

typedef HoraLoadingWidgetBuilder<T> = Widget Function(
    BuildContext context, Widget loading);

Future<dynamic> showHoraLoadingBottomSheet(
  BuildContext context, {
  HoraLoadingWidgetBuilder? builder,
  VoidCallback? onCancel,
}) {
  const loading = Center(child: LoadingAnimation());

  return showHoraCustomBottomSheet(
    context,
    title: tr('bottom_sheet_loading_title'),
    isDismissible: false,
    content: builder == null ? loading : builder(context, loading),
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
  bool disableBackButton = false,
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
        disableBackButton: disableBackButton,
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
    this.disableBackButton = false,
  });

  final String title;
  final Widget content;
  final Widget button;
  final bool slideUpWithKeyboard;
  final bool disableBackButton;

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

    child = SafeArea(minimum: padding, child: child);

    if (slideUpWithKeyboard) {
      child = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => dismissKeyboard(context),
        child: child,
      );
    }

    if (disableBackButton) {
      child = PopScope(canPop: false, child: child);
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

Future<dynamic> showHoraCustomListBottomSheet(
  BuildContext context, {
  required List<ListTile> children,
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
      return HoraListBottomSheet(children: children);
    },
  );
}

class HoraListBottomSheet extends StatelessWidget {
  const HoraListBottomSheet({
    super.key,
    required this.children,
  });

  final List<ListTile> children;

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
        ...ListTile.divideTiles(color: colorDivider, tiles: children),
      ],
    );

    return SafeArea(minimum: const EdgeInsets.all(16), child: child);
  }
}
