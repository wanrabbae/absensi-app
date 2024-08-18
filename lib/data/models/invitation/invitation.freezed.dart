// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Invitation _$InvitationFromJson(Map<String, dynamic> json) {
  return _Invitation.fromJson(json);
}

/// @nodoc
mixin _$Invitation {
  String get receiver => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  @JsonKey(name: 'idperusahaan')
  String get idPerusahaan => throw _privateConstructorUsedError;
  String get namaPerusahaan => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvitationCopyWith<Invitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationCopyWith<$Res> {
  factory $InvitationCopyWith(
          Invitation value, $Res Function(Invitation) then) =
      _$InvitationCopyWithImpl<$Res, Invitation>;
  @useResult
  $Res call(
      {String receiver,
      String sender,
      @JsonKey(name: 'idperusahaan') String idPerusahaan,
      String namaPerusahaan});
}

/// @nodoc
class _$InvitationCopyWithImpl<$Res, $Val extends Invitation>
    implements $InvitationCopyWith<$Res> {
  _$InvitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiver = null,
    Object? sender = null,
    Object? idPerusahaan = null,
    Object? namaPerusahaan = null,
  }) {
    return _then(_value.copyWith(
      receiver: null == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      idPerusahaan: null == idPerusahaan
          ? _value.idPerusahaan
          : idPerusahaan // ignore: cast_nullable_to_non_nullable
              as String,
      namaPerusahaan: null == namaPerusahaan
          ? _value.namaPerusahaan
          : namaPerusahaan // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationImplCopyWith<$Res>
    implements $InvitationCopyWith<$Res> {
  factory _$$InvitationImplCopyWith(
          _$InvitationImpl value, $Res Function(_$InvitationImpl) then) =
      __$$InvitationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String receiver,
      String sender,
      @JsonKey(name: 'idperusahaan') String idPerusahaan,
      String namaPerusahaan});
}

/// @nodoc
class __$$InvitationImplCopyWithImpl<$Res>
    extends _$InvitationCopyWithImpl<$Res, _$InvitationImpl>
    implements _$$InvitationImplCopyWith<$Res> {
  __$$InvitationImplCopyWithImpl(
      _$InvitationImpl _value, $Res Function(_$InvitationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiver = null,
    Object? sender = null,
    Object? idPerusahaan = null,
    Object? namaPerusahaan = null,
  }) {
    return _then(_$InvitationImpl(
      receiver: null == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as String,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      idPerusahaan: null == idPerusahaan
          ? _value.idPerusahaan
          : idPerusahaan // ignore: cast_nullable_to_non_nullable
              as String,
      namaPerusahaan: null == namaPerusahaan
          ? _value.namaPerusahaan
          : namaPerusahaan // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationImpl implements _Invitation {
  const _$InvitationImpl(
      {required this.receiver,
      required this.sender,
      @JsonKey(name: 'idperusahaan') required this.idPerusahaan,
      required this.namaPerusahaan});

  factory _$InvitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationImplFromJson(json);

  @override
  final String receiver;
  @override
  final String sender;
  @override
  @JsonKey(name: 'idperusahaan')
  final String idPerusahaan;
  @override
  final String namaPerusahaan;

  @override
  String toString() {
    return 'Invitation(receiver: $receiver, sender: $sender, idPerusahaan: $idPerusahaan, namaPerusahaan: $namaPerusahaan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationImpl &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.idPerusahaan, idPerusahaan) ||
                other.idPerusahaan == idPerusahaan) &&
            (identical(other.namaPerusahaan, namaPerusahaan) ||
                other.namaPerusahaan == namaPerusahaan));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, receiver, sender, idPerusahaan, namaPerusahaan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationImplCopyWith<_$InvitationImpl> get copyWith =>
      __$$InvitationImplCopyWithImpl<_$InvitationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationImplToJson(
      this,
    );
  }
}

abstract class _Invitation implements Invitation {
  const factory _Invitation(
      {required final String receiver,
      required final String sender,
      @JsonKey(name: 'idperusahaan') required final String idPerusahaan,
      required final String namaPerusahaan}) = _$InvitationImpl;

  factory _Invitation.fromJson(Map<String, dynamic> json) =
      _$InvitationImpl.fromJson;

  @override
  String get receiver;
  @override
  String get sender;
  @override
  @JsonKey(name: 'idperusahaan')
  String get idPerusahaan;
  @override
  String get namaPerusahaan;
  @override
  @JsonKey(ignore: true)
  _$$InvitationImplCopyWith<_$InvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
