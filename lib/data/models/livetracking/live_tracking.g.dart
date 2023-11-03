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

Map<String, dynamic> _$$LiveTrackingImplToJson(_$LiveTrackingImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'broadcaster_id': instance.broadcasterId,
      'listener_id': instance.listenerId,
      'request_approved': instance.requestApproved,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'last_update': _$JsonConverterToJson<dynamic, DateTime>(
          instance.lastUpdate, const FirebaseTimestampConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
