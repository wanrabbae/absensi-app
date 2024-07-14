// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VerifyOTP _$VerifyOTPFromJson(Map<String, dynamic> json) {
  return _VerifyOTP.fromJson(json);
}

/// @nodoc
mixin _$VerifyOTP {
  String get message => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyOTPCopyWith<VerifyOTP> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOTPCopyWith<$Res> {
  factory $VerifyOTPCopyWith(VerifyOTP value, $Res Function(VerifyOTP) then) =
      _$VerifyOTPCopyWithImpl<$Res, VerifyOTP>;
  @useResult
  $Res call({String message, String token});
}

/// @nodoc
class _$VerifyOTPCopyWithImpl<$Res, $Val extends VerifyOTP>
    implements $VerifyOTPCopyWith<$Res> {
  _$VerifyOTPCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyOTPImplCopyWith<$Res>
    implements $VerifyOTPCopyWith<$Res> {
  factory _$$VerifyOTPImplCopyWith(
          _$VerifyOTPImpl value, $Res Function(_$VerifyOTPImpl) then) =
      __$$VerifyOTPImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String token});
}

/// @nodoc
class __$$VerifyOTPImplCopyWithImpl<$Res>
    extends _$VerifyOTPCopyWithImpl<$Res, _$VerifyOTPImpl>
    implements _$$VerifyOTPImplCopyWith<$Res> {
  __$$VerifyOTPImplCopyWithImpl(
      _$VerifyOTPImpl _value, $Res Function(_$VerifyOTPImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? token = null,
  }) {
    return _then(_$VerifyOTPImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyOTPImpl implements _VerifyOTP {
  const _$VerifyOTPImpl({required this.message, required this.token});

  factory _$VerifyOTPImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyOTPImplFromJson(json);

  @override
  final String message;
  @override
  final String token;

  @override
  String toString() {
    return 'VerifyOTP(message: $message, token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOTPImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOTPImplCopyWith<_$VerifyOTPImpl> get copyWith =>
      __$$VerifyOTPImplCopyWithImpl<_$VerifyOTPImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyOTPImplToJson(
      this,
    );
  }
}

abstract class _VerifyOTP implements VerifyOTP {
  const factory _VerifyOTP(
      {required final String message,
      required final String token}) = _$VerifyOTPImpl;

  factory _VerifyOTP.fromJson(Map<String, dynamic> json) =
      _$VerifyOTPImpl.fromJson;

  @override
  String get message;
  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$VerifyOTPImplCopyWith<_$VerifyOTPImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
