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

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('namaKaryawan', instance.name);
  val['liked'] = instance.liked;
  writeNotNull('alamatEmail', instance.email);
  writeNotNull('noHp', instance.phone);
  writeNotNull('namaPerusahaan', instance.perusahaan);
  writeNotNull('idperusahaan', instance.perusahaanId);
  writeNotNull('alamatLongtitude', instance.longitude);
  writeNotNull('alamatLatitude', instance.latitude);
  writeNotNull('alamatLoc', instance.address);
  writeNotNull('foto', instance.photo);
  writeNotNull('joinDate', instance.joinDate);
  writeNotNull('status', instance.status);
  writeNotNull('fcmToken', instance.fcmToken);
  writeNotNull('idkaryawan', instance.idkaryawan);
  writeNotNull('gender', instance.gender);
  return val;
}
