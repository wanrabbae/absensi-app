// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_location_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LiveLocationLog _$LiveLocationLogFromJson(Map<String, dynamic> json) {
  return _LiveLocationLog.fromJson(json);
}

/// @nodoc
mixin _$LiveLocationLog {
  String? get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @FirebaseTimestampConverter2()
  @JsonKey(name: 'timestamp')
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiveLocationLogCopyWith<LiveLocationLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveLocationLogCopyWith<$Res> {
  factory $LiveLocationLogCopyWith(
          LiveLocationLog value, $Res Function(LiveLocationLog) then) =
      _$LiveLocationLogCopyWithImpl<$Res, LiveLocationLog>;
  @useResult
  $Res call(
      {String? uid,
      @JsonKey(name: 'user_id') String userId,
      double latitude,
      double longitude,
      String address,
      @FirebaseTimestampConverter2()
      @JsonKey(name: 'timestamp')
      DateTime timestamp});
}

/// @nodoc
class _$LiveLocationLogCopyWithImpl<$Res, $Val extends LiveLocationLog>
    implements $LiveLocationLogCopyWith<$Res> {
  _$LiveLocationLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? userId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveLocationLogImplCopyWith<$Res>
    implements $LiveLocationLogCopyWith<$Res> {
  factory _$$LiveLocationLogImplCopyWith(_$LiveLocationLogImpl value,
          $Res Function(_$LiveLocationLogImpl) then) =
      __$$LiveLocationLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      @JsonKey(name: 'user_id') String userId,
      double latitude,
      double longitude,
      String address,
      @FirebaseTimestampConverter2()
      @JsonKey(name: 'timestamp')
      DateTime timestamp});
}

/// @nodoc
class __$$LiveLocationLogImplCopyWithImpl<$Res>
    extends _$LiveLocationLogCopyWithImpl<$Res, _$LiveLocationLogImpl>
    implements _$$LiveLocationLogImplCopyWith<$Res> {
  __$$LiveLocationLogImplCopyWithImpl(
      _$LiveLocationLogImpl _value, $Res Function(_$LiveLocationLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? userId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? address = null,
    Object? timestamp = null,
  }) {
    return _then(_$LiveLocationLogImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveLocationLogImpl implements _LiveLocationLog {
  const _$LiveLocationLogImpl(
      {this.uid,
      @JsonKey(name: 'user_id') required this.userId,
      required this.latitude,
      required this.longitude,
      this.address = '',
      @FirebaseTimestampConverter2()
      @JsonKey(name: 'timestamp')
      required this.timestamp});

  factory _$LiveLocationLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveLocationLogImplFromJson(json);

  @override
  final String? uid;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey()
  final String address;
  @override
  @FirebaseTimestampConverter2()
  @JsonKey(name: 'timestamp')
  final DateTime timestamp;

  @override
  String toString() {
    return 'LiveLocationLog(uid: $uid, userId: $userId, latitude: $latitude, longitude: $longitude, address: $address, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveLocationLogImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, uid, userId, latitude, longitude, address, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveLocationLogImplCopyWith<_$LiveLocationLogImpl> get copyWith =>
      __$$LiveLocationLogImplCopyWithImpl<_$LiveLocationLogImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveLocationLogImplToJson(
      this,
    );
  }
}

abstract class _LiveLocationLog implements LiveLocationLog {
  const factory _LiveLocationLog(
      {final String? uid,
      @JsonKey(name: 'user_id') required final String userId,
      required final double latitude,
      required final double longitude,
      final String address,
      @FirebaseTimestampConverter2()
      @JsonKey(name: 'timestamp')
      required final DateTime timestamp}) = _$LiveLocationLogImpl;

  factory _LiveLocationLog.fromJson(Map<String, dynamic> json) =
      _$LiveLocationLogImpl.fromJson;

  @override
  String? get uid;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get address;
  @override
  @FirebaseTimestampConverter2()
  @JsonKey(name: 'timestamp')
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$LiveLocationLogImplCopyWith<_$LiveLocationLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
