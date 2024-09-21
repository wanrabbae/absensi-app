import 'package:freezed_annotation/freezed_annotation.dart';

part 'agenda.freezed.dart';

part 'agenda.g.dart';

@freezed
class Agenda with _$Agenda {
  const factory Agenda({
    required DateTime tanggal,
    required DateTime jam,
    @JsonKey(name: 'namakaryawan') required String namaKaryawan,
    required String keterangan,
    String? judul,
    @JsonKey(name: 'idkaryawan') required String idkaryawan,
    required String status,
  }) = _Agenda;

  factory Agenda.fromJson(Map<String, Object?> json) => _$AgendaFromJson(json);
}

@freezed
class AgendaMutable with _$AgendaMutable {
  const factory AgendaMutable({
    required String namaKaryawan,
    required String keterangan,
    required String tanggal,
    required String namaPerusahaan,
    required String idperusahaan,
    required String judul,
  }) = _AgendaMutable;

  factory AgendaMutable.fromJson(Map<String, Object?> json) =>
      _$AgendaMutableFromJson(json);
}
