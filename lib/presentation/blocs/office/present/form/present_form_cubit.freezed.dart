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
  Profile get user => throw _privateConstructorUsedError;
  Absence? get currentAttendance => throw _privateConstructorUsedError;
  LatLng get currentLocation => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  bool get isCheckingIn => throw _privateConstructorUsedError;
  PageStatus get submitAttendanceStatus => throw _privateConstructorUsedError;

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
  $Res call(
      {Profile user,
      Absence? currentAttendance,
      LatLng currentLocation,
      String address,
      bool isCheckingIn,
      PageStatus submitAttendanceStatus});

  $ProfileCopyWith<$Res> get user;
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
    Object? user = null,
    Object? currentAttendance = freezed,
    Object? currentLocation = null,
    Object? address = null,
    Object? isCheckingIn = null,
    Object? submitAttendanceStatus = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Profile,
      currentAttendance: freezed == currentAttendance
          ? _value.currentAttendance
          : currentAttendance // ignore: cast_nullable_to_non_nullable
              as Absence?,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      isCheckingIn: null == isCheckingIn
          ? _value.isCheckingIn
          : isCheckingIn // ignore: cast_nullable_to_non_nullable
              as bool,
      submitAttendanceStatus: null == submitAttendanceStatus
          ? _value.submitAttendanceStatus
          : submitAttendanceStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res> get user {
    return $ProfileCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
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
  $Res call(
      {Profile user,
      Absence? currentAttendance,
      LatLng currentLocation,
      String address,
      bool isCheckingIn,
      PageStatus submitAttendanceStatus});

  @override
  $ProfileCopyWith<$Res> get user;
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
    Object? user = null,
    Object? currentAttendance = freezed,
    Object? currentLocation = null,
    Object? address = null,
    Object? isCheckingIn = null,
    Object? submitAttendanceStatus = null,
  }) {
    return _then(_$PresentFormStateImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as Profile,
      currentAttendance: freezed == currentAttendance
          ? _value.currentAttendance
          : currentAttendance // ignore: cast_nullable_to_non_nullable
              as Absence?,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      isCheckingIn: null == isCheckingIn
          ? _value.isCheckingIn
          : isCheckingIn // ignore: cast_nullable_to_non_nullable
              as bool,
      submitAttendanceStatus: null == submitAttendanceStatus
          ? _value.submitAttendanceStatus
          : submitAttendanceStatus // ignore: cast_nullable_to_non_nullable
              as PageStatus,
    ));
  }
}

/// @nodoc

class _$PresentFormStateImpl
    with DiagnosticableTreeMixin
    implements _PresentFormState {
  const _$PresentFormStateImpl(
      {required this.user,
      this.currentAttendance,
      this.currentLocation = const LatLng(3.5729021, 98.6292165),
      this.address = '',
      this.isCheckingIn = true,
      this.submitAttendanceStatus = PageStatus.idle});

  @override
  final Profile user;
  @override
  final Absence? currentAttendance;
  @override
  @JsonKey()
  final LatLng currentLocation;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final bool isCheckingIn;
  @override
  @JsonKey()
  final PageStatus submitAttendanceStatus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PresentFormState(user: $user, currentAttendance: $currentAttendance, currentLocation: $currentLocation, address: $address, isCheckingIn: $isCheckingIn, submitAttendanceStatus: $submitAttendanceStatus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PresentFormState'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('currentAttendance', currentAttendance))
      ..add(DiagnosticsProperty('currentLocation', currentLocation))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('isCheckingIn', isCheckingIn))
      ..add(DiagnosticsProperty(
          'submitAttendanceStatus', submitAttendanceStatus));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentFormStateImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.currentAttendance, currentAttendance) ||
                other.currentAttendance == currentAttendance) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.isCheckingIn, isCheckingIn) ||
                other.isCheckingIn == isCheckingIn) &&
            (identical(other.submitAttendanceStatus, submitAttendanceStatus) ||
                other.submitAttendanceStatus == submitAttendanceStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, currentAttendance,
      currentLocation, address, isCheckingIn, submitAttendanceStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentFormStateImplCopyWith<_$PresentFormStateImpl> get copyWith =>
      __$$PresentFormStateImplCopyWithImpl<_$PresentFormStateImpl>(
          this, _$identity);
}

abstract class _PresentFormState implements PresentFormState {
  const factory _PresentFormState(
      {required final Profile user,
      final Absence? currentAttendance,
      final LatLng currentLocation,
      final String address,
      final bool isCheckingIn,
      final PageStatus submitAttendanceStatus}) = _$PresentFormStateImpl;

  @override
  Profile get user;
  @override
  Absence? get currentAttendance;
  @override
  LatLng get currentLocation;
  @override
  String get address;
  @override
  bool get isCheckingIn;
  @override
  PageStatus get submitAttendanceStatus;
  @override
  @JsonKey(ignore: true)
  _$$PresentFormStateImplCopyWith<_$PresentFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
