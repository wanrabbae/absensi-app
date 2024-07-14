part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isEmailValid,
    @Default(PageStatus.idle) PageStatus status,
    String? message,
    @Default(false) bool isOtpValid,
    @Default(PageStatus.idle) PageStatus otpStatus,
    VerifyOTP? otp,
  }) = _LoginState;
}
