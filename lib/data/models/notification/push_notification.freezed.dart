// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PushNotification _$PushNotificationFromJson(Map<String, dynamic> json) {
  return _PushNotification.fromJson(json);
}

/// @nodoc
mixin _$PushNotification {
  Notification get notification => throw _privateConstructorUsedError;
  Map<String, String> get data => throw _privateConstructorUsedError;
  Android? get android => throw _privateConstructorUsedError;
  String? get topic => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  List<String>? get tokens => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PushNotificationCopyWith<PushNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationCopyWith<$Res> {
  factory $PushNotificationCopyWith(
          PushNotification value, $Res Function(PushNotification) then) =
      _$PushNotificationCopyWithImpl<$Res, PushNotification>;
  @useResult
  $Res call(
      {Notification notification,
      Map<String, String> data,
      Android? android,
      String? topic,
      String? token,
      List<String>? tokens});

  $NotificationCopyWith<$Res> get notification;
  $AndroidCopyWith<$Res>? get android;
}

/// @nodoc
class _$PushNotificationCopyWithImpl<$Res, $Val extends PushNotification>
    implements $PushNotificationCopyWith<$Res> {
  _$PushNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notification = null,
    Object? data = null,
    Object? android = freezed,
    Object? topic = freezed,
    Object? token = freezed,
    Object? tokens = freezed,
  }) {
    return _then(_value.copyWith(
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as Notification,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      android: freezed == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as Android?,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      tokens: freezed == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NotificationCopyWith<$Res> get notification {
    return $NotificationCopyWith<$Res>(_value.notification, (value) {
      return _then(_value.copyWith(notification: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AndroidCopyWith<$Res>? get android {
    if (_value.android == null) {
      return null;
    }

    return $AndroidCopyWith<$Res>(_value.android!, (value) {
      return _then(_value.copyWith(android: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PushNotificationImplCopyWith<$Res>
    implements $PushNotificationCopyWith<$Res> {
  factory _$$PushNotificationImplCopyWith(_$PushNotificationImpl value,
          $Res Function(_$PushNotificationImpl) then) =
      __$$PushNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Notification notification,
      Map<String, String> data,
      Android? android,
      String? topic,
      String? token,
      List<String>? tokens});

  @override
  $NotificationCopyWith<$Res> get notification;
  @override
  $AndroidCopyWith<$Res>? get android;
}

/// @nodoc
class __$$PushNotificationImplCopyWithImpl<$Res>
    extends _$PushNotificationCopyWithImpl<$Res, _$PushNotificationImpl>
    implements _$$PushNotificationImplCopyWith<$Res> {
  __$$PushNotificationImplCopyWithImpl(_$PushNotificationImpl _value,
      $Res Function(_$PushNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notification = null,
    Object? data = null,
    Object? android = freezed,
    Object? topic = freezed,
    Object? token = freezed,
    Object? tokens = freezed,
  }) {
    return _then(_$PushNotificationImpl(
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as Notification,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      android: freezed == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as Android?,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      tokens: freezed == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushNotificationImpl implements _PushNotification {
  const _$PushNotificationImpl(
      {required this.notification,
      final Map<String, String> data = const {},
      this.android,
      this.topic,
      this.token,
      final List<String>? tokens})
      : assert(topic != null || token != null || tokens != null,
            'Select either topic/token/tokens'),
        _data = data,
        _tokens = tokens;

  factory _$PushNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushNotificationImplFromJson(json);

  @override
  final Notification notification;
  final Map<String, String> _data;
  @override
  @JsonKey()
  Map<String, String> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final Android? android;
  @override
  final String? topic;
  @override
  final String? token;
  final List<String>? _tokens;
  @override
  List<String>? get tokens {
    final value = _tokens;
    if (value == null) return null;
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PushNotification(notification: $notification, data: $data, android: $android, topic: $topic, token: $token, tokens: $tokens)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationImpl &&
            (identical(other.notification, notification) ||
                other.notification == notification) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.android, android) || other.android == android) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.token, token) || other.token == token) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notification,
      const DeepCollectionEquality().hash(_data),
      android,
      topic,
      token,
      const DeepCollectionEquality().hash(_tokens));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationImplCopyWith<_$PushNotificationImpl> get copyWith =>
      __$$PushNotificationImplCopyWithImpl<_$PushNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationImplToJson(
      this,
    );
  }
}

abstract class _PushNotification implements PushNotification {
  const factory _PushNotification(
      {required final Notification notification,
      final Map<String, String> data,
      final Android? android,
      final String? topic,
      final String? token,
      final List<String>? tokens}) = _$PushNotificationImpl;

  factory _PushNotification.fromJson(Map<String, dynamic> json) =
      _$PushNotificationImpl.fromJson;

  @override
  Notification get notification;
  @override
  Map<String, String> get data;
  @override
  Android? get android;
  @override
  String? get topic;
  @override
  String? get token;
  @override
  List<String>? get tokens;
  @override
  @JsonKey(ignore: true)
  _$$PushNotificationImplCopyWith<_$PushNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return _Notification.fromJson(json);
}

/// @nodoc
mixin _$Notification {
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationCopyWith<Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res, Notification>;
  @useResult
  $Res call({String title, String body});
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res, $Val extends Notification>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationImplCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$$NotificationImplCopyWith(
          _$NotificationImpl value, $Res Function(_$NotificationImpl) then) =
      __$$NotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String body});
}

/// @nodoc
class __$$NotificationImplCopyWithImpl<$Res>
    extends _$NotificationCopyWithImpl<$Res, _$NotificationImpl>
    implements _$$NotificationImplCopyWith<$Res> {
  __$$NotificationImplCopyWithImpl(
      _$NotificationImpl _value, $Res Function(_$NotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
  }) {
    return _then(_$NotificationImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationImpl implements _Notification {
  const _$NotificationImpl({required this.title, required this.body});

  factory _$NotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationImplFromJson(json);

  @override
  final String title;
  @override
  final String body;

  @override
  String toString() {
    return 'Notification(title: $title, body: $body)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, body);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      __$$NotificationImplCopyWithImpl<_$NotificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationImplToJson(
      this,
    );
  }
}

abstract class _Notification implements Notification {
  const factory _Notification(
      {required final String title,
      required final String body}) = _$NotificationImpl;

  factory _Notification.fromJson(Map<String, dynamic> json) =
      _$NotificationImpl.fromJson;

  @override
  String get title;
  @override
  String get body;
  @override
  @JsonKey(ignore: true)
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Android _$AndroidFromJson(Map<String, dynamic> json) {
  return _Android.fromJson(json);
}

/// @nodoc
mixin _$Android {
  String get priority => throw _privateConstructorUsedError;
  AndroidNotification? get notification => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AndroidCopyWith<Android> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidCopyWith<$Res> {
  factory $AndroidCopyWith(Android value, $Res Function(Android) then) =
      _$AndroidCopyWithImpl<$Res, Android>;
  @useResult
  $Res call({String priority, AndroidNotification? notification});

  $AndroidNotificationCopyWith<$Res>? get notification;
}

/// @nodoc
class _$AndroidCopyWithImpl<$Res, $Val extends Android>
    implements $AndroidCopyWith<$Res> {
  _$AndroidCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = null,
    Object? notification = freezed,
  }) {
    return _then(_value.copyWith(
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      notification: freezed == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as AndroidNotification?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AndroidNotificationCopyWith<$Res>? get notification {
    if (_value.notification == null) {
      return null;
    }

    return $AndroidNotificationCopyWith<$Res>(_value.notification!, (value) {
      return _then(_value.copyWith(notification: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AndroidImplCopyWith<$Res> implements $AndroidCopyWith<$Res> {
  factory _$$AndroidImplCopyWith(
          _$AndroidImpl value, $Res Function(_$AndroidImpl) then) =
      __$$AndroidImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String priority, AndroidNotification? notification});

  @override
  $AndroidNotificationCopyWith<$Res>? get notification;
}

/// @nodoc
class __$$AndroidImplCopyWithImpl<$Res>
    extends _$AndroidCopyWithImpl<$Res, _$AndroidImpl>
    implements _$$AndroidImplCopyWith<$Res> {
  __$$AndroidImplCopyWithImpl(
      _$AndroidImpl _value, $Res Function(_$AndroidImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = null,
    Object? notification = freezed,
  }) {
    return _then(_$AndroidImpl(
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      notification: freezed == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as AndroidNotification?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AndroidImpl implements _Android {
  const _$AndroidImpl({this.priority = 'high', this.notification});

  factory _$AndroidImpl.fromJson(Map<String, dynamic> json) =>
      _$$AndroidImplFromJson(json);

  @override
  @JsonKey()
  final String priority;
  @override
  final AndroidNotification? notification;

  @override
  String toString() {
    return 'Android(priority: $priority, notification: $notification)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AndroidImpl &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.notification, notification) ||
                other.notification == notification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, priority, notification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AndroidImplCopyWith<_$AndroidImpl> get copyWith =>
      __$$AndroidImplCopyWithImpl<_$AndroidImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AndroidImplToJson(
      this,
    );
  }
}

abstract class _Android implements Android {
  const factory _Android(
      {final String priority,
      final AndroidNotification? notification}) = _$AndroidImpl;

  factory _Android.fromJson(Map<String, dynamic> json) = _$AndroidImpl.fromJson;

  @override
  String get priority;
  @override
  AndroidNotification? get notification;
  @override
  @JsonKey(ignore: true)
  _$$AndroidImplCopyWith<_$AndroidImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AndroidNotification _$AndroidNotificationFromJson(Map<String, dynamic> json) {
  return _AndroidNotification.fromJson(json);
}

/// @nodoc
mixin _$AndroidNotification {
  String? get tag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AndroidNotificationCopyWith<AndroidNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidNotificationCopyWith<$Res> {
  factory $AndroidNotificationCopyWith(
          AndroidNotification value, $Res Function(AndroidNotification) then) =
      _$AndroidNotificationCopyWithImpl<$Res, AndroidNotification>;
  @useResult
  $Res call({String? tag});
}

/// @nodoc
class _$AndroidNotificationCopyWithImpl<$Res, $Val extends AndroidNotification>
    implements $AndroidNotificationCopyWith<$Res> {
  _$AndroidNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag = freezed,
  }) {
    return _then(_value.copyWith(
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AndroidNotificationImplCopyWith<$Res>
    implements $AndroidNotificationCopyWith<$Res> {
  factory _$$AndroidNotificationImplCopyWith(_$AndroidNotificationImpl value,
          $Res Function(_$AndroidNotificationImpl) then) =
      __$$AndroidNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? tag});
}

/// @nodoc
class __$$AndroidNotificationImplCopyWithImpl<$Res>
    extends _$AndroidNotificationCopyWithImpl<$Res, _$AndroidNotificationImpl>
    implements _$$AndroidNotificationImplCopyWith<$Res> {
  __$$AndroidNotificationImplCopyWithImpl(_$AndroidNotificationImpl _value,
      $Res Function(_$AndroidNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag = freezed,
  }) {
    return _then(_$AndroidNotificationImpl(
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AndroidNotificationImpl implements _AndroidNotification {
  const _$AndroidNotificationImpl({this.tag});

  factory _$AndroidNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AndroidNotificationImplFromJson(json);

  @override
  final String? tag;

  @override
  String toString() {
    return 'AndroidNotification(tag: $tag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AndroidNotificationImpl &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AndroidNotificationImplCopyWith<_$AndroidNotificationImpl> get copyWith =>
      __$$AndroidNotificationImplCopyWithImpl<_$AndroidNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AndroidNotificationImplToJson(
      this,
    );
  }
}

abstract class _AndroidNotification implements AndroidNotification {
  const factory _AndroidNotification({final String? tag}) =
      _$AndroidNotificationImpl;

  factory _AndroidNotification.fromJson(Map<String, dynamic> json) =
      _$AndroidNotificationImpl.fromJson;

  @override
  String? get tag;
  @override
  @JsonKey(ignore: true)
  _$$AndroidNotificationImplCopyWith<_$AndroidNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
