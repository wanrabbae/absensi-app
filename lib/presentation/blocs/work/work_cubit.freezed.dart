// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WorkState {
  Profile get user => throw _privateConstructorUsedError;
  DateTime get selectedDate => throw _privateConstructorUsedError;
  List<Klaim>? get klaimList => throw _privateConstructorUsedError;
  String? get klaimError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorkStateCopyWith<WorkState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkStateCopyWith<$Res> {
  factory $WorkStateCopyWith(WorkState value, $Res Function(WorkState) then) =
      _$WorkStateCopyWithImpl<$Res, WorkState>;
  @useResult
  $Res call(
      {Profile user,
      DateTime selectedDate,
      List<Klaim>? klaimList,
      String? klaimError});

  $ProfileCopyWith<$Res> get user;
}

/// @nodoc
class _$WorkStateCopyWithImpl<$Res, $Val extends WorkState>
    implements $WorkStateCopyWith<$Res> {
  _$WorkStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? selectedDate = null,
    Object? klaimList = freezed,
    Object? klaimError = freezed,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Profile,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      klaimList: freezed == klaimList
          ? _value.klaimList
          : klaimList // ignore: cast_nullable_to_non_nullable
              as List<Klaim>?,
      klaimError: freezed == klaimError
          ? _value.klaimError
          : klaimError // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res> get user {
    return $ProfileCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkStateImplCopyWith<$Res>
    implements $WorkStateCopyWith<$Res> {
  factory _$$WorkStateImplCopyWith(
          _$WorkStateImpl value, $Res Function(_$WorkStateImpl) then) =
      __$$WorkStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Profile user,
      DateTime selectedDate,
      List<Klaim>? klaimList,
      String? klaimError});

  @override
  $ProfileCopyWith<$Res> get user;
}

/// @nodoc
class __$$WorkStateImplCopyWithImpl<$Res>
    extends _$WorkStateCopyWithImpl<$Res, _$WorkStateImpl>
    implements _$$WorkStateImplCopyWith<$Res> {
  __$$WorkStateImplCopyWithImpl(
      _$WorkStateImpl _value, $Res Function(_$WorkStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? selectedDate = null,
    Object? klaimList = freezed,
    Object? klaimError = freezed,
  }) {
    return _then(_$WorkStateImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Profile,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      klaimList: freezed == klaimList
          ? _value._klaimList
          : klaimList // ignore: cast_nullable_to_non_nullable
              as List<Klaim>?,
      klaimError: freezed == klaimError
          ? _value.klaimError
          : klaimError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WorkStateImpl implements _WorkState {
  const _$WorkStateImpl(
      {required this.user,
      required this.selectedDate,
      final List<Klaim>? klaimList,
      this.klaimError})
      : _klaimList = klaimList;

  @override
  final Profile user;
  @override
  final DateTime selectedDate;
  final List<Klaim>? _klaimList;
  @override
  List<Klaim>? get klaimList {
    final value = _klaimList;
    if (value == null) return null;
    if (_klaimList is EqualUnmodifiableListView) return _klaimList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? klaimError;

  @override
  String toString() {
    return 'WorkState(user: $user, selectedDate: $selectedDate, klaimList: $klaimList, klaimError: $klaimError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkStateImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality()
                .equals(other._klaimList, _klaimList) &&
            (identical(other.klaimError, klaimError) ||
                other.klaimError == klaimError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, selectedDate,
      const DeepCollectionEquality().hash(_klaimList), klaimError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkStateImplCopyWith<_$WorkStateImpl> get copyWith =>
      __$$WorkStateImplCopyWithImpl<_$WorkStateImpl>(this, _$identity);
}

abstract class _WorkState implements WorkState {
  const factory _WorkState(
      {required final Profile user,
      required final DateTime selectedDate,
      final List<Klaim>? klaimList,
      final String? klaimError}) = _$WorkStateImpl;

  @override
  Profile get user;
  @override
  DateTime get selectedDate;
  @override
  List<Klaim>? get klaimList;
  @override
  String? get klaimError;
  @override
  @JsonKey(ignore: true)
  _$$WorkStateImplCopyWith<_$WorkStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
