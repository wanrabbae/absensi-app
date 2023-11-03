import 'package:app/data/converter/firebase_timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_tracking.freezed.dart';

part 'live_tracking.g.dart';

@freezed
class LiveTracking with _$LiveTracking {
  const factory LiveTracking({
    String? uid,
    @JsonKey(name: 'broadcaster_id') required String broadcasterId,
    @JsonKey(name: 'listener_id') required String listenerId,
    @Default(false) @JsonKey(name: 'request_approved') bool requestApproved,
    double? latitude,
    double? longitude,
    @FirebaseTimestampConverter()
    @JsonKey(name: 'last_update')
    DateTime? lastUpdate,
  }) = _LiveTracking;

  factory LiveTracking.fromJson(Map<String, dynamic> json) =>
      _$LiveTrackingFromJson(json);
}
