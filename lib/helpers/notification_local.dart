import 'package:app/global_resource.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, autoCancel: false, ongoing: true),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future<void> removeNotification() async {
    await notificationsPlugin.cancelAll();
  }
}

class AwesomeNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initNotification() async {
    AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
      // notification icon
      NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'basic',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        enableVibration: true,
        defaultColor: colorBluePrimary2,
        ledColor: Colors.white,
        playSound: true,
      ),
    ]);
  }

  Future showNotificationAbsen(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          backgroundColor: colorBluePrimary2,
          color: colorBluePrimary2,
          //simgple notification
          id: 123,
          channelKey: 'basic', //set configuration wuth key "basic"
          title: 'Waktu kehadiran sedang berjalan. (${timerAbsen()})',
          body: 'Sentuh untuk membuka aplikasi.',
          payload: {"name": "FlutterCampus"},
          autoDismissible: false,
          displayOnBackground: true,
          displayOnForeground: true,
          locked: true,
        ),
        // schedule: NotificationAndroidCrontab.hourly(
        //     referenceDateTime: referenceDateTime),
        actionButtons: [
          NotificationActionButton(
              key: "open", label: "Buka Aplikasi", color: colorBluePrimary2),
        ]);
  }

  Future showNotificationAbsenDone(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          backgroundColor: colorBluePrimary2,
          color: colorBluePrimary2,
          //simgple notification
          id: 321,
          channelKey: 'basic', //set configuration wuth key "basic"
          title: 'Waktu kehadiran berhenti otomatis.',
          body: 'Sentuh untuk membuka aplikasi.',
          payload: {"name": "FlutterCampus"},
          // autoDismissible: false,
          displayOnBackground: true,
          displayOnForeground: true,
          // locked: true,
        ),
        // schedule: NotificationAndroidCrontab.hourly(
        //     referenceDateTime: referenceDateTime),
        actionButtons: [
          NotificationActionButton(
              key: "open", label: "Buka", color: colorBluePrimary2),
          NotificationActionButton(
            key: "close",
            label: "Abaikan",
            color: colorBluePrimary2,
            autoDismissible: true,
            buttonType: ActionButtonType.DisabledAction,
            // isDangerousOption: true,
          ),
        ]);
  }

  Future<void> removeNotification() async {
    await AwesomeNotifications().cancelAll();
  }
}
