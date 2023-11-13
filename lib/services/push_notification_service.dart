import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

const AndroidNotificationChannel _kChannel = AndroidNotificationChannel(
  'hora_importance_channel', // id
  'Hora Importance Notifications', // title
  description: 'This channel is used for Hora important notifications.',
  // description
  importance: Importance.max,
);

class PushNotificationService {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  NotificationSettings? _settings;

  Future<void> requestPermission() async {
    _settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_kChannel);
  }

  Future<String?> getToken() => _messaging.getToken();

  NotificationSettings? get settings => _settings;

  Stream<String> onTokenRefresh() => _messaging.onTokenRefresh;

  Future<void> subscribeTopic(String topic) =>
      _messaging.subscribeToTopic(topic);

  Future<void> unSubscribeTopic(String topic) =>
      _messaging.unsubscribeFromTopic(topic);

  static void backgroundMessage(BackgroundMessageHandler handler) =>
      FirebaseMessaging.onBackgroundMessage(handler);

  Future<RemoteMessage?> get initialMessage => _messaging.getInitialMessage();

  Stream<RemoteMessage> get foregroundMessage => FirebaseMessaging.onMessage;

  Stream<RemoteMessage> get messageOpened =>
      FirebaseMessaging.onMessageOpenedApp;

  final StreamController<RemoteMessage?> selectNotificationStream =
      StreamController<RemoteMessage?>.broadcast();

  void initializeLocalNotification() async {
    if (!Platform.isAndroid) return;
    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.payload is String) {
            final map = jsonDecode(notificationResponse.payload!);
            final message = RemoteMessage.fromMap(map);
            selectNotificationStream.add(message);
          }
          break;
      }
    });
  }

  Future<BigPictureStyleInformation?> _getImageNotification(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final bigPictureStyleInformation = BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(response.bodyBytes)));
      return bigPictureStyleInformation;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  showLocalNotification(
    RemoteNotification notification, {
    required RemoteMessage message,
    String? image,
  }) async {
    _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _kChannel.id,
          _kChannel.name,
          channelDescription: _kChannel.description,
          icon: 'ic_launcher',
          styleInformation: image != null
              ? await _getImageNotification(image.toString())
              : const BigTextStyleInformation(''),
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
  }
}
