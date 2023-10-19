import 'dart:async';

import 'package:app/clients/DocumentClient.dart';
import 'package:app/clients/GetStorageClient.dart';
import 'package:app/firebase_models/user_fm.dart';
import 'package:app/helpers/base.dart';
import 'package:app/helpers/location_helper.dart';
import 'package:app/models/user_model/user_model.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationStream {
  static StreamSubscription<Position>? _positionStream;
  static set positionStream(StreamSubscription<Position>? value) {
    _positionStream = value;
  }

  static StreamSubscription<Position>? get positionStream => _positionStream;
  static Future<void> start() async {
    positionStream ??= Geolocator.getPositionStream(locationSettings: LocationHelper().locationSettings()).listen((event) async {
      UserModel localUserModel = UserModel.fromJson(GetStorageClient.instance().read(Base.dataUser));
      await GetStorageClient.instance().write(Base.userLiveLoc, localUserModel.copyWith(liveLat: event.latitude, liveLng: event.longitude).toJson());
      UserFm localUserFm = UserFm(id: localUserModel.idkaryawan);
      await DocumentClient.instance().save<UserFm>(
        localUserFm
          ..location = GeoPoint(event.latitude, event.longitude)
          ..isLive = true
          ..idkaryawan = localUserModel.idkaryawan,
      );
    });
  }

  static StreamSubscription<ServiceStatus>? _serviceStatusStream;
  static set serviceStatusStream(StreamSubscription<ServiceStatus>? value) {
    _serviceStatusStream = value;
  }

  static StreamSubscription<ServiceStatus>? get serviceStatusStream => _serviceStatusStream;
  static Future<void> startServiceStatusStream(BuildContext context) async {
    serviceStatusStream ??= Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      }
      if (status == ServiceStatus.disabled) {
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text('Location service disabled'), actions: []));
      }
    });
  }

  static StreamSubscription<LocationPermission>? _checkPermissionStream;
  static set checkPermissionStream(StreamSubscription<LocationPermission>? value) {
    _checkPermissionStream = value;
  }

  static StreamSubscription<LocationPermission>? get checkPermissionStream => _checkPermissionStream;
  static Future<void> startCheckPermissionStream(BuildContext context) async {
    checkPermissionStream ??= Geolocator.checkPermission().asStream().listen((LocationPermission permission) async {
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text('Izin lokasi ditolak'), actions: [
          TextButton(
            onPressed: () {
              Geolocator.requestPermission();
            },
            child: Text('Minta izin lokasi'),
          ),
        ]));
      } else if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: Text('Izin lokasi tidak ada'), actions: [
          TextButton(
            onPressed: () {
              Geolocator.openAppSettings();
            },
            child: Text('Buka pengaturan'),
          ),
        ]));
      } else {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      }
    });
  }
}
