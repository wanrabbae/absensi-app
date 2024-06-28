import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

enum ReportType {
  @JsonValue('Cuti')
  leave('Cuti'),
  @JsonValue('Izin')
  permit('Izin'),
  @JsonValue('Sakit')
  sick('Sakit');

  const ReportType(this.status);

  final String status;
}

@freezed
class Report with _$Report {
  const factory Report({
    required int id,
    @JsonKey(name: 'idkaryawan') required String idKaryawan,
    required String namaKaryawan,
    required String namaPerusahaan,
    dynamic durasiKerja,
    required DateTime tanggalStart,
    required DateTime tanggalAkhir,
    required DateTime tanggalCuti,
    required String keterangan,
    required String dokumen,
    @JsonKey(name: 'ijin') required ReportType type,
    required String status,
    String? iconIjin,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}
