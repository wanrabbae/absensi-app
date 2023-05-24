// To parse this JSON data, do
//
//     final profile = profileFromMap(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    bool? isEmailVerify,
    String? gender,
    String? genderCode,
    String? photo,
    String? joinDate,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
