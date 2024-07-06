// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'klaim_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KlaimFormState {
  XFile get file => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  ReimburseStateSubmit? get submit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KlaimFormStateCopyWith<KlaimFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KlaimFormStateCopyWith<$Res> {
  factory $KlaimFormStateCopyWith(
          KlaimFormState value, $Res Function(KlaimFormState) then) =
      _$KlaimFormStateCopyWithImpl<$Res, KlaimFormState>;
  @useResult
  $Res call(
      {XFile file,
      String description,
      String? error,
      ReimburseStateSubmit? submit});
}

/// @nodoc
class _$KlaimFormStateCopyWithImpl<$Res, $Val extends KlaimFormState>
    implements $KlaimFormStateCopyWith<$Res> {
  _$KlaimFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? description = null,
    Object? error = freezed,
    Object? submit = freezed,
  }) {
    return _then(_value.copyWith(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      submit: freezed == submit
          ? _value.submit
          : submit // ignore: cast_nullable_to_non_nullable
              as ReimburseStateSubmit?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KlaimFormStateImplCopyWith<$Res>
    implements $KlaimFormStateCopyWith<$Res> {
  factory _$$KlaimFormStateImplCopyWith(_$KlaimFormStateImpl value,
          $Res Function(_$KlaimFormStateImpl) then) =
      __$$KlaimFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {XFile file,
      String description,
      String? error,
      ReimburseStateSubmit? submit});
}

/// @nodoc
class __$$KlaimFormStateImplCopyWithImpl<$Res>
    extends _$KlaimFormStateCopyWithImpl<$Res, _$KlaimFormStateImpl>
    implements _$$KlaimFormStateImplCopyWith<$Res> {
  __$$KlaimFormStateImplCopyWithImpl(
      _$KlaimFormStateImpl _value, $Res Function(_$KlaimFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? description = null,
    Object? error = freezed,
    Object? submit = freezed,
  }) {
    return _then(_$KlaimFormStateImpl(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      submit: freezed == submit
          ? _value.submit
          : submit // ignore: cast_nullable_to_non_nullable
              as ReimburseStateSubmit?,
    ));
  }
}

/// @nodoc

class _$KlaimFormStateImpl implements _KlaimFormState {
  const _$KlaimFormStateImpl(
      {required this.file, this.description = '', this.error, this.submit});

  @override
  final XFile file;
  @override
  @JsonKey()
  final String description;
  @override
  final String? error;
  @override
  final ReimburseStateSubmit? submit;

  @override
  String toString() {
    return 'KlaimFormState(file: $file, description: $description, error: $error, submit: $submit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KlaimFormStateImpl &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.submit, submit) || other.submit == submit));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, file, description, error, submit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KlaimFormStateImplCopyWith<_$KlaimFormStateImpl> get copyWith =>
      __$$KlaimFormStateImplCopyWithImpl<_$KlaimFormStateImpl>(
          this, _$identity);
}

abstract class _KlaimFormState implements KlaimFormState {
  const factory _KlaimFormState(
      {required final XFile file,
      final String description,
      final String? error,
      final ReimburseStateSubmit? submit}) = _$KlaimFormStateImpl;

  @override
  XFile get file;
  @override
  String get description;
  @override
  String? get error;
  @override
  ReimburseStateSubmit? get submit;
  @override
  @JsonKey(ignore: true)
  _$$KlaimFormStateImplCopyWith<_$KlaimFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
