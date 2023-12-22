// To parse this JSON data, do
//
//     final absence = absenceFromMap(jsonString);
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'absence.freezed.dart';
part 'absence.g.dart';

@freezed
class Absence with _$Absence {
  const Absence._();

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

  bool get isCheckIn => waktuCheckIn != null;

  bool get isCheckOut => waktuCheckOut != null;

  LatLng? get checkInLocation {
    if (alamatLatitude != null && alamatLongtitude != null) {
      final lat = double.tryParse(alamatLatitude!);
      final lng = double.tryParse(alamatLongtitude!);
      if (lat != null && lng != null) {
        return LatLng(lat, lng);
      }
    }
    return null;
  }

  LatLng? get checkOutLocation {
    if (latitudePulang != null && longtitudePulang != null) {
      final lat = double.tryParse(latitudePulang!);
      final lng = double.tryParse(longtitudePulang!);
      if (lat != null && lng != null) {
        return LatLng(lat, lng);
      }
    }
    return null;
  }
}
