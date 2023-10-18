import 'package:app/clients/DioClient.dart';
import 'package:app/clients/DocumentClient.dart';
import 'package:app/firebase_models/user_fm.dart';
import 'package:app/helpers/location_helper.dart';
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

  Future<void> fetch({
    feature = 'fetch',
    UserModel? userModel,
  }) async {
    try {
      emit(LiveLocationLoading());
      var userFm = UserFm(id: userModel?.alamatEmail);
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
      emit(LiveLocationOk(
        feature: feature,
        data: result,
        extra: {
          'userModel': userModel?.copyWith(
            imageBytes: await _urlToBytes(userModel.fotoUrl),
            customMarker: await CustomMarker(userModel: userModel).toBitmapDescriptor(),
          ),
        },
      ));
    } catch (e) {
      emit(LiveLocationInitial());
    }
  }

  Future<void> store({
    feature = 'store',
    UserModel? userModel,
    UserFm? userFm,
    Position? currentPosition,
  }) async {
    try {
      emit(LiveLocationLoading());

      GeoPoint? geoPoint;
      LocationStream.positionStream ??= Geolocator.getPositionStream(locationSettings: LocationHelper().locationSettings()).listen(
        (event) {
          geoPoint = GeoPoint(event.latitude, event.longitude);
        },
      );
      var newUserFm = userFm ?? UserFm(id: userModel?.alamatEmail);
      var position = currentPosition ?? (await Geolocator.getLastKnownPosition());
      var result = await DocumentClient.instance().save<UserFm>(
        newUserFm
          ..location = geoPoint ?? GeoPoint(position?.latitude ?? 0, position?.longitude ?? 0)
          ..isLive = LocationStream.positionStream == null ? false : true
          ..email = userModel?.alamatEmail,
      );

      emit(LiveLocationOk(
        feature: feature,
      ));
    } catch (e) {
      emit(LiveLocationInitial());
    }
  }
}
