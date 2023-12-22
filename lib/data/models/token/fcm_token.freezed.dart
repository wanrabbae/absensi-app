// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FcmToken _$FcmTokenFromJson(Map<String, dynamic> json) {
  return _FcmToken.fromJson(json);
}

/// @nodoc
mixin _$FcmToken {
  @JsonKey(name: 'fcmToken')
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FcmTokenCopyWith<FcmToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FcmTokenCopyWith<$Res> {
  factory $FcmTokenCopyWith(FcmToken value, $Res Function(FcmToken) then) =
      _$FcmTokenCopyWithImpl<$Res, FcmToken>;
  @useResult
  $Res call({@JsonKey(name: 'fcmToken') String token});
}

/// @nodoc
class _$FcmTokenCopyWithImpl<$Res, $Val extends FcmToken>
    implements $FcmTokenCopyWith<$Res> {
  _$FcmTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FcmTokenImplCopyWith<$Res>
    implements $FcmTokenCopyWith<$Res> {
  factory _$$FcmTokenImplCopyWith(
          _$FcmTokenImpl value, $Res Function(_$FcmTokenImpl) then) =
      __$$FcmTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'fcmToken') String token});
}

/// @nodoc
class __$$FcmTokenImplCopyWithImpl<$Res>
    extends _$FcmTokenCopyWithImpl<$Res, _$FcmTokenImpl>
    implements _$$FcmTokenImplCopyWith<$Res> {
  __$$FcmTokenImplCopyWithImpl(
      _$FcmTokenImpl _value, $Res Function(_$FcmTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$FcmTokenImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FcmTokenImpl implements _FcmToken {
  const _$FcmTokenImpl({@JsonKey(name: 'fcmToken') required this.token});

  factory _$FcmTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$FcmTokenImplFromJson(json);

  @override
  @JsonKey(name: 'fcmToken')
  final String token;

  @override
  String toString() {
    return 'FcmToken(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FcmTokenImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FcmTokenImplCopyWith<_$FcmTokenImpl> get copyWith =>
      __$$FcmTokenImplCopyWithImpl<_$FcmTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FcmTokenImplToJson(
      this,
    );
  }
}

abstract class _FcmToken implements FcmToken {
  const factory _FcmToken(
          {@JsonKey(name: 'fcmToken') required final String token}) =
      _$FcmTokenImpl;

  factory _FcmToken.fromJson(Map<String, dynamic> json) =
      _$FcmTokenImpl.fromJson;

  @override
  @JsonKey(name: 'fcmToken')
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$FcmTokenImplCopyWith<_$FcmTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
