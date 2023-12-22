import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    int? id,
    @JsonKey(name: 'namaKaryawan') String? name,
    @Default('no') @JsonKey(name: 'liked') String liked,
    @JsonKey(name: 'alamatEmail') String? email,
    @JsonKey(name: 'noHp') String? phone,
    @JsonKey(name: 'namaPerusahaan') String? perusahaan,
    @JsonKey(name: 'idperusahaan') String? perusahaanId,
    @JsonKey(name: 'alamatLongtitude') String? longitude,
    @JsonKey(name: 'alamatLatitude') String? latitude,
    @JsonKey(name: 'alamatLoc') String? address,
    @JsonKey(name: 'foto') String? photo,
    @JsonKey(name: 'joinDate') String? joinDate,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'fcmToken') String? fcmToken,
    @JsonKey(name: 'idkaryawan') String? idkaryawan,
    @JsonKey(name: 'gender') String? gender,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
