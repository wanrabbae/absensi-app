import 'package:freezed_annotation/freezed_annotation.dart';

part 'klaim.freezed.dart';

part 'klaim.g.dart';

@freezed
class Klaim with _$Klaim {
  const factory Klaim({
    required int id,
  }) = _Klaim;

  factory Klaim.fromJson(Map<String, dynamic> json) => _$KlaimFromJson(json);
}
