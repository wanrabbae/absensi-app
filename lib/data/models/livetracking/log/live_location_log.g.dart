// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_location_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiveLocationLogImpl _$$LiveLocationLogImplFromJson(
        Map<String, dynamic> json) =>
    _$LiveLocationLogImpl(
      uid: json['uid'] as String?,
      userId: json['user_id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String? ?? '',
      timestamp:
          const FirebaseTimestampConverter2().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$LiveLocationLogImplToJson(
    _$LiveLocationLogImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  val['user_id'] = instance.userId;
  val['latitude'] = instance.latitude;
  val['longitude'] = instance.longitude;
  val['address'] = instance.address;
  writeNotNull('timestamp',
      const FirebaseTimestampConverter2().toJson(instance.timestamp));
  return val;
}
