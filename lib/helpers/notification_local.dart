import 'package:app/global_resource.dart';
import 'package:app/services/push_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

const AndroidNotificationChannel _kBasicChannel = AndroidNotificationChannel(
  'hora_basic_channel',
  'Hora Basic Notifications',
  description: 'This channel is used for Hora basic notifications.',
  importance: Importance.max,
  playSound: true,
  ledColor: colorBluePrimary2,
  enableVibration: true,
  showBadge: true,
);

class AwesomeNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      $it<PushNotificationService>().local;

  Future<void> showNotificationAbsen(String datePresence) {
    return notificationsPlugin.show(
      123,
      'Sedang mengisi kehadiran',
      'Sentuh untuk membuka',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _kBasicChannel.id,
          _kBasicChannel.name,
          autoCancel: false,
          ongoing: true,
          color: colorBluePrimary2,
          importance: Importance.max,
          priority: Priority.max,
          actions: [
            const AndroidNotificationAction(
              'open',
              'Buka Aplikasi',
              titleColor: colorBluePrimary2,
              cancelNotification: false,
            ),
          ],
        ),
      ),
      payload: jsonEncode({
        'datepresence': datePresence,
        'tag': 'OPEN_PRESENCE_DATE',
      }),
    );
  }

  Future<void> showNotificationAbsenDone() {
    return notificationsPlugin.show(
      321,
      'Kehadiran dihentikan',
      'Sentuh untuk membuka',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _kBasicChannel.id,
          _kBasicChannel.name,
          color: colorBluePrimary2,
          importance: Importance.max,
          priority: Priority.max,
          actions: [
            const AndroidNotificationAction(
              'open',
              'Buka Aplikasi',
              titleColor: colorBluePrimary2,
              cancelNotification: false,
            ),
          ],
        ),
      ),
      payload: jsonEncode({
        'tag': 'PRESENCE_STOPPED',
      }),
    );
  }

  Future<void> showNotificationAfter12Hours(String datePresence) async {
    return notificationsPlugin.zonedSchedule(
      543,
      'Kehadiran melebihi 12 jam',
      'Hentikan kehadiran?',
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 12)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _kBasicChannel.id,
          _kBasicChannel.name,
          color: colorBluePrimary2,
          importance: Importance.max,
          priority: Priority.max,
          actions: [
            const AndroidNotificationAction(
              'pulang',
              'Hentikan',
              titleColor: colorBluePrimary2,
              cancelNotification: false,
              showsUserInterface: true,
            ),
            const AndroidNotificationAction(
              'close',
              'Abaikan',
              titleColor: colorBluePrimary2,
              cancelNotification: true,
              showsUserInterface: false,
            ),
          ],
        ),
      ),
      payload: jsonEncode({
        'datepresence': datePresence,
        'tag': 'PRESENCE_AFTER_12H',
      }),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showNotificationDownloadedFile({
    required String path,
  }) {
    return notificationsPlugin.show(
      329,
      'Dokumen tersimpan',
      'Sentuh untuk membuka',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _kBasicChannel.id,
          _kBasicChannel.name,
          color: colorBluePrimary2,
          importance: Importance.max,
          priority: Priority.max,
          actions: [
            const AndroidNotificationAction(
              'open',
              'Buka',
              titleColor: colorBluePrimary2,
              cancelNotification: false,
              showsUserInterface: true,
            ),
            const AndroidNotificationAction(
              'close',
              'Hapus',
              titleColor: colorBluePrimary2,
              cancelNotification: true,
              showsUserInterface: false,
            ),
          ],
        ),
      ),
      payload: jsonEncode({
        'tag': 'DOWNLOAD_FILE',
        'path': path,
      }),
    );
  }

  Future showNotificationCapture({
    required String path,
  }) async {
    notificationsPlugin.show(
      326,
      'Tangkapan layar tersimpan',
      'Sentuh untuk membuka',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _kBasicChannel.id,
          _kBasicChannel.name,
          color: colorBluePrimary2,
          importance: Importance.max,
          priority: Priority.max,
          actions: [
            const AndroidNotificationAction(
              'open',
              'Buka',
              titleColor: colorBluePrimary2,
              cancelNotification: false,
              showsUserInterface: true,
            ),
            const AndroidNotificationAction(
              'close',
              'Hapus',
              titleColor: colorBluePrimary2,
              cancelNotification: true,
              showsUserInterface: false,
            ),
          ],
        ),
      ),
      payload: jsonEncode({
        'tag': 'DOWNLOAD_IMAGE',
        'path': path,
      }),
    );
  }

  Future<void> removeNotification() {
    return notificationsPlugin.cancelAll();
  }

  Future<void> removeNotificationById(id) {
    return notificationsPlugin.cancel(id);
  }

  Future<void> removeNotificationUnUsed() {
    return Future.wait([
      notificationsPlugin.cancel(329),
      notificationsPlugin.cancel(326),
      notificationsPlugin.cancel(543),
      notificationsPlugin.cancel(321),
    ]);
  }
}
