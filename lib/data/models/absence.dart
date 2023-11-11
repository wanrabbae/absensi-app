// To parse this JSON data, do
//
//     final absence = absenceFromMap(jsonString);
import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence.freezed.dart';
part 'absence.g.dart';

@freezed
class Absence with _$Absence {
  const factory Absence({
    String? idKaryawan,
    String? namaKaryawan,
    DateTime? tanggal,
    DateTime? waktuCheckIn,
    DateTime? waktuCheckOut,
    String? bluetoothID,
    String? alamatLongtitude,
    String? alamatLatitude,
    String? alamatLoc,
    dynamic telat,
    int? id,
    String? foto,
    String? fotoKaryawan,
    String? idPerusahaan,
    String? namaperusahaan,
    DateTime? tanggalAbsensi,
    String? fotoPulang,
    String? latitudePulang,
    String? longtitudePulang,
    String? durasi,
    String? alamatPulang,
  }) = _Absence;

  factory Absence.fromJson(Map<String, dynamic> json) =>
      _$AbsenceFromJson(json);
}
