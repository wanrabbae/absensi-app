// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as int?,
      namaKaryawan: json['namaKaryawan'] as String?,
      jabatan: json['jabatan'],
      alamatEmail: json['alamatEmail'] as String?,
      noHp: json['noHp'] as String?,
      namaPerusahaan: json['namaPerusahaan'] as String?,
      idperusahaan: json['idperusahaan'] as String?,
      alamatLongtitude: json['alamatLongtitude'],
      alamatLatitude: json['alamatLatitude'],
      alamatLoc: json['alamatLoc'] as String?,
      foto: json['foto'] as String?,
      fotoKaryawan: json['fotoKaryawan'] as String?,
      joinDate: json['joinDate'] as String?,
      status: json['status'] as String?,
      bluetoothId: json['bluetoothId'] as String?,
      idkaryawan: json['idkaryawan'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'namaKaryawan': instance.namaKaryawan,
      'jabatan': instance.jabatan,
      'alamatEmail': instance.alamatEmail,
      'noHp': instance.noHp,
      'namaPerusahaan': instance.namaPerusahaan,
      'idperusahaan': instance.idperusahaan,
      'alamatLongtitude': instance.alamatLongtitude,
      'alamatLatitude': instance.alamatLatitude,
      'alamatLoc': instance.alamatLoc,
      'foto': instance.foto,
      'fotoKaryawan': instance.fotoKaryawan,
      'joinDate': instance.joinDate,
      'status': instance.status,
      'bluetoothId': instance.bluetoothId,
      'idkaryawan': instance.idkaryawan,
      'gender': instance.gender,
    };
