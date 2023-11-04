import 'package:freezed_annotation/freezed_annotation.dart';

part 'company.freezed.dart';

part 'company.g.dart';

@freezed
class Company with _$Company {
  const factory Company({
    @Default('HORA-001') @JsonKey(name: 'idperusahaan') String id,
    @Default('PT HORA') @JsonKey(name: 'namaPerusahaan') String name,
    @Default('wwwroot/Images/CompanyLogo/logo_hora.png')
    @JsonKey(name: 'logoPerusahaan')
    String logo,
    @Default('Jl. Budiluhur No.47 Medan, Indonesia')
    @JsonKey(name: 'alamatLoc')
    String alamat,
    @Default('98.6388869') @JsonKey(name: 'alamatLongtitude') String longitude,
    @Default('3.5955809') @JsonKey(name: 'alamatLatitude') String latitude,
    @Default(0) @JsonKey(name: 'totalLike') int like,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
