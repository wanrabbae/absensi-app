import 'package:app/data/converter/firebase_timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_location_log.freezed.dart';

part 'live_location_log.g.dart';

@freezed
class LiveLocationLog with _$LiveLocationLog {
  const factory LiveLocationLog({
    String? uid,
    @JsonKey(name: 'user_id') required String userId,
    required double latitude,
    required double longitude,
    @Default('') String address,
    @FirebaseTimestampConverter2()
    @JsonKey(name: 'timestamp')
    required DateTime timestamp,
  }) = _LiveLocationLog;

  factory LiveLocationLog.fromJson(Map<String, dynamic> json) =>
      _$LiveLocationLogFromJson(json);
}
