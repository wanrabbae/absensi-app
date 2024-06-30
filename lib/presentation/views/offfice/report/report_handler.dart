import 'dart:io';

import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/data/models/report/report.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/presentation/blocs/report/report_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'report_form_view.dart';

final _imagePicker = ImagePicker();

Future<dynamic> handleAddReport(BuildContext context, ReportType type) {
  final app = context.read<AppCubit>();
  final state = app.state;

  return pickImage().then((XFile? image) {
    if (image == null) {
      return null;
    }

    Get.put(ReportCubit(
      image: image,
      type: type,
      user: state.currentUser!,
      company: state.company,
    ));
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
    imageQuality: 40,
    maxWidth: 1024,
    maxHeight: 1024,
    requestFullMetadata: Platform.isAndroid,
  );
}
