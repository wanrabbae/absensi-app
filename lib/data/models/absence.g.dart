// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AbsenceImpl _$$AbsenceImplFromJson(Map<String, dynamic> json) =>
    _$AbsenceImpl(
      idKaryawan: json['idKaryawan'] as String?,
      namaKaryawan: json['namaKaryawan'] as String?,
      tanggal: json['tanggal'] == null
          ? null
          : DateTime.parse(json['tanggal'] as String),
      waktuCheckIn: json['waktuCheckIn'] == null
          ? null
          : DateTime.parse(json['waktuCheckIn'] as String),
      waktuCheckOut: json['waktuCheckOut'] == null
          ? null
          : DateTime.parse(json['waktuCheckOut'] as String),
      bluetoothID: json['bluetoothID'] as String?,
      alamatLongtitude: json['alamatLongtitude'] as String?,
      alamatLatitude: json['alamatLatitude'] as String?,
      alamatLoc: json['alamatLoc'] as String?,
      telat: json['telat'],
      id: json['id'] as int?,
      foto: json['foto'] as String?,
      fotoKaryawan: json['fotoKaryawan'] as String?,
      idPerusahaan: json['idPerusahaan'] as String?,
      namaperusahaan: json['namaperusahaan'] as String?,
      tanggalAbsensi: json['tanggalAbsensi'] == null
          ? null
          : DateTime.parse(json['tanggalAbsensi'] as String),
      fotoPulang: json['fotoPulang'] as String?,
      latitudePulang: json['latitudePulang'] as String?,
      longtitudePulang: json['longtitudePulang'] as String?,
      durasi: json['durasi'] as String?,
      alamatPulang: json['alamatPulang'] as String?,
    );

Map<String, dynamic> _$$AbsenceImplToJson(_$AbsenceImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('idKaryawan', instance.idKaryawan);
  writeNotNull('namaKaryawan', instance.namaKaryawan);
  writeNotNull('tanggal', instance.tanggal?.toIso8601String());
  writeNotNull('waktuCheckIn', instance.waktuCheckIn?.toIso8601String());
  writeNotNull('waktuCheckOut', instance.waktuCheckOut?.toIso8601String());
  writeNotNull('bluetoothID', instance.bluetoothID);
  writeNotNull('alamatLongtitude', instance.alamatLongtitude);
  writeNotNull('alamatLatitude', instance.alamatLatitude);
  writeNotNull('alamatLoc', instance.alamatLoc);
  writeNotNull('telat', instance.telat);
  writeNotNull('id', instance.id);
  writeNotNull('foto', instance.foto);
  writeNotNull('fotoKaryawan', instance.fotoKaryawan);
  writeNotNull('idPerusahaan', instance.idPerusahaan);
  writeNotNull('namaperusahaan', instance.namaperusahaan);
  writeNotNull('tanggalAbsensi', instance.tanggalAbsensi?.toIso8601String());
  writeNotNull('fotoPulang', instance.fotoPulang);
  writeNotNull('latitudePulang', instance.latitudePulang);
  writeNotNull('longtitudePulang', instance.longtitudePulang);
  writeNotNull('durasi', instance.durasi);
  writeNotNull('alamatPulang', instance.alamatPulang);
  return val;
}
