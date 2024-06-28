// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'office_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OfficeState _$OfficeStateFromJson(Map<String, dynamic> json) {
  return _OfficeState.fromJson(json);
}

/// @nodoc
mixin _$OfficeState {
  DateTime? get selectedDate => throw _privateConstructorUsedError;
  OfficeAttendance get attendance => throw _privateConstructorUsedError;
  OfficePermit get permit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfficeStateCopyWith<OfficeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeStateCopyWith<$Res> {
  factory $OfficeStateCopyWith(
          OfficeState value, $Res Function(OfficeState) then) =
      _$OfficeStateCopyWithImpl<$Res, OfficeState>;
  @useResult
  $Res call(
      {DateTime? selectedDate,
      OfficeAttendance attendance,
      OfficePermit permit});

  $OfficeAttendanceCopyWith<$Res> get attendance;
  $OfficePermitCopyWith<$Res> get permit;
}

/// @nodoc
class _$OfficeStateCopyWithImpl<$Res, $Val extends OfficeState>
    implements $OfficeStateCopyWith<$Res> {
  _$OfficeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = freezed,
    Object? attendance = null,
    Object? permit = null,
  }) {
    return _then(_value.copyWith(
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      attendance: null == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as OfficeAttendance,
      permit: null == permit
          ? _value.permit
          : permit // ignore: cast_nullable_to_non_nullable
              as OfficePermit,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OfficeAttendanceCopyWith<$Res> get attendance {
    return $OfficeAttendanceCopyWith<$Res>(_value.attendance, (value) {
      return _then(_value.copyWith(attendance: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OfficePermitCopyWith<$Res> get permit {
    return $OfficePermitCopyWith<$Res>(_value.permit, (value) {
      return _then(_value.copyWith(permit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OfficeStateImplCopyWith<$Res>
    implements $OfficeStateCopyWith<$Res> {
  factory _$$OfficeStateImplCopyWith(
          _$OfficeStateImpl value, $Res Function(_$OfficeStateImpl) then) =
      __$$OfficeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? selectedDate,
      OfficeAttendance attendance,
      OfficePermit permit});

  @override
  $OfficeAttendanceCopyWith<$Res> get attendance;
  @override
  $OfficePermitCopyWith<$Res> get permit;
}

/// @nodoc
class __$$OfficeStateImplCopyWithImpl<$Res>
    extends _$OfficeStateCopyWithImpl<$Res, _$OfficeStateImpl>
    implements _$$OfficeStateImplCopyWith<$Res> {
  __$$OfficeStateImplCopyWithImpl(
      _$OfficeStateImpl _value, $Res Function(_$OfficeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = freezed,
    Object? attendance = null,
    Object? permit = null,
  }) {
    return _then(_$OfficeStateImpl(
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      attendance: null == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as OfficeAttendance,
      permit: null == permit
          ? _value.permit
          : permit // ignore: cast_nullable_to_non_nullable
              as OfficePermit,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfficeStateImpl implements _OfficeState {
  const _$OfficeStateImpl(
      {this.selectedDate,
      this.attendance = const OfficeAttendance(),
      this.permit = const OfficePermit()});

  factory _$OfficeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficeStateImplFromJson(json);

  @override
  final DateTime? selectedDate;
  @override
  @JsonKey()
  final OfficeAttendance attendance;
  @override
  @JsonKey()
  final OfficePermit permit;

  @override
  String toString() {
    return 'OfficeState(selectedDate: $selectedDate, attendance: $attendance, permit: $permit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficeStateImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance) &&
            (identical(other.permit, permit) || other.permit == permit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedDate, attendance, permit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficeStateImplCopyWith<_$OfficeStateImpl> get copyWith =>
      __$$OfficeStateImplCopyWithImpl<_$OfficeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficeStateImplToJson(
      this,
    );
  }
}

abstract class _OfficeState implements OfficeState {
  const factory _OfficeState(
      {final DateTime? selectedDate,
      final OfficeAttendance attendance,
      final OfficePermit permit}) = _$OfficeStateImpl;

  factory _OfficeState.fromJson(Map<String, dynamic> json) =
      _$OfficeStateImpl.fromJson;

  @override
  DateTime? get selectedDate;
  @override
  OfficeAttendance get attendance;
  @override
  OfficePermit get permit;
  @override
  @JsonKey(ignore: true)
  _$$OfficeStateImplCopyWith<_$OfficeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfficeAttendance _$OfficeAttendanceFromJson(Map<String, dynamic> json) {
  return _OfficeAttendance.fromJson(json);
}

/// @nodoc
mixin _$OfficeAttendance {
  Absence? get currentAttendance => throw _privateConstructorUsedError;
  List<Absence>? get listAttendance => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfficeAttendanceCopyWith<OfficeAttendance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeAttendanceCopyWith<$Res> {
  factory $OfficeAttendanceCopyWith(
          OfficeAttendance value, $Res Function(OfficeAttendance) then) =
      _$OfficeAttendanceCopyWithImpl<$Res, OfficeAttendance>;
  @useResult
  $Res call(
      {Absence? currentAttendance,
      List<Absence>? listAttendance,
      String? error});

  $AbsenceCopyWith<$Res>? get currentAttendance;
}

/// @nodoc
class _$OfficeAttendanceCopyWithImpl<$Res, $Val extends OfficeAttendance>
    implements $OfficeAttendanceCopyWith<$Res> {
  _$OfficeAttendanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAttendance = freezed,
    Object? listAttendance = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      currentAttendance: freezed == currentAttendance
          ? _value.currentAttendance
          : currentAttendance // ignore: cast_nullable_to_non_nullable
              as Absence?,
      listAttendance: freezed == listAttendance
          ? _value.listAttendance
          : listAttendance // ignore: cast_nullable_to_non_nullable
              as List<Absence>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$OfficeAttendanceImplCopyWith<$Res>
    implements $OfficeAttendanceCopyWith<$Res> {
  factory _$$OfficeAttendanceImplCopyWith(_$OfficeAttendanceImpl value,
          $Res Function(_$OfficeAttendanceImpl) then) =
      __$$OfficeAttendanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Absence? currentAttendance,
      List<Absence>? listAttendance,
      String? error});

  @override
  $AbsenceCopyWith<$Res>? get currentAttendance;
}

/// @nodoc
class __$$OfficeAttendanceImplCopyWithImpl<$Res>
    extends _$OfficeAttendanceCopyWithImpl<$Res, _$OfficeAttendanceImpl>
    implements _$$OfficeAttendanceImplCopyWith<$Res> {
  __$$OfficeAttendanceImplCopyWithImpl(_$OfficeAttendanceImpl _value,
      $Res Function(_$OfficeAttendanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAttendance = freezed,
    Object? listAttendance = freezed,
    Object? error = freezed,
  }) {
    return _then(_$OfficeAttendanceImpl(
      currentAttendance: freezed == currentAttendance
          ? _value.currentAttendance
          : currentAttendance // ignore: cast_nullable_to_non_nullable
              as Absence?,
      listAttendance: freezed == listAttendance
          ? _value._listAttendance
          : listAttendance // ignore: cast_nullable_to_non_nullable
              as List<Absence>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfficeAttendanceImpl implements _OfficeAttendance {
  const _$OfficeAttendanceImpl(
      {this.currentAttendance, final List<Absence>? listAttendance, this.error})
      : _listAttendance = listAttendance;

  factory _$OfficeAttendanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficeAttendanceImplFromJson(json);

  @override
  final Absence? currentAttendance;
  final List<Absence>? _listAttendance;
  @override
  List<Absence>? get listAttendance {
    final value = _listAttendance;
    if (value == null) return null;
    if (_listAttendance is EqualUnmodifiableListView) return _listAttendance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'OfficeAttendance(currentAttendance: $currentAttendance, listAttendance: $listAttendance, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficeAttendanceImpl &&
            (identical(other.currentAttendance, currentAttendance) ||
                other.currentAttendance == currentAttendance) &&
            const DeepCollectionEquality()
                .equals(other._listAttendance, _listAttendance) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentAttendance,
      const DeepCollectionEquality().hash(_listAttendance), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficeAttendanceImplCopyWith<_$OfficeAttendanceImpl> get copyWith =>
      __$$OfficeAttendanceImplCopyWithImpl<_$OfficeAttendanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficeAttendanceImplToJson(
      this,
    );
  }
}

abstract class _OfficeAttendance implements OfficeAttendance {
  const factory _OfficeAttendance(
      {final Absence? currentAttendance,
      final List<Absence>? listAttendance,
      final String? error}) = _$OfficeAttendanceImpl;

  factory _OfficeAttendance.fromJson(Map<String, dynamic> json) =
      _$OfficeAttendanceImpl.fromJson;

  @override
  Absence? get currentAttendance;
  @override
  List<Absence>? get listAttendance;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$OfficeAttendanceImplCopyWith<_$OfficeAttendanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OfficePermit _$OfficePermitFromJson(Map<String, dynamic> json) {
  return _OfficePermit.fromJson(json);
}

/// @nodoc
mixin _$OfficePermit {
  List<Report>? get listPermit => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfficePermitCopyWith<OfficePermit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficePermitCopyWith<$Res> {
  factory $OfficePermitCopyWith(
          OfficePermit value, $Res Function(OfficePermit) then) =
      _$OfficePermitCopyWithImpl<$Res, OfficePermit>;
  @useResult
  $Res call({List<Report>? listPermit, String? error});
}

/// @nodoc
class _$OfficePermitCopyWithImpl<$Res, $Val extends OfficePermit>
    implements $OfficePermitCopyWith<$Res> {
  _$OfficePermitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listPermit = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      listPermit: freezed == listPermit
          ? _value.listPermit
          : listPermit // ignore: cast_nullable_to_non_nullable
              as List<Report>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfficePermitImplCopyWith<$Res>
    implements $OfficePermitCopyWith<$Res> {
  factory _$$OfficePermitImplCopyWith(
          _$OfficePermitImpl value, $Res Function(_$OfficePermitImpl) then) =
      __$$OfficePermitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Report>? listPermit, String? error});
}

/// @nodoc
class __$$OfficePermitImplCopyWithImpl<$Res>
    extends _$OfficePermitCopyWithImpl<$Res, _$OfficePermitImpl>
    implements _$$OfficePermitImplCopyWith<$Res> {
  __$$OfficePermitImplCopyWithImpl(
      _$OfficePermitImpl _value, $Res Function(_$OfficePermitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listPermit = freezed,
    Object? error = freezed,
  }) {
    return _then(_$OfficePermitImpl(
      listPermit: freezed == listPermit
          ? _value._listPermit
          : listPermit // ignore: cast_nullable_to_non_nullable
              as List<Report>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfficePermitImpl implements _OfficePermit {
  const _$OfficePermitImpl({final List<Report>? listPermit, this.error})
      : _listPermit = listPermit;

  factory _$OfficePermitImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficePermitImplFromJson(json);

  final List<Report>? _listPermit;
  @override
  List<Report>? get listPermit {
    final value = _listPermit;
    if (value == null) return null;
    if (_listPermit is EqualUnmodifiableListView) return _listPermit;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'OfficePermit(listPermit: $listPermit, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficePermitImpl &&
            const DeepCollectionEquality()
                .equals(other._listPermit, _listPermit) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_listPermit), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficePermitImplCopyWith<_$OfficePermitImpl> get copyWith =>
      __$$OfficePermitImplCopyWithImpl<_$OfficePermitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficePermitImplToJson(
      this,
    );
  }
}

abstract class _OfficePermit implements OfficePermit {
  const factory _OfficePermit(
      {final List<Report>? listPermit,
      final String? error}) = _$OfficePermitImpl;

  factory _OfficePermit.fromJson(Map<String, dynamic> json) =
      _$OfficePermitImpl.fromJson;

  @override
  List<Report>? get listPermit;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$OfficePermitImplCopyWith<_$OfficePermitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
