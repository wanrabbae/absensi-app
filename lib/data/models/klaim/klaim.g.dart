// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'klaim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KlaimImpl _$$KlaimImplFromJson(Map<String, dynamic> json) => _$KlaimImpl(
      id: json['idklaim'] as int,
      idKaryawan: json['idKaryawan'] as String,
      namaKaryawan: json['namaKaryawan'] as String,
      foto: json['foto'] as String? ?? 'assets/icons/logo/hora.png',
      tanggal: DateTime.parse(json['tanggal'] as String),
      file: json['fileReimb'] as String,
      idPerusahaan: json['idPerusahaan'] as String,
      namaPerusahaan: json['namaperusahaan'] as String,
      keterangan: json['keterangan'] as String?,
    );

Map<String, dynamic> _$$KlaimImplToJson(_$KlaimImpl instance) {
  final val = <String, dynamic>{
    'idklaim': instance.id,
    'idKaryawan': instance.idKaryawan,
    'namaKaryawan': instance.namaKaryawan,
    'foto': instance.foto,
    'tanggal': instance.tanggal.toIso8601String(),
    'fileReimb': instance.file,
    'idPerusahaan': instance.idPerusahaan,
    'namaperusahaan': instance.namaPerusahaan,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('keterangan', instance.keterangan);
  return val;
}
