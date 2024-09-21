// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgendaImpl _$$AgendaImplFromJson(Map<String, dynamic> json) => _$AgendaImpl(
      tanggal: DateTime.parse(json['tanggal'] as String),
      jam: DateTime.parse(json['jam'] as String),
      namaKaryawan: json['namakaryawan'] as String,
      keterangan: json['keterangan'] as String,
      judul: json['judul'] as String?,
      idkaryawan: json['idkaryawan'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$AgendaImplToJson(_$AgendaImpl instance) {
  final val = <String, dynamic>{
    'tanggal': instance.tanggal.toIso8601String(),
    'jam': instance.jam.toIso8601String(),
    'namakaryawan': instance.namaKaryawan,
    'keterangan': instance.keterangan,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('judul', instance.judul);
  val['idkaryawan'] = instance.idkaryawan;
  val['status'] = instance.status;
  return val;
}

_$AgendaMutableImpl _$$AgendaMutableImplFromJson(Map<String, dynamic> json) =>
    _$AgendaMutableImpl(
      namaKaryawan: json['namaKaryawan'] as String,
      keterangan: json['keterangan'] as String,
      tanggal: json['tanggal'] as String,
      namaPerusahaan: json['namaPerusahaan'] as String,
      idperusahaan: json['idperusahaan'] as String,
      judul: json['judul'] as String,
    );

Map<String, dynamic> _$$AgendaMutableImplToJson(_$AgendaMutableImpl instance) =>
    <String, dynamic>{
      'namaKaryawan': instance.namaKaryawan,
      'keterangan': instance.keterangan,
      'tanggal': instance.tanggal,
      'namaPerusahaan': instance.namaPerusahaan,
      'idperusahaan': instance.idperusahaan,
      'judul': instance.judul,
    };
