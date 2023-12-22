import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_notification.freezed.dart';

part 'push_notification.g.dart';

@freezed
class PushNotification with _$PushNotification {
  @Assert(
    'topic != null || token != null || tokens != null || karyawanIds != null',
    'Select either topic/token/tokens/karyawanIds',
  )
  const factory PushNotification({
    required Notification notification,
    @Default({}) Map<String, String> data,
    Android? android,
    String? topic,
    String? token,
    List<String>? tokens,
    @JsonKey(name: 'karyawan_ids') List<String>? karyawanIds,
  }) = _PushNotification;

  factory PushNotification.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationFromJson(json);
}

@freezed
class Notification with _$Notification {
  const factory Notification({
    required String title,
    required String body,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

@freezed
class Android with _$Android {
  const factory Android({
    @Default('high') String priority,
    AndroidNotification? notification,
  }) = _Android;

  factory Android.fromJson(Map<String, dynamic> json) =>
      _$AndroidFromJson(json);
}

@freezed
class AndroidNotification with _$AndroidNotification {
  const factory AndroidNotification({
    String? tag,
  }) = _AndroidNotification;

  factory AndroidNotification.fromJson(Map<String, dynamic> json) =>
      _$AndroidNotificationFromJson(json);
}
