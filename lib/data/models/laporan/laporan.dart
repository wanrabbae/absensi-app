import 'package:app/data/converter/fullpath_image_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'laporan.freezed.dart';
part 'laporan.g.dart';

@freezed
class Laporan with _$Laporan {
  const factory Laporan({
    required String idKaryawan,
    required String namaKaryawan,
    required String tanggal,
    @FullPathImageConverter() required String fileReimb,
    required String idPerusahaan,
    required String namaperusahaan,
    @Default('') String keterangan,
    required int idklaim,
    @FullPathOptionalImageConverter() String? foto,
    required String lokasi,
    required String lokasiLat,
    required String lokasiLong,
  }) = _Laporan;

  factory Laporan.fromJson(Map<String, dynamic> json) =>
      _$LaporanFromJson(json);
}
