// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as int?,
      name: json['namaKaryawan'] as String?,
      liked: json['liked'] as String? ?? 'no',
      email: json['alamatEmail'] as String?,
      phone: json['noHp'] as String?,
      perusahaan: json['namaPerusahaan'] as String?,
      perusahaanId: json['idperusahaan'] as String?,
      longitude: json['alamatLongtitude'] as String?,
      latitude: json['alamatLatitude'] as String?,
      address: json['alamatLoc'] as String?,
      photo: json['foto'] as String?,
      joinDate: json['joinDate'] as String?,
      status: json['status'] as String?,
      fcmToken: json['fcmToken'] as String?,
      idkaryawan: json['idkaryawan'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'namaKaryawan': instance.name,
      'liked': instance.liked,
      'alamatEmail': instance.email,
      'noHp': instance.phone,
      'namaPerusahaan': instance.perusahaan,
      'idperusahaan': instance.perusahaanId,
      'alamatLongtitude': instance.longitude,
      'alamatLatitude': instance.latitude,
      'alamatLoc': instance.address,
      'foto': instance.photo,
      'joinDate': instance.joinDate,
      'status': instance.status,
      'fcmToken': instance.fcmToken,
      'idkaryawan': instance.idkaryawan,
      'gender': instance.gender,
    };
