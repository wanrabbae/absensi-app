import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/helpers/base.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/helpers/dialogs.dart';
import 'package:app/services/absensi_services.dart';
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
  final homeCtrl = Get.put(HomeController());

  if (homeCtrl.timer != null && homeCtrl.timer?.isActive) {
    final tanggal = homeCtrl.currentDate;
    final tglstart = DateTime(tanggal.year, tanggal.month, tanggal.day).toUtc();
    final tglend =
        DateTime(tanggal.year, tanggal.month, tanggal.day, 23, 59, 59).toUtc();
    final request = {
      "idkaryawan": homeCtrl.userProfile!.idkaryawan!,
      "tglstart": kQueryRangeDateFormat.format(tglstart),
      "tglend": kQueryRangeDateFormat.format(tglend),
    };
    var findData = await AbsensiServices().findIndiv(request);

    if (context.mounted) {
      showConfirmationDialog(
        context,
        tr('dialog_presence_title'),
        tr('dialog_presence_message'),
        buttonOk: tr('dialog_button_yes'),
        buttonCancel: tr('dialog_button_no'),
      ).then((confirmed) {
        if (confirmed == true) {
          Get.toNamed(RouteName.absen,
              arguments: {"dataAbsen": findData.data?[0], "pulang": 1});
        }
      });
    }
  } else {
    showConfirmationDialog(
      context,
      tr('dialog_logout_title'),
      tr('dialog_logout_message'),
      buttonOk: tr('dialog_button_yes'),
      buttonCancel: tr('dialog_button_no'),
    ).then((confirmed) {
      if (confirmed == true) {
        context.read<AppCubit>().clearToken();
      }
    });
  }
}
