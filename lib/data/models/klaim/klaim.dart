import 'package:freezed_annotation/freezed_annotation.dart';

part 'klaim.freezed.dart';

part 'klaim.g.dart';

@freezed
class Klaim with _$Klaim {
  const factory Klaim({
    @JsonKey(name: 'idklaim') required int id,
    @JsonKey(name: 'idKaryawan') required String idKaryawan,
    @JsonKey(name: 'namaKaryawan') required String namaKaryawan,
    @Default('assets/icons/logo/hora.png') @JsonKey(name: 'foto') String foto,
    required DateTime tanggal,
    @JsonKey(name: 'fileReimb') required String file,
    @JsonKey(name: 'idPerusahaan') required String idPerusahaan,
    @JsonKey(name: 'namaperusahaan') required String namaPerusahaan,
    String? keterangan,
  }) = _Klaim;

  factory Klaim.fromJson(Map<String, dynamic> json) => _$KlaimFromJson(json);
}
