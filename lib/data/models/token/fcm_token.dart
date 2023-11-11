import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token.freezed.dart';

part 'fcm_token.g.dart';

@freezed
class FcmToken with _$FcmToken {
  const factory FcmToken({
    @JsonKey(name: 'fcmToken') required String token,
  }) = _FcmToken;

  factory FcmToken.fromJson(Map<String, dynamic> json) =>
      _$FcmTokenFromJson(json);
}
