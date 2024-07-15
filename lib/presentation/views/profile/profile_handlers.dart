import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/helpers/base.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

handleChangeLanguage(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: [
          SimpleDialogOption(
            child: Text(
              'Indonesia',
              style: context.locale == kLocaleID
                  ? const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )
                  : const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
            ),
            onPressed: () {
              Navigator.pop(context, kLocaleID);
            },
          ),
          SimpleDialogOption(
            child: Text('English',
                style: context.locale == kLocaleEN
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    : null),
            onPressed: () {
              Navigator.pop(context, kLocaleEN);
            },
          ),
        ],
      );
    },
  ).then((value) {
    if (value is Locale) {
      context.setLocale(value);
      Get.updateLocale(value);
    }
  });
}

handleShowTerms(BuildContext context) {
  Get.toNamed(
    RouteName.webview,
    arguments: "https://docs.horaapp.id/#kebijakan",
  );
}

handleShowPrivacy(BuildContext context) {
  Get.toNamed(
    RouteName.webview,
    arguments: "https://docs.horaapp.id/#privasi",
  );
}

handleShowStory(BuildContext context) {
  Get.toNamed(
    RouteName.webview,
    arguments: "https://docs.horaapp.id/#kisah",
  );
}

handleShowSoftware(BuildContext context) {
  Get.toNamed(
    RouteName.webview,
    arguments: "https://docs.horaapp.id/#perangkatlunak",
  );
}

handleShowFaq(BuildContext context) {
  Get.toNamed(
    RouteName.webview,
    arguments: "https://docs.horaapp.id/#faq",
  );
}

handleShowContact(BuildContext context) {
  Get.toNamed(
    RouteName.webview,
    arguments: "https://horaapp.id/#contact",
  );
}

handleLogOut(BuildContext context) async {
  // TODO: check if any check in data, then check out if any
  showHoraConfirmationBottomSheet(
    context,
    title: tr('dialog_logout_title'),
    message: tr('dialog_logout_message'),
    button: HoraButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text(tr('dialog_logout_button')),
    ),
  ).then((confirmed) {
    if (confirmed == true) {
      context.read<AppCubit>().clearToken();
    }
  });
}
