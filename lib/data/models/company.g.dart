// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyImpl _$$CompanyImplFromJson(Map<String, dynamic> json) =>
    _$CompanyImpl(
      id: json['idperusahaan'] as String? ?? 'HORA-001',
      name: json['namaPerusahaan'] as String? ?? 'PT HORA',
      logo: json['logoPerusahaan'] as String? ??
          'wwwroot/Images/CompanyLogo/logo_hora.png',
      alamat: json['alamatLoc'] as String? ??
          'Jl. Budiluhur No.47 Medan, Indonesia',
      longitude: json['alamatLongtitude'] as String? ?? '98.6388869',
      latitude: json['alamatLatitude'] as String? ?? '3.5955809',
      like: json['totalLike'] as int? ?? 0,
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'idperusahaan': instance.id,
      'namaPerusahaan': instance.name,
      'logoPerusahaan': instance.logo,
      'alamatLoc': instance.alamat,
      'alamatLongtitude': instance.longitude,
      'alamatLatitude': instance.latitude,
      'totalLike': instance.like,
    };
