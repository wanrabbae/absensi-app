// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginState {
  bool get isEmailValid => throw _privateConstructorUsedError;
  PageStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  bool get isOtpValid => throw _privateConstructorUsedError;
  PageStatus get otpStatus => throw _privateConstructorUsedError;
  VerifyOTP? get otp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {bool isEmailValid,
      PageStatus status,
      String? message,
      bool isOtpValid,
      PageStatus otpStatus,
      VerifyOTP? otp});

  $VerifyOTPCopyWith<$Res>? get otp;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEmailValid = null,
    Object? status = null,
    Object? message = freezed,
    Object? isOtpValid = null,
    Object? otpStatus = null,
    Object? otp = freezed,
  }) {
    return _then(_value.copyWith(
      isEmailValid: null == isEmailValid
          ? _value.isEmailValid
          : isEmailValid // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      isOtpValid: null == isOtpValid
          ? _value.isOtpValid
          : isOtpValid // ignore: cast_nullable_to_non_nullable
              as bool,
      otpStatus: null == otpStatus
          ? _value.otpStatus
          : otpStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as VerifyOTP?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VerifyOTPCopyWith<$Res>? get otp {
    if (_value.otp == null) {
      return null;
    }

    return $VerifyOTPCopyWith<$Res>(_value.otp!, (value) {
      return _then(_value.copyWith(otp: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isEmailValid,
      PageStatus status,
      String? message,
      bool isOtpValid,
      PageStatus otpStatus,
      VerifyOTP? otp});

  @override
  $VerifyOTPCopyWith<$Res>? get otp;
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEmailValid = null,
    Object? status = null,
    Object? message = freezed,
    Object? isOtpValid = null,
    Object? otpStatus = null,
    Object? otp = freezed,
  }) {
    return _then(_$LoginStateImpl(
      isEmailValid: null == isEmailValid
          ? _value.isEmailValid
          : isEmailValid // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      isOtpValid: null == isOtpValid
          ? _value.isOtpValid
          : isOtpValid // ignore: cast_nullable_to_non_nullable
              as bool,
      otpStatus: null == otpStatus
          ? _value.otpStatus
          : otpStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as VerifyOTP?,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl(
      {this.isEmailValid = false,
      this.status = PageStatus.idle,
      this.message,
      this.isOtpValid = false,
      this.otpStatus = PageStatus.idle,
      this.otp});

  @override
  @JsonKey()
  final bool isEmailValid;
  @override
  @JsonKey()
  final PageStatus status;
  @override
  final String? message;
  @override
  @JsonKey()
  final bool isOtpValid;
  @override
  @JsonKey()
  final PageStatus otpStatus;
  @override
  final VerifyOTP? otp;

  @override
  String toString() {
    return 'LoginState(isEmailValid: $isEmailValid, status: $status, message: $message, isOtpValid: $isOtpValid, otpStatus: $otpStatus, otp: $otp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.isEmailValid, isEmailValid) ||
                other.isEmailValid == isEmailValid) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isOtpValid, isOtpValid) ||
                other.isOtpValid == isOtpValid) &&
            (identical(other.otpStatus, otpStatus) ||
                other.otpStatus == otpStatus) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isEmailValid, status, message, isOtpValid, otpStatus, otp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {final bool isEmailValid,
      final PageStatus status,
      final String? message,
      final bool isOtpValid,
      final PageStatus otpStatus,
      final VerifyOTP? otp}) = _$LoginStateImpl;

  @override
  bool get isEmailValid;
  @override
  PageStatus get status;
  @override
  String? get message;
  @override
  bool get isOtpValid;
  @override
  PageStatus get otpStatus;
  @override
  VerifyOTP? get otp;
  @override
  @JsonKey(ignore: true)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
