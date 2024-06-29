// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReportState {
  XFile get image => throw _privateConstructorUsedError;
  ReportType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ReportStateSubmit? get submit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReportStateCopyWith<ReportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportStateCopyWith<$Res> {
  factory $ReportStateCopyWith(
          ReportState value, $Res Function(ReportState) then) =
      _$ReportStateCopyWithImpl<$Res, ReportState>;
  @useResult
  $Res call(
      {XFile image,
      ReportType type,
      String description,
      ReportStateSubmit? submit});
}

/// @nodoc
class _$ReportStateCopyWithImpl<$Res, $Val extends ReportState>
    implements $ReportStateCopyWith<$Res> {
  _$ReportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? type = null,
    Object? description = null,
    Object? submit = freezed,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as XFile,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReportType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      submit: freezed == submit
          ? _value.submit
          : submit // ignore: cast_nullable_to_non_nullable
              as ReportStateSubmit?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportStateImplCopyWith<$Res>
    implements $ReportStateCopyWith<$Res> {
  factory _$$ReportStateImplCopyWith(
          _$ReportStateImpl value, $Res Function(_$ReportStateImpl) then) =
      __$$ReportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {XFile image,
      ReportType type,
      String description,
      ReportStateSubmit? submit});
}

/// @nodoc
class __$$ReportStateImplCopyWithImpl<$Res>
    extends _$ReportStateCopyWithImpl<$Res, _$ReportStateImpl>
    implements _$$ReportStateImplCopyWith<$Res> {
  __$$ReportStateImplCopyWithImpl(
      _$ReportStateImpl _value, $Res Function(_$ReportStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? type = null,
    Object? description = null,
    Object? submit = freezed,
  }) {
    return _then(_$ReportStateImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as XFile,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReportType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      submit: freezed == submit
          ? _value.submit
          : submit // ignore: cast_nullable_to_non_nullable
              as ReportStateSubmit?,
    ));
  }
}

/// @nodoc

class _$ReportStateImpl implements _ReportState {
  const _$ReportStateImpl(
      {required this.image,
      required this.type,
      this.description = '',
      this.submit});

  @override
  final XFile image;
  @override
  final ReportType type;
  @override
  @JsonKey()
  final String description;
  @override
  final ReportStateSubmit? submit;

  @override
  String toString() {
    return 'ReportState(image: $image, type: $type, description: $description, submit: $submit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportStateImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.submit, submit) || other.submit == submit));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, image, type, description, submit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportStateImplCopyWith<_$ReportStateImpl> get copyWith =>
      __$$ReportStateImplCopyWithImpl<_$ReportStateImpl>(this, _$identity);
}

abstract class _ReportState implements ReportState {
  const factory _ReportState(
      {required final XFile image,
      required final ReportType type,
      final String description,
      final ReportStateSubmit? submit}) = _$ReportStateImpl;

  @override
  XFile get image;
  @override
  ReportType get type;
  @override
  String get description;
  @override
  ReportStateSubmit? get submit;
  @override
  @JsonKey(ignore: true)
  _$$ReportStateImplCopyWith<_$ReportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
