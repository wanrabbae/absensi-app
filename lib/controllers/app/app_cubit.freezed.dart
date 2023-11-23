// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return _AppState.fromJson(json);
}

/// @nodoc
mixin _$AppState {
  Profile? get currentUser => throw _privateConstructorUsedError;
  Company get company => throw _privateConstructorUsedError;
  List<LiveTracking> get liveTrackingList => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Absence? get todayAttendance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {Profile? currentUser,
      Company company,
      List<LiveTracking> liveTrackingList,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Absence? todayAttendance});

  $ProfileCopyWith<$Res>? get currentUser;
  $CompanyCopyWith<$Res> get company;
  $AbsenceCopyWith<$Res>? get todayAttendance;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUser = freezed,
    Object? company = null,
    Object? liveTrackingList = null,
    Object? todayAttendance = freezed,
  }) {
    return _then(_value.copyWith(
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as Profile?,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
      liveTrackingList: null == liveTrackingList
          ? _value.liveTrackingList
          : liveTrackingList // ignore: cast_nullable_to_non_nullable
              as List<LiveTracking>,
      todayAttendance: freezed == todayAttendance
          ? _value.todayAttendance
          : todayAttendance // ignore: cast_nullable_to_non_nullable
              as Absence?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyCopyWith<$Res> get company {
    return $CompanyCopyWith<$Res>(_value.company, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AbsenceCopyWith<$Res>? get todayAttendance {
    if (_value.todayAttendance == null) {
      return null;
    }

    return $AbsenceCopyWith<$Res>(_value.todayAttendance!, (value) {
      return _then(_value.copyWith(todayAttendance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Profile? currentUser,
      Company company,
      List<LiveTracking> liveTrackingList,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Absence? todayAttendance});

  @override
  $ProfileCopyWith<$Res>? get currentUser;
  @override
  $CompanyCopyWith<$Res> get company;
  @override
  $AbsenceCopyWith<$Res>? get todayAttendance;
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUser = freezed,
    Object? company = null,
    Object? liveTrackingList = null,
    Object? todayAttendance = freezed,
  }) {
    return _then(_$AppStateImpl(
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as Profile?,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as Company,
      liveTrackingList: null == liveTrackingList
          ? _value._liveTrackingList
          : liveTrackingList // ignore: cast_nullable_to_non_nullable
              as List<LiveTracking>,
      todayAttendance: freezed == todayAttendance
          ? _value.todayAttendance
          : todayAttendance // ignore: cast_nullable_to_non_nullable
              as Absence?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppStateImpl with DiagnosticableTreeMixin implements _AppState {
  const _$AppStateImpl(
      {this.currentUser,
      this.company = const Company(),
      final List<LiveTracking> liveTrackingList = const [],
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.todayAttendance})
      : _liveTrackingList = liveTrackingList;

  factory _$AppStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppStateImplFromJson(json);

  @override
  final Profile? currentUser;
  @override
  @JsonKey()
  final Company company;
  final List<LiveTracking> _liveTrackingList;
  @override
  @JsonKey()
  List<LiveTracking> get liveTrackingList {
    if (_liveTrackingList is EqualUnmodifiableListView)
      return _liveTrackingList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_liveTrackingList);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Absence? todayAttendance;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState(currentUser: $currentUser, company: $company, liveTrackingList: $liveTrackingList, todayAttendance: $todayAttendance)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState'))
      ..add(DiagnosticsProperty('currentUser', currentUser))
      ..add(DiagnosticsProperty('company', company))
      ..add(DiagnosticsProperty('liveTrackingList', liveTrackingList))
      ..add(DiagnosticsProperty('todayAttendance', todayAttendance));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            (identical(other.company, company) || other.company == company) &&
            const DeepCollectionEquality()
                .equals(other._liveTrackingList, _liveTrackingList) &&
            (identical(other.todayAttendance, todayAttendance) ||
                other.todayAttendance == todayAttendance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentUser, company,
      const DeepCollectionEquality().hash(_liveTrackingList), todayAttendance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppStateImplToJson(
      this,
    );
  }
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final Profile? currentUser,
      final Company company,
      final List<LiveTracking> liveTrackingList,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Absence? todayAttendance}) = _$AppStateImpl;

  factory _AppState.fromJson(Map<String, dynamic> json) =
      _$AppStateImpl.fromJson;

  @override
  Profile? get currentUser;
  @override
  Company get company;
  @override
  List<LiveTracking> get liveTrackingList;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Absence? get todayAttendance;
  @override
  @JsonKey(ignore: true)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
