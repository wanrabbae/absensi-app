import 'dart:async';

import 'package:app/clients/DocumentClient.dart';
import 'package:app/clients/GetStorageClient.dart';
import 'package:app/firebase_models/user_fm.dart';
import 'package:app/helpers/base.dart';
import 'package:app/helpers/location_helper.dart';
import 'package:app/models/user_model/user_model.dart';
import 'package:flamingo/flamingo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationStream {
  static StreamSubscription<Position>? _positionStream;
  static set positionStream(StreamSubscription<Position>? value) {
    _positionStream = value;
  }

  static StreamSubscription<Position>? get positionStream => _positionStream;
  static Future<void> start(Rx<bool> isEnabled) async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      isEnabled.value = false;
    } else {
      isEnabled.value = true;
    }
    positionStream ??= Geolocator.getPositionStream(locationSettings: LocationHelper().locationSettings()).listen(
      (event) async {
        isEnabled.value = true;
        UserModel localUserModel = UserModel.fromJson(GetStorageClient.instance().read(Base.dataUser));
        await GetStorageClient.instance().write(Base.userLiveLoc, localUserModel.copyWith(liveLat: event.latitude, liveLng: event.longitude).toJson());
        UserFm localUserFm = UserFm(id: localUserModel.idkaryawan);
        await DocumentClient.instance().save<UserFm>(
          localUserFm
            ..location = GeoPoint(event.latitude, event.longitude)
            ..isLive = true
            ..idkaryawan = localUserModel.idkaryawan,
        );
      },
      cancelOnError: false,
    )..onError((e) {
        start(isEnabled);
      });
  }

  static StreamSubscription<ServiceStatus>? _serviceStatusStream;
  static set serviceStatusStream(StreamSubscription<ServiceStatus>? value) {
    _serviceStatusStream = value;
  }

  static StreamSubscription<ServiceStatus>? get serviceStatusStream => _serviceStatusStream;
  static Future<void> startServiceStatusStream(Rx<bool> isEnabled) async {
    isEnabled.value = await Geolocator.isLocationServiceEnabled();
    _serviceStatusStream ??= Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status.index == ServiceStatus.disabled.index) {
        start(isEnabled);
      } else {
        start(isEnabled);
      }
    })
      ..onError((e) {
        startServiceStatusStream(isEnabled);
      });
  }
}
