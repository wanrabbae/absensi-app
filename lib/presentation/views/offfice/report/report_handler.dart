import 'package:app/components/component_custom.dart';
import 'package:app/controllers/izin_controller.dart';
import 'package:app/helpers/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

final _imagePicker = ImagePicker();

handleAddReport(BuildContext context) {
  final pickedImage = _imagePicker.pickImage(
    source: kImageSource,
    preferredCameraDevice: CameraDevice.front,
    imageQuality: 50,
  );

  pickedImage.then((XFile? image) {
    if (image == null) {
      customSnackbar1(tr('snackbar_photo_required'));
      return;
    }

    final izinCtrl = Get.put(IzinController());
    // izinCtrl.updateFileFromFoto(PlatformFile(
    //   name: image.name,
    //   path: image.path,
    //   size: 0,
    // ));
    // Get.toNamed(RouteName.absenIzin, arguments: {
    //   "isFoto": true,
    // });
  });
}
