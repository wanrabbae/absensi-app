// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'present_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PresentDetailState {
  Absence get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PresentDetailStateCopyWith<PresentDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresentDetailStateCopyWith<$Res> {
  factory $PresentDetailStateCopyWith(
          PresentDetailState value, $Res Function(PresentDetailState) then) =
      _$PresentDetailStateCopyWithImpl<$Res, PresentDetailState>;
  @useResult
  $Res call({Absence data});

  $AbsenceCopyWith<$Res> get data;
}

/// @nodoc
class _$PresentDetailStateCopyWithImpl<$Res, $Val extends PresentDetailState>
    implements $PresentDetailStateCopyWith<$Res> {
  _$PresentDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Absence,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AbsenceCopyWith<$Res> get data {
    return $AbsenceCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PresentDetailStateImplCopyWith<$Res>
    implements $PresentDetailStateCopyWith<$Res> {
  factory _$$PresentDetailStateImplCopyWith(_$PresentDetailStateImpl value,
          $Res Function(_$PresentDetailStateImpl) then) =
      __$$PresentDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Absence data});

  @override
  $AbsenceCopyWith<$Res> get data;
}

/// @nodoc
class __$$PresentDetailStateImplCopyWithImpl<$Res>
    extends _$PresentDetailStateCopyWithImpl<$Res, _$PresentDetailStateImpl>
    implements _$$PresentDetailStateImplCopyWith<$Res> {
  __$$PresentDetailStateImplCopyWithImpl(_$PresentDetailStateImpl _value,
      $Res Function(_$PresentDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$PresentDetailStateImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Absence,
    ));
  }
}

/// @nodoc

class _$PresentDetailStateImpl implements _PresentDetailState {
  const _$PresentDetailStateImpl({required this.data});

  @override
  final Absence data;

  @override
  String toString() {
    return 'PresentDetailState(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentDetailStateImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentDetailStateImplCopyWith<_$PresentDetailStateImpl> get copyWith =>
      __$$PresentDetailStateImplCopyWithImpl<_$PresentDetailStateImpl>(
          this, _$identity);
}

abstract class _PresentDetailState implements PresentDetailState {
  const factory _PresentDetailState({required final Absence data}) =
      _$PresentDetailStateImpl;

  @override
  Absence get data;
  @override
  @JsonKey(ignore: true)
  _$$PresentDetailStateImplCopyWith<_$PresentDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
