import 'package:app/data/models/report/report.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/presentation/blocs/report/report_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'report_form_view.dart';

final _imagePicker = ImagePicker();

Future<dynamic> handleAddReport(BuildContext context, ReportType type) {
  return pickImage().then((XFile? image) {
    if (image == null) {
      return null;
    }

    Get.put(ReportCubit(image: image, type: type));
    return Get.toNamed('/$ReportFormView')?.then((value) {
      Get.delete<ReportCubit>();
      return value;
    });
  });
}

Future<XFile?> pickImage() {
  return _imagePicker.pickImage(
    source: kImageSource,
    preferredCameraDevice: CameraDevice.front,
    imageQuality: 50,
  );
}