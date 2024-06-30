// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportImpl _$$ReportImplFromJson(Map<String, dynamic> json) => _$ReportImpl(
      id: json['id'] as int,
      idKaryawan: json['idkaryawan'] as String,
      namaKaryawan: json['namaKaryawan'] as String,
      namaPerusahaan: json['namaPerusahaan'] as String,
      durasiKerja: json['durasiKerja'],
      tanggalStart: DateTime.parse(json['tanggalStart'] as String),
      tanggalAkhir: DateTime.parse(json['tanggalAkhir'] as String),
      tanggalCuti: DateTime.parse(json['tanggalCuti'] as String),
      keterangan: json['keterangan'] as String?,
      dokumen: json['dokumen'] as String,
      type: $enumDecode(_$ReportTypeEnumMap, json['ijin']),
      status: json['status'] as String,
      iconIjin: json['iconIjin'] as String?,
    );

Map<String, dynamic> _$$ReportImplToJson(_$ReportImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'idkaryawan': instance.idKaryawan,
    'namaKaryawan': instance.namaKaryawan,
    'namaPerusahaan': instance.namaPerusahaan,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('durasiKerja', instance.durasiKerja);
  val['tanggalStart'] = instance.tanggalStart.toIso8601String();
  val['tanggalAkhir'] = instance.tanggalAkhir.toIso8601String();
  val['tanggalCuti'] = instance.tanggalCuti.toIso8601String();
  writeNotNull('keterangan', instance.keterangan);
  val['dokumen'] = instance.dokumen;
  val['ijin'] = _$ReportTypeEnumMap[instance.type]!;
  val['status'] = instance.status;
  writeNotNull('iconIjin', instance.iconIjin);
  return val;
}

const _$ReportTypeEnumMap = {
  ReportType.leave: 'Cuti',
  ReportType.permit: 'Izin',
  ReportType.sick: 'Sakit',
};
