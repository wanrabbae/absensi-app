// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laporan_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LaporanFormState {
  XFile get file => throw _privateConstructorUsedError;
  List<Profile> get users => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get tag => throw _privateConstructorUsedError;
  LatLng get currentLocation => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  StateSubmit? get submit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LaporanFormStateCopyWith<LaporanFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaporanFormStateCopyWith<$Res> {
  factory $LaporanFormStateCopyWith(
          LaporanFormState value, $Res Function(LaporanFormState) then) =
      _$LaporanFormStateCopyWithImpl<$Res, LaporanFormState>;
  @useResult
  $Res call(
      {XFile file,
      List<Profile> users,
      String description,
      String tag,
      LatLng currentLocation,
      String address,
      String? error,
      StateSubmit? submit});
}

/// @nodoc
class _$LaporanFormStateCopyWithImpl<$Res, $Val extends LaporanFormState>
    implements $LaporanFormStateCopyWith<$Res> {
  _$LaporanFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? users = null,
    Object? description = null,
    Object? tag = null,
    Object? currentLocation = null,
    Object? address = null,
    Object? error = freezed,
    Object? submit = freezed,
  }) {
    return _then(_value.copyWith(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<Profile>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$LaporanFormStateImplCopyWith<$Res>
    implements $LaporanFormStateCopyWith<$Res> {
  factory _$$LaporanFormStateImplCopyWith(_$LaporanFormStateImpl value,
          $Res Function(_$LaporanFormStateImpl) then) =
      __$$LaporanFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {XFile file,
      List<Profile> users,
      String description,
      String tag,
      LatLng currentLocation,
      String address,
      String? error,
      StateSubmit? submit});
}

/// @nodoc
class __$$LaporanFormStateImplCopyWithImpl<$Res>
    extends _$LaporanFormStateCopyWithImpl<$Res, _$LaporanFormStateImpl>
    implements _$$LaporanFormStateImplCopyWith<$Res> {
  __$$LaporanFormStateImplCopyWithImpl(_$LaporanFormStateImpl _value,
      $Res Function(_$LaporanFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
    Object? users = null,
    Object? description = null,
    Object? tag = null,
    Object? currentLocation = null,
    Object? address = null,
    Object? error = freezed,
    Object? submit = freezed,
  }) {
    return _then(_$LaporanFormStateImpl(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as XFile,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<Profile>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocation: null == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$LaporanFormStateImpl implements _LaporanFormState {
  const _$LaporanFormStateImpl(
      {required this.file,
      final List<Profile> users = const [],
      this.description = '',
      this.tag = '',
      this.currentLocation = const LatLng(3.5729021, 98.6292165),
      this.address = '',
      this.error,
      this.submit})
      : _users = users;

  @override
  final XFile file;
  final List<Profile> _users;
  @override
  @JsonKey()
  List<Profile> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String tag;
  @override
  @JsonKey()
  final LatLng currentLocation;
  @override
  @JsonKey()
  final String address;
  @override
  final String? error;
  @override
  final StateSubmit? submit;

  @override
  String toString() {
    return 'LaporanFormState(file: $file, users: $users, description: $description, tag: $tag, currentLocation: $currentLocation, address: $address, error: $error, submit: $submit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaporanFormStateImpl &&
            (identical(other.file, file) || other.file == file) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.submit, submit) || other.submit == submit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      file,
      const DeepCollectionEquality().hash(_users),
      description,
      tag,
      currentLocation,
      address,
      error,
      submit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LaporanFormStateImplCopyWith<_$LaporanFormStateImpl> get copyWith =>
      __$$LaporanFormStateImplCopyWithImpl<_$LaporanFormStateImpl>(
          this, _$identity);
}

abstract class _LaporanFormState implements LaporanFormState {
  const factory _LaporanFormState(
      {required final XFile file,
      final List<Profile> users,
      final String description,
      final String tag,
      final LatLng currentLocation,
      final String address,
      final String? error,
      final StateSubmit? submit}) = _$LaporanFormStateImpl;

  @override
  XFile get file;
  @override
  List<Profile> get users;
  @override
  String get description;
  @override
  String get tag;
  @override
  LatLng get currentLocation;
  @override
  String get address;
  @override
  String? get error;
  @override
  StateSubmit? get submit;
  @override
  @JsonKey(ignore: true)
  _$$LaporanFormStateImplCopyWith<_$LaporanFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
