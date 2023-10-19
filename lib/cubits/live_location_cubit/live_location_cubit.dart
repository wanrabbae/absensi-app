import 'package:app/clients/DioClient.dart';
import 'package:app/clients/DocumentClient.dart';
import 'package:app/clients/GetStorageClient.dart';
import 'package:app/firebase_models/user_fm.dart';
import 'package:app/helpers/base.dart';
import 'package:app/models/user_model/user_model.dart';
import 'package:app/streams/location_stream.dart';
import 'package:app/ui/widgets/custom_marker.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

part 'live_location_state.dart';

class LiveLocationCubit extends Cubit<LiveLocationState> {
  LiveLocationCubit() : super(LiveLocationInitial());

  Future<Uint8List?> _urlToBytes(String? url) async {
    if (url == null) {
      return null;
    }
    var data = await DioClient.instance().get<Uint8List?>(url, options: Options(responseType: ResponseType.bytes));
    return data.data;
  }

  Future<LiveLocationOk?> fetch({
    feature = 'fetch',
    UserModel? userModel,
    isNeedSuffixState = true,
  }) async {
    try {
      emit(LiveLocationLoading());
      var userFm = UserFm(id: userModel?.idkaryawan);
      UserFm? result;
      result = await DocumentClient.instance().load<UserFm>(
        userFm,
        fromCache: (p0) {
          if (p0 != null) {
            result = p0;
          }
        },
        source: Source.serverAndCache,
      );

      final loginUserModel = UserModel.fromJson(GetStorageClient.instance().read(Base.dataUser));
      final state = LiveLocationOk(
        feature: feature,
        data: result,
        extra: {
          'userModel': userModel?.copyWith(
            imageBytes: await _urlToBytes(userModel.fotoUrl),
            customMarker: await CustomMarker(userModel: userModel).toBitmapDescriptor(),
          ),
          'isCurrentUser': userModel?.idkaryawan == loginUserModel.idkaryawan,
        },
      );
      if (isNeedSuffixState) {
        emit(state);
      }
      return state;
    } catch (e) {
      emit(LiveLocationInitial());
      return null;
    }
  }

  Future<void> storeFetch({
    feature = 'storeFetch',
    UserModel? userModel,
  }) async {
    try {
      emit(LiveLocationLoading());
      UserModel loginUserModel = UserModel.fromJson(GetStorageClient.instance().read(Base.dataUser));
      LiveLocationOk? state;
      if (userModel?.idkaryawan == loginUserModel.idkaryawan) {
        await store(loginUserModel: loginUserModel, isNeedSuffixState: false);
        state = await fetch(userModel: userModel, isNeedSuffixState: false);
      }
      if (userModel?.idkaryawan != loginUserModel.idkaryawan) {
        state = await fetch(userModel: userModel, isNeedSuffixState: false);
      }
      emit(LiveLocationOk(
        feature: feature,
        data: state?.data,
      ));
    } catch (e) {
      emit(LiveLocationInitial());
    }
  }

  Future<void> store({
    feature = 'store',
    UserModel? loginUserModel,
    UserFm? userFm,
    Position? currentPosition,
    isNeedSuffixState = true,
  }) async {
    try {
      emit(LiveLocationLoading());
      GeoPoint? geoPoint;
      final userLiveLoc = GetStorageClient.instance().read<UserModel>('userLiveLoc');
      if (userLiveLoc?.liveLat != null && userLiveLoc?.liveLng != null) {
        geoPoint = GeoPoint(userLiveLoc?.liveLat ?? 0, userLiveLoc?.liveLng ?? 0);
      }
      var newUserFm = userFm ?? UserFm(id: loginUserModel?.idkaryawan);
      var position = currentPosition ?? (await Geolocator.getLastKnownPosition());
      if (position == null) {
        var permission = await Geolocator.checkPermission();
        if (permission != LocationPermission.denied || permission != LocationPermission.deniedForever) {
          position = await Geolocator.getCurrentPosition();
        }
      }
      var result = await DocumentClient.instance().save<UserFm>(
        newUserFm
          ..location = geoPoint ?? GeoPoint(position?.latitude ?? 0, position?.longitude ?? 0)
          ..isLive = LocationStream.positionStream == null ? false : true
          ..idkaryawan = loginUserModel?.idkaryawan,
      );

      if (isNeedSuffixState) {
        emit(LiveLocationOk(
          feature: feature,
        ));
      }
    } catch (e) {
      emit(LiveLocationInitial());
    }
  }
}
