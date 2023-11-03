// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_tracking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LiveTracking _$LiveTrackingFromJson(Map<String, dynamic> json) {
  return _LiveTracking.fromJson(json);
}

/// @nodoc
mixin _$LiveTracking {
  String? get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcaster_id')
  String get broadcasterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'listener_id')
  String get listenerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'request_approved')
  bool get requestApproved => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @FirebaseTimestampConverter()
  @JsonKey(name: 'last_update')
  DateTime? get lastUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiveTrackingCopyWith<LiveTracking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveTrackingCopyWith<$Res> {
  factory $LiveTrackingCopyWith(
          LiveTracking value, $Res Function(LiveTracking) then) =
      _$LiveTrackingCopyWithImpl<$Res, LiveTracking>;
  @useResult
  $Res call(
      {String? uid,
      @JsonKey(name: 'broadcaster_id') String broadcasterId,
      @JsonKey(name: 'listener_id') String listenerId,
      @JsonKey(name: 'request_approved') bool requestApproved,
      double? latitude,
      double? longitude,
      @FirebaseTimestampConverter()
      @JsonKey(name: 'last_update')
      DateTime? lastUpdate});
}

/// @nodoc
class _$LiveTrackingCopyWithImpl<$Res, $Val extends LiveTracking>
    implements $LiveTrackingCopyWith<$Res> {
  _$LiveTrackingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? broadcasterId = null,
    Object? listenerId = null,
    Object? requestApproved = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? lastUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      broadcasterId: null == broadcasterId
          ? _value.broadcasterId
          : broadcasterId // ignore: cast_nullable_to_non_nullable
              as String,
      listenerId: null == listenerId
          ? _value.listenerId
          : listenerId // ignore: cast_nullable_to_non_nullable
              as String,
      requestApproved: null == requestApproved
          ? _value.requestApproved
          : requestApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveTrackingImplCopyWith<$Res>
    implements $LiveTrackingCopyWith<$Res> {
  factory _$$LiveTrackingImplCopyWith(
          _$LiveTrackingImpl value, $Res Function(_$LiveTrackingImpl) then) =
      __$$LiveTrackingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      @JsonKey(name: 'broadcaster_id') String broadcasterId,
      @JsonKey(name: 'listener_id') String listenerId,
      @JsonKey(name: 'request_approved') bool requestApproved,
      double? latitude,
      double? longitude,
      @FirebaseTimestampConverter()
      @JsonKey(name: 'last_update')
      DateTime? lastUpdate});
}

/// @nodoc
class __$$LiveTrackingImplCopyWithImpl<$Res>
    extends _$LiveTrackingCopyWithImpl<$Res, _$LiveTrackingImpl>
    implements _$$LiveTrackingImplCopyWith<$Res> {
  __$$LiveTrackingImplCopyWithImpl(
      _$LiveTrackingImpl _value, $Res Function(_$LiveTrackingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? broadcasterId = null,
    Object? listenerId = null,
    Object? requestApproved = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? lastUpdate = freezed,
  }) {
    return _then(_$LiveTrackingImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      broadcasterId: null == broadcasterId
          ? _value.broadcasterId
          : broadcasterId // ignore: cast_nullable_to_non_nullable
              as String,
      listenerId: null == listenerId
          ? _value.listenerId
          : listenerId // ignore: cast_nullable_to_non_nullable
              as String,
      requestApproved: null == requestApproved
          ? _value.requestApproved
          : requestApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveTrackingImpl implements _LiveTracking {
  const _$LiveTrackingImpl(
      {this.uid,
      @JsonKey(name: 'broadcaster_id') required this.broadcasterId,
      @JsonKey(name: 'listener_id') required this.listenerId,
      @JsonKey(name: 'request_approved') this.requestApproved = false,
      this.latitude,
      this.longitude,
      @FirebaseTimestampConverter()
      @JsonKey(name: 'last_update')
      this.lastUpdate});

  factory _$LiveTrackingImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveTrackingImplFromJson(json);

  @override
  final String? uid;
  @override
  @JsonKey(name: 'broadcaster_id')
  final String broadcasterId;
  @override
  @JsonKey(name: 'listener_id')
  final String listenerId;
  @override
  @JsonKey(name: 'request_approved')
  final bool requestApproved;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @FirebaseTimestampConverter()
  @JsonKey(name: 'last_update')
  final DateTime? lastUpdate;

  @override
  String toString() {
    return 'LiveTracking(uid: $uid, broadcasterId: $broadcasterId, listenerId: $listenerId, requestApproved: $requestApproved, latitude: $latitude, longitude: $longitude, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveTrackingImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.broadcasterId, broadcasterId) ||
                other.broadcasterId == broadcasterId) &&
            (identical(other.listenerId, listenerId) ||
                other.listenerId == listenerId) &&
            (identical(other.requestApproved, requestApproved) ||
                other.requestApproved == requestApproved) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, broadcasterId, listenerId,
      requestApproved, latitude, longitude, lastUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveTrackingImplCopyWith<_$LiveTrackingImpl> get copyWith =>
      __$$LiveTrackingImplCopyWithImpl<_$LiveTrackingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveTrackingImplToJson(
      this,
    );
  }
}

abstract class _LiveTracking implements LiveTracking {
  const factory _LiveTracking(
      {final String? uid,
      @JsonKey(name: 'broadcaster_id') required final String broadcasterId,
      @JsonKey(name: 'listener_id') required final String listenerId,
      @JsonKey(name: 'request_approved') final bool requestApproved,
      final double? latitude,
      final double? longitude,
      @FirebaseTimestampConverter()
      @JsonKey(name: 'last_update')
      final DateTime? lastUpdate}) = _$LiveTrackingImpl;

  factory _LiveTracking.fromJson(Map<String, dynamic> json) =
      _$LiveTrackingImpl.fromJson;

  @override
  String? get uid;
  @override
  @JsonKey(name: 'broadcaster_id')
  String get broadcasterId;
  @override
  @JsonKey(name: 'listener_id')
  String get listenerId;
  @override
  @JsonKey(name: 'request_approved')
  bool get requestApproved;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @FirebaseTimestampConverter()
  @JsonKey(name: 'last_update')
  DateTime? get lastUpdate;
  @override
  @JsonKey(ignore: true)
  _$$LiveTrackingImplCopyWith<_$LiveTrackingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
