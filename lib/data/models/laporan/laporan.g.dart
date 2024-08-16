// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LaporanImpl _$$LaporanImplFromJson(Map<String, dynamic> json) =>
    _$LaporanImpl(
      idKaryawan: json['idKaryawan'] as String,
      namaKaryawan: json['namaKaryawan'] as String,
      tanggal: json['tanggal'] as String,
      fileReimb:
          const FullPathImageConverter().fromJson(json['fileReimb'] as String),
      idPerusahaan: json['idPerusahaan'] as String,
      namaperusahaan: json['namaperusahaan'] as String,
      keterangan: json['keterangan'] as String? ?? '',
      idklaim: json['idklaim'] as int,
      foto: const FullPathOptionalImageConverter()
          .fromJson(json['foto'] as String?),
      lokasi: json['lokasi'] as String,
      lokasiLat: json['lokasiLat'] as String,
      lokasiLong: json['lokasiLong'] as String,
    );

Map<String, dynamic> _$$LaporanImplToJson(_$LaporanImpl instance) {
  final val = <String, dynamic>{
    'idKaryawan': instance.idKaryawan,
    'namaKaryawan': instance.namaKaryawan,
    'tanggal': instance.tanggal,
    'fileReimb': const FullPathImageConverter().toJson(instance.fileReimb),
    'idPerusahaan': instance.idPerusahaan,
    'namaperusahaan': instance.namaperusahaan,
    'keterangan': instance.keterangan,
    'idklaim': instance.idklaim,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'foto', const FullPathOptionalImageConverter().toJson(instance.foto));
  val['lokasi'] = instance.lokasi;
  val['lokasiLat'] = instance.lokasiLat;
  val['lokasiLong'] = instance.lokasiLong;
  return val;
}
