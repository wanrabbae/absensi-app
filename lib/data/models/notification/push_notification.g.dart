// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PushNotificationImpl _$$PushNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationImpl(
      notification:
          Notification.fromJson(json['notification'] as Map<String, dynamic>),
      data: (json['data'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      android: json['android'] == null
          ? null
          : Android.fromJson(json['android'] as Map<String, dynamic>),
      topic: json['topic'] as String?,
      token: json['token'] as String?,
      tokens:
          (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PushNotificationImplToJson(
    _$PushNotificationImpl instance) {
  final val = <String, dynamic>{
    'notification': instance.notification.toJson(),
    'data': instance.data,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('android', instance.android?.toJson());
  writeNotNull('topic', instance.topic);
  writeNotNull('token', instance.token);
  writeNotNull('tokens', instance.tokens);
  return val;
}

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };

_$AndroidImpl _$$AndroidImplFromJson(Map<String, dynamic> json) =>
    _$AndroidImpl(
      priority: json['priority'] as String? ?? 'high',
      notification: json['notification'] == null
          ? null
          : AndroidNotification.fromJson(
              json['notification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AndroidImplToJson(_$AndroidImpl instance) {
  final val = <String, dynamic>{
    'priority': instance.priority,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('notification', instance.notification?.toJson());
  return val;
}

_$AndroidNotificationImpl _$$AndroidNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$AndroidNotificationImpl(
      tag: json['tag'] as String?,
    );

Map<String, dynamic> _$$AndroidNotificationImplToJson(
    _$AndroidNotificationImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tag', instance.tag);
  return val;
}
