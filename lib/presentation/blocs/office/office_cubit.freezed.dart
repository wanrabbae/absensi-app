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
  Profile? get user => throw _privateConstructorUsedError;
  Company? get company => throw _privateConstructorUsedError;
  DateTime get selectedDate => throw _privateConstructorUsedError;
  OfficeAttendance get attendance => throw _privateConstructorUsedError;
  OfficeLeave get leave => throw _privateConstructorUsedError;
  OfficePermit get permit => throw _privateConstructorUsedError;
  OfficeSick get sick => throw _privateConstructorUsedError;

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
      {Profile? user,
      Company? company,
      DateTime selectedDate,
      OfficeAttendance attendance,
      OfficeLeave leave,
      OfficePermit permit,
      OfficeSick sick});

  $ProfileCopyWith<$Res>? get user;
  $CompanyCopyWith<$Res>? get company;
  $OfficeAttendanceCopyWith<$Res> get attendance;
  $OfficeLeaveCopyWith<$Res> get leave;
  $OfficePermitCopyWith<$Res> get permit;
  $OfficeSickCopyWith<$Res> get sick;
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
    Object? user = freezed,
    Object? company = freezed,
    Object? selectedDate = null,
    Object? attendance = null,
    Object? leave = null,
    Object? permit = null,
    Object? sick = null,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Profile?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company?,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attendance: null == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as OfficeAttendance,
      leave: null == leave
          ? _value.leave
          : leave // ignore: cast_nullable_to_non_nullable
              as OfficeLeave,
      permit: null == permit
          ? _value.permit
          : permit // ignore: cast_nullable_to_non_nullable
              as OfficePermit,
      sick: null == sick
          ? _value.sick
          : sick // ignore: cast_nullable_to_non_nullable
              as OfficeSick,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<$Res>? get company {
    if (_value.company == null) {
      return null;
    }

    return $CompanyCopyWith<$Res>(_value.company!, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
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
  $OfficeLeaveCopyWith<$Res> get leave {
    return $OfficeLeaveCopyWith<$Res>(_value.leave, (value) {
      return _then(_value.copyWith(leave: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OfficePermitCopyWith<$Res> get permit {
    return $OfficePermitCopyWith<$Res>(_value.permit, (value) {
      return _then(_value.copyWith(permit: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OfficeSickCopyWith<$Res> get sick {
    return $OfficeSickCopyWith<$Res>(_value.sick, (value) {
      return _then(_value.copyWith(sick: value) as $Val);
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
      {Profile? user,
      Company? company,
      DateTime selectedDate,
      OfficeAttendance attendance,
      OfficeLeave leave,
      OfficePermit permit,
      OfficeSick sick});

  @override
  $ProfileCopyWith<$Res>? get user;
  @override
  $CompanyCopyWith<$Res>? get company;
  @override
  $OfficeAttendanceCopyWith<$Res> get attendance;
  @override
  $OfficeLeaveCopyWith<$Res> get leave;
  @override
  $OfficePermitCopyWith<$Res> get permit;
  @override
  $OfficeSickCopyWith<$Res> get sick;
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
    Object? user = freezed,
    Object? company = freezed,
    Object? selectedDate = null,
    Object? attendance = null,
    Object? leave = null,
    Object? permit = null,
    Object? sick = null,
  }) {
    return _then(_$OfficeStateImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Profile?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company?,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attendance: null == attendance
          ? _value.attendance
          : attendance // ignore: cast_nullable_to_non_nullable
              as OfficeAttendance,
      leave: null == leave
          ? _value.leave
          : leave // ignore: cast_nullable_to_non_nullable
              as OfficeLeave,
      permit: null == permit
          ? _value.permit
          : permit // ignore: cast_nullable_to_non_nullable
              as OfficePermit,
      sick: null == sick
          ? _value.sick
          : sick // ignore: cast_nullable_to_non_nullable
              as OfficeSick,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfficeStateImpl extends _OfficeState {
  const _$OfficeStateImpl(
      {this.user,
      this.company,
      required this.selectedDate,
      this.attendance = const OfficeAttendance(),
      this.leave = const OfficeLeave(),
      this.permit = const OfficePermit(),
      this.sick = const OfficeSick()})
      : super._();

  factory _$OfficeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficeStateImplFromJson(json);

  @override
  final Profile? user;
  @override
  final Company? company;
  @override
  final DateTime selectedDate;
  @override
  @JsonKey()
  final OfficeAttendance attendance;
  @override
  @JsonKey()
  final OfficeLeave leave;
  @override
  @JsonKey()
  final OfficePermit permit;
  @override
  @JsonKey()
  final OfficeSick sick;

  @override
  String toString() {
    return 'OfficeState(user: $user, company: $company, selectedDate: $selectedDate, attendance: $attendance, leave: $leave, permit: $permit, sick: $sick)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficeStateImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance) &&
            (identical(other.leave, leave) || other.leave == leave) &&
            (identical(other.permit, permit) || other.permit == permit) &&
            (identical(other.sick, sick) || other.sick == sick));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, company, selectedDate,
      attendance, leave, permit, sick);

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

abstract class _OfficeState extends OfficeState {
  const factory _OfficeState(
      {final Profile? user,
      final Company? company,
      required final DateTime selectedDate,
      final OfficeAttendance attendance,
      final OfficeLeave leave,
      final OfficePermit permit,
      final OfficeSick sick}) = _$OfficeStateImpl;
  const _OfficeState._() : super._();

  factory _OfficeState.fromJson(Map<String, dynamic> json) =
      _$OfficeStateImpl.fromJson;

  @override
  Profile? get user;
  @override
  Company? get company;
  @override
  DateTime get selectedDate;
  @override
  OfficeAttendance get attendance;
  @override
  OfficeLeave get leave;
  @override
  OfficePermit get permit;
  @override
  OfficeSick get sick;
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

OfficeLeave _$OfficeLeaveFromJson(Map<String, dynamic> json) {
  return _OfficeLeave.fromJson(json);
}

/// @nodoc
mixin _$OfficeLeave {
  List<Report>? get listLeave => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfficeLeaveCopyWith<OfficeLeave> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeLeaveCopyWith<$Res> {
  factory $OfficeLeaveCopyWith(
          OfficeLeave value, $Res Function(OfficeLeave) then) =
      _$OfficeLeaveCopyWithImpl<$Res, OfficeLeave>;
  @useResult
  $Res call({List<Report>? listLeave, String? error});
}

/// @nodoc
class _$OfficeLeaveCopyWithImpl<$Res, $Val extends OfficeLeave>
    implements $OfficeLeaveCopyWith<$Res> {
  _$OfficeLeaveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listLeave = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      listLeave: freezed == listLeave
          ? _value.listLeave
          : listLeave // ignore: cast_nullable_to_non_nullable
              as List<Report>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfficeLeaveImplCopyWith<$Res>
    implements $OfficeLeaveCopyWith<$Res> {
  factory _$$OfficeLeaveImplCopyWith(
          _$OfficeLeaveImpl value, $Res Function(_$OfficeLeaveImpl) then) =
      __$$OfficeLeaveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Report>? listLeave, String? error});
}

/// @nodoc
class __$$OfficeLeaveImplCopyWithImpl<$Res>
    extends _$OfficeLeaveCopyWithImpl<$Res, _$OfficeLeaveImpl>
    implements _$$OfficeLeaveImplCopyWith<$Res> {
  __$$OfficeLeaveImplCopyWithImpl(
      _$OfficeLeaveImpl _value, $Res Function(_$OfficeLeaveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listLeave = freezed,
    Object? error = freezed,
  }) {
    return _then(_$OfficeLeaveImpl(
      listLeave: freezed == listLeave
          ? _value._listLeave
          : listLeave // ignore: cast_nullable_to_non_nullable
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
class _$OfficeLeaveImpl extends _OfficeLeave {
  const _$OfficeLeaveImpl({final List<Report>? listLeave, this.error})
      : _listLeave = listLeave,
        super._();

  factory _$OfficeLeaveImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficeLeaveImplFromJson(json);

  final List<Report>? _listLeave;
  @override
  List<Report>? get listLeave {
    final value = _listLeave;
    if (value == null) return null;
    if (_listLeave is EqualUnmodifiableListView) return _listLeave;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'OfficeLeave(listLeave: $listLeave, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficeLeaveImpl &&
            const DeepCollectionEquality()
                .equals(other._listLeave, _listLeave) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_listLeave), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficeLeaveImplCopyWith<_$OfficeLeaveImpl> get copyWith =>
      __$$OfficeLeaveImplCopyWithImpl<_$OfficeLeaveImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficeLeaveImplToJson(
      this,
    );
  }
}

abstract class _OfficeLeave extends OfficeLeave {
  const factory _OfficeLeave(
      {final List<Report>? listLeave, final String? error}) = _$OfficeLeaveImpl;
  const _OfficeLeave._() : super._();

  factory _OfficeLeave.fromJson(Map<String, dynamic> json) =
      _$OfficeLeaveImpl.fromJson;

  @override
  List<Report>? get listLeave;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$OfficeLeaveImplCopyWith<_$OfficeLeaveImpl> get copyWith =>
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
class _$OfficePermitImpl extends _OfficePermit {
  const _$OfficePermitImpl({final List<Report>? listPermit, this.error})
      : _listPermit = listPermit,
        super._();

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

abstract class _OfficePermit extends OfficePermit {
  const factory _OfficePermit(
      {final List<Report>? listPermit,
      final String? error}) = _$OfficePermitImpl;
  const _OfficePermit._() : super._();

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

OfficeSick _$OfficeSickFromJson(Map<String, dynamic> json) {
  return _OfficeSick.fromJson(json);
}

/// @nodoc
mixin _$OfficeSick {
  List<Report>? get listSick => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfficeSickCopyWith<OfficeSick> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfficeSickCopyWith<$Res> {
  factory $OfficeSickCopyWith(
          OfficeSick value, $Res Function(OfficeSick) then) =
      _$OfficeSickCopyWithImpl<$Res, OfficeSick>;
  @useResult
  $Res call({List<Report>? listSick, String? error});
}

/// @nodoc
class _$OfficeSickCopyWithImpl<$Res, $Val extends OfficeSick>
    implements $OfficeSickCopyWith<$Res> {
  _$OfficeSickCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listSick = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      listSick: freezed == listSick
          ? _value.listSick
          : listSick // ignore: cast_nullable_to_non_nullable
              as List<Report>?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfficeSickImplCopyWith<$Res>
    implements $OfficeSickCopyWith<$Res> {
  factory _$$OfficeSickImplCopyWith(
          _$OfficeSickImpl value, $Res Function(_$OfficeSickImpl) then) =
      __$$OfficeSickImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Report>? listSick, String? error});
}

/// @nodoc
class __$$OfficeSickImplCopyWithImpl<$Res>
    extends _$OfficeSickCopyWithImpl<$Res, _$OfficeSickImpl>
    implements _$$OfficeSickImplCopyWith<$Res> {
  __$$OfficeSickImplCopyWithImpl(
      _$OfficeSickImpl _value, $Res Function(_$OfficeSickImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listSick = freezed,
    Object? error = freezed,
  }) {
    return _then(_$OfficeSickImpl(
      listSick: freezed == listSick
          ? _value._listSick
          : listSick // ignore: cast_nullable_to_non_nullable
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
class _$OfficeSickImpl extends _OfficeSick {
  const _$OfficeSickImpl({final List<Report>? listSick, this.error})
      : _listSick = listSick,
        super._();

  factory _$OfficeSickImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfficeSickImplFromJson(json);

  final List<Report>? _listSick;
  @override
  List<Report>? get listSick {
    final value = _listSick;
    if (value == null) return null;
    if (_listSick is EqualUnmodifiableListView) return _listSick;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'OfficeSick(listSick: $listSick, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfficeSickImpl &&
            const DeepCollectionEquality().equals(other._listSick, _listSick) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_listSick), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfficeSickImplCopyWith<_$OfficeSickImpl> get copyWith =>
      __$$OfficeSickImplCopyWithImpl<_$OfficeSickImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfficeSickImplToJson(
      this,
    );
  }
}

abstract class _OfficeSick extends OfficeSick {
  const factory _OfficeSick(
      {final List<Report>? listSick, final String? error}) = _$OfficeSickImpl;
  const _OfficeSick._() : super._();

  factory _OfficeSick.fromJson(Map<String, dynamic> json) =
      _$OfficeSickImpl.fromJson;

  @override
  List<Report>? get listSick;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$OfficeSickImplCopyWith<_$OfficeSickImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
