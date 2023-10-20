// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_location_action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiveLocationActionModelImpl _$$LiveLocationActionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LiveLocationActionModelImpl(
      id: json['id'] as int?,
      title: json['title'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      isBreak: json['isBreak'] as bool? ?? false,
    );

Map<String, dynamic> _$$LiveLocationActionModelImplToJson(
        _$LiveLocationActionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isActive': instance.isActive,
      'isBreak': instance.isBreak,
    };
