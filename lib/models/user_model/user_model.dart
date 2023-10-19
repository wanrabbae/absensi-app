import 'dart:typed_data';

import 'package:app/global_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    int? id,
    String? namaKaryawan,
    dynamic jabatan,
    String? alamatEmail,
    String? noHp,
    String? namaPerusahaan,
    String? idperusahaan,
    dynamic alamatLongtitude,
    dynamic alamatLatitude,
    String? alamatLoc,
    String? foto,
    String? fotoKaryawan,
    String? joinDate,
    String? status,
    String? bluetoothId,
    String? idkaryawan,
    String? gender,
    @JsonKey(includeFromJson: false, includeToJson: false) Uint8List? imageBytes,
    @JsonKey(includeFromJson: false, includeToJson: false) BitmapDescriptor? customMarker,
    @JsonKey(includeFromJson: false, includeToJson: false) double? liveLat,
    @JsonKey(includeFromJson: false, includeToJson: false) double? liveLng,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  get firstCharName => namaKaryawan?.substring(0, 1) ?? '';

  String? get fotoUrl {
    if (fotoKaryawan == null) {
      return null;
    }

    return changeUrlImage(fotoKaryawan);
  }
}
