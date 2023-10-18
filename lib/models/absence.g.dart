// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AbsenceImpl _$$AbsenceImplFromJson(Map<String, dynamic> json) =>
    _$AbsenceImpl(
      name: json['name'] as String?,
      id: json['id'] as int?,
      companyId: json['companyId'] as int?,
      companyName: json['companyName'] as String?,
      locationLat: (json['locationLat'] as num?)?.toDouble(),
      locationLng: (json['locationLng'] as num?)?.toDouble(),
      locationName: json['locationName'] as String?,
      checkInTime: json['checkInTime'] as String?,
      checkOutTime: json['checkOutTime'] as String?,
      lastAbsenceRemark: json['lastAbsenceRemark'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$$AbsenceImplToJson(_$AbsenceImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'locationLat': instance.locationLat,
      'locationLng': instance.locationLng,
      'locationName': instance.locationName,
      'checkInTime': instance.checkInTime,
      'checkOutTime': instance.checkOutTime,
      'lastAbsenceRemark': instance.lastAbsenceRemark,
      'photo': instance.photo,
    };
