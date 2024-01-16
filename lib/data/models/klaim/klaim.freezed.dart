// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'klaim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Klaim _$KlaimFromJson(Map<String, dynamic> json) {
  return _Klaim.fromJson(json);
}

/// @nodoc
mixin _$Klaim {
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KlaimCopyWith<Klaim> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KlaimCopyWith<$Res> {
  factory $KlaimCopyWith(Klaim value, $Res Function(Klaim) then) =
      _$KlaimCopyWithImpl<$Res, Klaim>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$KlaimCopyWithImpl<$Res, $Val extends Klaim>
    implements $KlaimCopyWith<$Res> {
  _$KlaimCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KlaimImplCopyWith<$Res> implements $KlaimCopyWith<$Res> {
  factory _$$KlaimImplCopyWith(
          _$KlaimImpl value, $Res Function(_$KlaimImpl) then) =
      __$$KlaimImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$KlaimImplCopyWithImpl<$Res>
    extends _$KlaimCopyWithImpl<$Res, _$KlaimImpl>
    implements _$$KlaimImplCopyWith<$Res> {
  __$$KlaimImplCopyWithImpl(
      _$KlaimImpl _value, $Res Function(_$KlaimImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$KlaimImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KlaimImpl implements _Klaim {
  const _$KlaimImpl({required this.id});

  factory _$KlaimImpl.fromJson(Map<String, dynamic> json) =>
      _$$KlaimImplFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'Klaim(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KlaimImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KlaimImplCopyWith<_$KlaimImpl> get copyWith =>
      __$$KlaimImplCopyWithImpl<_$KlaimImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KlaimImplToJson(
      this,
    );
  }
}

abstract class _Klaim implements Klaim {
  const factory _Klaim({required final int id}) = _$KlaimImpl;

  factory _Klaim.fromJson(Map<String, dynamic> json) = _$KlaimImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$KlaimImplCopyWith<_$KlaimImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
