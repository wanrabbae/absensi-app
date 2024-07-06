import 'dart:io';

import 'package:app/components/component_custom.dart';
import 'package:app/helpers/base.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/presentation/blocs/work/work_cubit.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final _imagePicker = ImagePicker();

handleFabReimburse(BuildContext context) async {
  final cameraStatus = await Permission.camera.status;
  if (cameraStatus.isDenied) {
    Permission.camera.request();
    return;
  }

  if (!cameraStatus.isGranted) {
    customSnackbar1(tr('snackbar_photo_required'));
    return;
  }

  if (!context.mounted) return;

  final confirm = await showHoraConfirmationBottomSheet(
    context,
    title: tr('menu_work_reimburse'),
    message: tr('work_reimburse_submission_confirmation'),
    button: HoraButton(
      onPressed: () {
        Navigator.pop(context, true);
      },
      child: Text(tr('report_submission_button')),
    ),
  );

  if (confirm == true) {
    try {
      final photo = await pickImage();

      if (photo != null) {
        Get.toNamed(RouteName.klaimForm, arguments: photo)?.then((succeed) {
          if (succeed == true) {
            final cubit = context.read<WorkCubit>();
            cubit.getReimbursement();
          }
        });
      } else {
        customSnackbar1(tr('snackbar_taking_photo_canceled'));
      }
    } catch (e) {
      customSnackbar1(tr('snackbar_taking_photo_failed'));
    }
  }
}

Future<XFile?> pickImage() {
  return _imagePicker.pickImage(
    source: kImageSource,
    preferredCameraDevice: CameraDevice.rear,
    imageQuality: 40,
    maxWidth: 1024,
    maxHeight: 1024,
    requestFullMetadata: Platform.isAndroid,
  );
}
