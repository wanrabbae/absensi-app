// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_location_log_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LiveLocationLogState {
  List<LiveLocationLog>? get data => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LiveLocationLogStateCopyWith<LiveLocationLogState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveLocationLogStateCopyWith<$Res> {
  factory $LiveLocationLogStateCopyWith(LiveLocationLogState value,
          $Res Function(LiveLocationLogState) then) =
      _$LiveLocationLogStateCopyWithImpl<$Res, LiveLocationLogState>;
  @useResult
  $Res call({List<LiveLocationLog>? data, String? error});
}

/// @nodoc
class _$LiveLocationLogStateCopyWithImpl<$Res,
        $Val extends LiveLocationLogState>
    implements $LiveLocationLogStateCopyWith<$Res> {
  _$LiveLocationLogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<LiveLocationLog>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveLocationLogStateImplCopyWith<$Res>
    implements $LiveLocationLogStateCopyWith<$Res> {
  factory _$$LiveLocationLogStateImplCopyWith(_$LiveLocationLogStateImpl value,
          $Res Function(_$LiveLocationLogStateImpl) then) =
      __$$LiveLocationLogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LiveLocationLog>? data, String? error});
}

/// @nodoc
class __$$LiveLocationLogStateImplCopyWithImpl<$Res>
    extends _$LiveLocationLogStateCopyWithImpl<$Res, _$LiveLocationLogStateImpl>
    implements _$$LiveLocationLogStateImplCopyWith<$Res> {
  __$$LiveLocationLogStateImplCopyWithImpl(_$LiveLocationLogStateImpl _value,
      $Res Function(_$LiveLocationLogStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? error = freezed,
  }) {
    return _then(_$LiveLocationLogStateImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<LiveLocationLog>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LiveLocationLogStateImpl implements _LiveLocationLogState {
  const _$LiveLocationLogStateImpl(
      {final List<LiveLocationLog>? data, this.error})
      : _data = data;

  final List<LiveLocationLog>? _data;
  @override
  List<LiveLocationLog>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'LiveLocationLogState(data: $data, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveLocationLogStateImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveLocationLogStateImplCopyWith<_$LiveLocationLogStateImpl>
      get copyWith =>
          __$$LiveLocationLogStateImplCopyWithImpl<_$LiveLocationLogStateImpl>(
              this, _$identity);
}

abstract class _LiveLocationLogState implements LiveLocationLogState {
  const factory _LiveLocationLogState(
      {final List<LiveLocationLog>? data,
      final String? error}) = _$LiveLocationLogStateImpl;

  @override
  List<LiveLocationLog>? get data;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$LiveLocationLogStateImplCopyWith<_$LiveLocationLogStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
