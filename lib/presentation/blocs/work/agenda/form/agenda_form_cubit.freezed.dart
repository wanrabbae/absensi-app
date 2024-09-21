// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AgendaFormState {
  AutovalidateMode get autoValidateMode => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  StateSubmit? get submit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AgendaFormStateCopyWith<AgendaFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgendaFormStateCopyWith<$Res> {
  factory $AgendaFormStateCopyWith(
          AgendaFormState value, $Res Function(AgendaFormState) then) =
      _$AgendaFormStateCopyWithImpl<$Res, AgendaFormState>;
  @useResult
  $Res call(
      {AutovalidateMode autoValidateMode, String? error, StateSubmit? submit});
}

/// @nodoc
class _$AgendaFormStateCopyWithImpl<$Res, $Val extends AgendaFormState>
    implements $AgendaFormStateCopyWith<$Res> {
  _$AgendaFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? autoValidateMode = null,
    Object? error = freezed,
    Object? submit = freezed,
  }) {
    return _then(_value.copyWith(
      autoValidateMode: null == autoValidateMode
          ? _value.autoValidateMode
          : autoValidateMode // ignore: cast_nullable_to_non_nullable
              as AutovalidateMode,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      submit: freezed == submit
          ? _value.submit
          : submit // ignore: cast_nullable_to_non_nullable
              as StateSubmit?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgendaFormStateImplCopyWith<$Res>
    implements $AgendaFormStateCopyWith<$Res> {
  factory _$$AgendaFormStateImplCopyWith(_$AgendaFormStateImpl value,
          $Res Function(_$AgendaFormStateImpl) then) =
      __$$AgendaFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AutovalidateMode autoValidateMode, String? error, StateSubmit? submit});
}

/// @nodoc
class __$$AgendaFormStateImplCopyWithImpl<$Res>
    extends _$AgendaFormStateCopyWithImpl<$Res, _$AgendaFormStateImpl>
    implements _$$AgendaFormStateImplCopyWith<$Res> {
  __$$AgendaFormStateImplCopyWithImpl(
      _$AgendaFormStateImpl _value, $Res Function(_$AgendaFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? autoValidateMode = null,
    Object? error = freezed,
    Object? submit = freezed,
  }) {
    return _then(_$AgendaFormStateImpl(
      autoValidateMode: null == autoValidateMode
          ? _value.autoValidateMode
          : autoValidateMode // ignore: cast_nullable_to_non_nullable
              as AutovalidateMode,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      submit: freezed == submit
          ? _value.submit
          : submit // ignore: cast_nullable_to_non_nullable
              as StateSubmit?,
    ));
  }
}

/// @nodoc

class _$AgendaFormStateImpl implements _AgendaFormState {
  const _$AgendaFormStateImpl(
      {this.autoValidateMode = AutovalidateMode.disabled,
      this.error,
      this.submit});

  @override
  @JsonKey()
  final AutovalidateMode autoValidateMode;
  @override
  final String? error;
  @override
  final StateSubmit? submit;

  @override
  String toString() {
    return 'AgendaFormState(autoValidateMode: $autoValidateMode, error: $error, submit: $submit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgendaFormStateImpl &&
            (identical(other.autoValidateMode, autoValidateMode) ||
                other.autoValidateMode == autoValidateMode) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.submit, submit) || other.submit == submit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, autoValidateMode, error, submit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgendaFormStateImplCopyWith<_$AgendaFormStateImpl> get copyWith =>
      __$$AgendaFormStateImplCopyWithImpl<_$AgendaFormStateImpl>(
          this, _$identity);
}

abstract class _AgendaFormState implements AgendaFormState {
  const factory _AgendaFormState(
      {final AutovalidateMode autoValidateMode,
      final String? error,
      final StateSubmit? submit}) = _$AgendaFormStateImpl;

  @override
  AutovalidateMode get autoValidateMode;
  @override
  String? get error;
  @override
  StateSubmit? get submit;
  @override
  @JsonKey(ignore: true)
  _$$AgendaFormStateImplCopyWith<_$AgendaFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
