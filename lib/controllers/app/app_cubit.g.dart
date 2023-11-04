// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppStateImpl _$$AppStateImplFromJson(Map<String, dynamic> json) =>
    _$AppStateImpl(
      currentUser: json['currentUser'] == null
          ? null
          : Profile.fromJson(json['currentUser'] as Map<String, dynamic>),
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppStateImplToJson(_$AppStateImpl instance) =>
    <String, dynamic>{
      'currentUser': instance.currentUser,
      'company': instance.company,
    };
