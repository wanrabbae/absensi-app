import 'dart:async';

import 'package:app/components/dialog_permission.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';

import 'camera_view.dart';
import 'painters/face_detector_painter.dart';

class TakeCameraPictureView extends StatefulWidget {
  const TakeCameraPictureView({super.key});

  static Future<dynamic> show(BuildContext context) async {
    final route = MaterialPageRoute(
      builder: (context) {
        return const TakeCameraPictureView();
      },
    );

    if (await Permission.camera.isGranted &&
        await Permission.location.isGranted &&
        context.mounted) {
      return Navigator.push(context, route);
    }

    if (context.mounted) {
      return showHoraCustomBottomSheet(
        context,
        title: tr('dialog_permission_title'),
        content: Column(children: dialogPermissionChildren()),
        button: HoraButton(
          onPressed: () => handlePermission(context),
          child: Text(tr('next')),
        ),
      ).then((granted) {
        if (granted == true && context.mounted) {
          return Navigator.push(context, route);
        }
      });
    }

    return null;
  }

  @override
  State<TakeCameraPictureView> createState() => _TakeCameraPictureViewState();
}

class _TakeCameraPictureViewState extends State<TakeCameraPictureView> {
  final _rxFaceDetected = ValueNotifier(false);
  final _cameraController = Completer<CameraController>();
  final _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: false,
      enableLandmarks: false,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  var _cameraLensDirection = CameraLensDirection.front;

  @override
  void dispose() {
    _cameraController.future.then((value) => value.dispose());
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CameraView(
          customPaint: _customPaint,
          onImage: _processImage,
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
          onCameraController: (controller) {
            if (_cameraController.isCompleted) return;
            _cameraController.complete(controller);
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          minimum: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ValueListenableBuilder(
            valueListenable: _rxFaceDetected,
            builder: (context, faceDetected, child) {
              Widget label = Text(tr('take_picture'));
              if (!faceDetected) {
                label = Text(tr('take_picture_disabled'));
              }

              Icon icon = const Icon(Icons.fingerprint_outlined);
              if (!faceDetected) {
                icon = const Icon(Icons.highlight_off_outlined);
              }

              return HoraButton.withIcon(
                onPressed: !faceDetected
                    ? null
                    : () {
                        takePicture().then((image) async {
                          await _cameraController.future.then((c) {
                            return c.pausePreview();
                          });

                          return image;
                        }).then((image) {
                          if (image != null) {
                            Navigator.pop(context, image);
                          }
                        });
                      },
                icon: icon,
                label: label,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {});
    final faces = await _faceDetector.processImage(inputImage);
    _rxFaceDetected.value = faces.isNotEmpty;
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController cameraController = await _cameraController.future;
    if (!cameraController.value.isInitialized) {
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      cameraController.setFlashMode(FlashMode.off);
      return await cameraController.takePicture();
    } on CameraException catch (_) {
      return null;
    }
  }
}
