import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp.freezed.dart';
part 'verify_otp.g.dart';

@freezed
class VerifyOTP with _$VerifyOTP {
  const factory VerifyOTP({
    required String message,
    required String token,
  }) = _VerifyOTP;

  factory VerifyOTP.fromJson(Map<String, dynamic> json) =>
      _$VerifyOTPFromJson(json);
}
