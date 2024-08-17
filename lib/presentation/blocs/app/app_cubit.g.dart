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
          ? const Company()
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      liveTrackingList: (json['liveTrackingList'] as List<dynamic>?)
              ?.map((e) => LiveTracking.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      allowLocationAlwaysPermission:
          json['allowLocationAlwaysPermission'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppStateImplToJson(_$AppStateImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currentUser', instance.currentUser?.toJson());
  val['company'] = instance.company.toJson();
  val['liveTrackingList'] =
      instance.liveTrackingList.map((e) => e.toJson()).toList();
  val['allowLocationAlwaysPermission'] = instance.allowLocationAlwaysPermission;
  return val;
}
