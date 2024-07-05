// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'present_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PresentFormState {
  Absence? get currentAttendance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PresentFormStateCopyWith<PresentFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresentFormStateCopyWith<$Res> {
  factory $PresentFormStateCopyWith(
          PresentFormState value, $Res Function(PresentFormState) then) =
      _$PresentFormStateCopyWithImpl<$Res, PresentFormState>;
  @useResult
  $Res call({Absence? currentAttendance});

  $AbsenceCopyWith<$Res>? get currentAttendance;
}

/// @nodoc
class _$PresentFormStateCopyWithImpl<$Res, $Val extends PresentFormState>
    implements $PresentFormStateCopyWith<$Res> {
  _$PresentFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAttendance = freezed,
  }) {
    return _then(_value.copyWith(
      currentAttendance: freezed == currentAttendance
          ? _value.currentAttendance
          : currentAttendance // ignore: cast_nullable_to_non_nullable
              as Absence?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AbsenceCopyWith<$Res>? get currentAttendance {
    if (_value.currentAttendance == null) {
      return null;
    }

    return $AbsenceCopyWith<$Res>(_value.currentAttendance!, (value) {
      return _then(_value.copyWith(currentAttendance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PresentFormStateImplCopyWith<$Res>
    implements $PresentFormStateCopyWith<$Res> {
  factory _$$PresentFormStateImplCopyWith(_$PresentFormStateImpl value,
          $Res Function(_$PresentFormStateImpl) then) =
      __$$PresentFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Absence? currentAttendance});

  @override
  $AbsenceCopyWith<$Res>? get currentAttendance;
}

/// @nodoc
class __$$PresentFormStateImplCopyWithImpl<$Res>
    extends _$PresentFormStateCopyWithImpl<$Res, _$PresentFormStateImpl>
    implements _$$PresentFormStateImplCopyWith<$Res> {
  __$$PresentFormStateImplCopyWithImpl(_$PresentFormStateImpl _value,
      $Res Function(_$PresentFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAttendance = freezed,
  }) {
    return _then(_$PresentFormStateImpl(
      currentAttendance: freezed == currentAttendance
          ? _value.currentAttendance
          : currentAttendance // ignore: cast_nullable_to_non_nullable
              as Absence?,
    ));
  }
}

/// @nodoc

class _$PresentFormStateImpl implements _PresentFormState {
  const _$PresentFormStateImpl({this.currentAttendance});

  @override
  final Absence? currentAttendance;

  @override
  String toString() {
    return 'PresentFormState(currentAttendance: $currentAttendance)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentFormStateImpl &&
            (identical(other.currentAttendance, currentAttendance) ||
                other.currentAttendance == currentAttendance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentAttendance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentFormStateImplCopyWith<_$PresentFormStateImpl> get copyWith =>
      __$$PresentFormStateImplCopyWithImpl<_$PresentFormStateImpl>(
          this, _$identity);
}

abstract class _PresentFormState implements PresentFormState {
  const factory _PresentFormState({final Absence? currentAttendance}) =
      _$PresentFormStateImpl;

  @override
  Absence? get currentAttendance;
  @override
  @JsonKey(ignore: true)
  _$$PresentFormStateImplCopyWith<_$PresentFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
