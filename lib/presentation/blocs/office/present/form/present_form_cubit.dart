import 'dart:io';

import 'package:app/core/enums.dart';
import 'package:app/data/models/absence.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/helpers/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

part 'present_form_state.dart';

part 'present_form_cubit.freezed.dart';

class PresentFormCubit extends Cubit<PresentFormState> {
  PresentFormCubit({
    required this.api,
    Absence? currentAttendance,
    required Profile user,
  }) : super(PresentFormState(
          currentAttendance: currentAttendance,
          user: user,
        ));

  final ApiService api;
  final imagePicker = ImagePicker();
  CancelToken? _token;

  Future<void> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 5),
    );
    final location = LatLng(position.latitude, position.longitude);
    final places = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    final p = places.isNotEmpty ? places.first : null;
    final address = p != null
        ? '${p.street}, ${p.subLocality}, ${p.locality}, ${p.subAdministrativeArea}, ${p.administrativeArea}, ${p.postalCode}'
        : '';
    if (isClosed) return;
    emit(state.copyWith(currentLocation: location, address: address));
  }

  Future<void> checkIn(CancelToken token) async {
    final image = await imagePicker.pickImage(
      source: kImageSource,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 40,
    );

    if (image == null) return;

    _token = token;

    try {
      emit(state.copyWith(submitAttendanceStatus: PageStatus.busy));
      await api.checkIn(
        companyId: state.user.perusahaanId!,
        companyName: state.user.perusahaan!,
        staffId: state.user.idkaryawan!,
        staffName: state.user.name,
        address: state.address,
        latitude: state.currentLocation.latitude.toString(),
        longitude: state.currentLocation.longitude.toString(),
        photo: File(image.path),
        cancelToken: token,
      );
      emit(state.copyWith(submitAttendanceStatus: PageStatus.succeed));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        debugPrintStack(stackTrace: s);
      }
      emit(state.copyWith(submitAttendanceStatus: PageStatus.failed));
    } finally {
      _token = null;
    }
  }

  Future<void> checkOut(CancelToken token) async {
    final image = await imagePicker.pickImage(
      source: kImageSource,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 40,
    );

    if (image == null) return;

    _token = token;

    try {
      emit(state.copyWith(
        submitAttendanceStatus: PageStatus.busy,
        isCheckingIn: false,
      ));
      await api.checkOut(
        id: state.currentAttendance!.id,
        staffName: state.user.name,
        address: state.address,
        latitude: state.currentLocation.latitude.toString(),
        longitude: state.currentLocation.longitude.toString(),
        photo: File(image.path),
        cancelToken: token,
      );
      emit(state.copyWith(submitAttendanceStatus: PageStatus.succeed));
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        debugPrintStack(stackTrace: s);
      }
      emit(state.copyWith(submitAttendanceStatus: PageStatus.failed));
    } finally {
      _token = null;
    }
  }

  void cancelRequest() => _token?.cancel();
}
