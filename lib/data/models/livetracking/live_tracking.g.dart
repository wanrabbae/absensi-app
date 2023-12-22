// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiveTrackingImpl _$$LiveTrackingImplFromJson(Map<String, dynamic> json) =>
    _$LiveTrackingImpl(
      uid: json['uid'] as String?,
      broadcasterId: json['broadcaster_id'] as String,
      listenerId: json['listener_id'] as String,
      requestApproved: json['request_approved'] as bool? ?? false,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      lastUpdate:
          const FirebaseTimestampConverter().fromJson(json['last_update']),
    );

Map<String, dynamic> _$$LiveTrackingImplToJson(_$LiveTrackingImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  val['broadcaster_id'] = instance.broadcasterId;
  val['listener_id'] = instance.listenerId;
  val['request_approved'] = instance.requestApproved;
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('last_update',
      const FirebaseTimestampConverter().toJson(instance.lastUpdate));
  return val;
}
