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
        ledColor: colorBluePrimary2,
        playSound: true,
      ),
      NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'basic2',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        enableVibration: true,
        defaultColor: colorBluePrimary2,
        ledColor: colorBluePrimary2,
        playSound: true,
      ),
      NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'basic3',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        enableVibration: true,
        defaultColor: colorBluePrimary2,
        ledColor: colorBluePrimary2,
        playSound: true,
      ),
      NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'downloadedFile',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        enableVibration: true,
        // defaultColor: colorBluePrimary2,
        // ledColor: colorBluePrimary2,
        playSound: true,
      ),
      NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'downloadedImage',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        enableVibration: true,
        // defaultColor: colorBluePrimary2,
        // ledColor: colorBluePrimary2,
        playSound: true,
      ),
    ]);
  }

  Future showNotificationAbsen(datePresence) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          backgroundColor: colorBluePrimary2,
          color: colorBluePrimary2,
          //simgple notification
          id: 123,
          channelKey: 'basic', //set configuration wuth key "basic"
          title: 'Waktu kehadiran sedang berjalan.',
          body: 'Sentuh untuk pulang.',
          payload: {"datepresence": datePresence.toString()},
          autoDismissible: false,
          displayOnBackground: true,
          displayOnForeground: true,
          locked: true,
        ),
        // schedule: NotificationAndroidCrontab.hourly(
        //     referenceDateTime: referenceDateTime),
        actionButtons: [
          NotificationActionButton(
              key: "open",
              label: "Pulang Sekarang",
              color: colorBluePrimary2,
              autoDismissible: false,
              isDangerousOption: false),
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
          channelKey: 'basic2', //set configuration wuth key "basic"
          title: 'Waktu kehadiran telah berhenti.',
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
              key: "open", label: "Buka Aplikasi", color: colorBluePrimary2),
        ]);
  }

  Future showNotificationAfter12Hours(datePresence) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          backgroundColor: colorBluePrimary2,
          color: colorBluePrimary2,
          //simgple notification
          id: 543,
          channelKey: 'basic3', //set configuration wuth key "basic"
          title: 'Waktu kehadiran melebihi 12 jam.',
          body: 'Anda ingin pulang?',
          payload: {"datepresence": datePresence.toString()},
          // autoDismissible: false,
          displayOnBackground: true,
          displayOnForeground: true,
          // locked: true,
        ),
        actionButtons: [
          NotificationActionButton(
              key: "pulang", label: "Pulang", color: colorBluePrimary2),
          NotificationActionButton(
            key: "close",
            label: "Abaikan",
            color: colorBluePrimary2,
            autoDismissible: true,
            buttonType: ActionButtonType.DisabledAction,
            // isDangerousOption: true,
          ),
        ],
        schedule: NotificationCalendar.fromDate(
            date: DateTime.now().add(const Duration(hours: 12))));
  }

  Future showNotificationDownloadedFile(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      String? path}) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        // backgroundColor: colorBluePrimary2,
        // color: colorBluePrimary2,
        //simgple notification
        id: 329,
        channelKey: 'downloadedFile', //set configuration wuth key "basic"
        title: "Dokumen tersimpan",
        body: "Sentuh untuk membuka dokumen",
        icon: "resource://drawable/hora",
        payload: {"path": path.toString()},
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
          label: "Hapus",
          color: colorBluePrimary2,
          autoDismissible: true,
        ),
      ],
    );
  }

  Future showNotificationCapture(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      String? path}) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        //simgple notification
        id: 326,
        channelKey: 'downloadedImage', //set configuration wuth key "basic"
        title: "Tangkapan layar tersimpan",
        body: "Sentuh untuk membuka galeri",
        payload: {"path": path.toString()},
        // autoDismissible: false,
        displayOnBackground: true,
        icon: "resource://drawable/hora",
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
          label: "Hapus",
          color: colorBluePrimary2,
          autoDismissible: true,
        ),
      ],
    );
  }

  Future<void> removeNotification() async {
    await AwesomeNotifications().cancelAll();
  }
}
