import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/dialogs.dart';
import 'package:app/services/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_local.dart';

const InputDecorationTheme _kInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorBluePrimary, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.redAccent, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorBluePrimary, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorBluePrimary, width: 2),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorGrayPrimary, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorGrayPrimary, width: 2),
  ),
);

class MainTheme {
  const MainTheme._();

  static GetMaterialApp materialApp(
    BuildContext context, {
    required Widget child,
  }) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      title: "Hora",
      getPages: Routes.pages,
      theme: _buildTheme(),
      darkTheme: _buildTheme(),
      home: SafeArea(
        bottom: false,
        top: false,
        child: child,
      ),
    );
  }

  static ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      inputDecorationTheme: _kInputDecorationTheme,
      fontFamily: kGlobalFontFamily,
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  StreamSubscription<RemoteMessage>? _streamSubscriptionForeground;
  StreamSubscription<RemoteMessage>? _streamSubscriptionMessageClick;
  StreamSubscription<RemoteMessage?>? _streamSubscriptionLocalMessageClick;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final pn = $it<PushNotificationService>();

      pn.initialMessage.then((RemoteMessage? message) {
        if (message != null) {
          _handleMessageOpen(message, foreground: true);
        }
      });

      _streamSubscriptionForeground =
          pn.foregroundMessage.listen((RemoteMessage message) {
            debugPrint('RECEIVED NOTIF : ${jsonEncode(message.toMap())}');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? ios = message.notification?.apple;

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && (android != null || ios != null)) {
          _handleMessageOpen(message, foreground: true);
        }
      });

      _streamSubscriptionMessageClick =
          pn.messageOpened.listen((message) => _handleMessageOpen(message));

      _streamSubscriptionLocalMessageClick =
          pn.selectNotificationStream.stream.listen((remoteMessage) {
        if (remoteMessage != null) {
          _handleMessageOpen(remoteMessage);
        }
      });
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.resumed:
        FlutterAppBadger.updateBadgeCount(1);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        // do nothing
        break;
    }
  }

  @override
  void dispose() {
    _streamSubscriptionForeground?.cancel();
    _streamSubscriptionMessageClick?.cancel();
    _streamSubscriptionLocalMessageClick?.cancel();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AwesomeNotificationService().removeNotificationUnUsed();
    FlutterAppBadger.removeBadge();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MainTheme.materialApp(context, child: const SplashScreen());
  }

  _handleMessageOpen(RemoteMessage message, {bool foreground = false}) {
    final context = Get.context;
    if (context == null) return;

    final notification = message.notification;
    final data = message.data;
    final tag = data['tag'];
    final broadcasterId = data['broadcaster_id'];
    final listenerId = data['listener_id'];

    if (notification == null ||
        tag is! String ||
        broadcasterId is! String ||
        listenerId is! String) {
      if (foreground) {
        _showLocalNotification(message);
      }
      return;
    }

    if (tag.startsWith('REQUEST_LIVE_TRACKING')) {
      _requestLiveTracking(notification, broadcasterId, listenerId);
      return;
    }

    if (tag.startsWith('REJECT_REQUEST_LIVE_TRACKING')) {
      if (foreground) {
        customSnackbar1('Permintaan lokasi ditolak');
      } else {
        customSnackbar1('Permintaan lokasi terkirim');
        context.read<AppCubit>().requestLiveTracking(broadcasterId);
      }
      return;
    }

    if (tag.startsWith('APPROVE_REQUEST_LIVE_TRACKING')) {
      customSnackbar1('Permintaan lokasi diterima');
      return;
    }

    if (tag.startsWith('STOP_REQUEST_LIVE_TRACKING')) {
      customSnackbar1('Permintaan lokasi dihentikan');
      return;
    }
  }

  _requestLiveTracking(
    RemoteNotification notification,
    String broadcasterId,
    String listenerId,
  ) {
    final context = Get.context;
    if (context == null) return;
    showConfirmationDialog(
      context,
      notification.title!,
      notification.body!,
      buttonCancel: 'Tolak',
      buttonOk: 'Terima',
    ).then((approve) {
      if (approve == null) return;

      customSnackbar1(
        approve ? 'Menerima permintaan lokasi' : 'Menolak permintaan lokasi',
      );

      if (approve) {
        Geolocator.getCurrentPosition().then((Position position) {
          context.read<AppCubit>().setLiveTracking(
                broadcasterId,
                listenerId,
                approve,
                position.latitude,
                position.longitude,
              );
        });
      } else {
        context.read<AppCubit>().setLiveTracking(
          broadcasterId,
          listenerId,
          approve,
        );
      }
    });
  }

  _showLocalNotification(RemoteMessage message) {
    final pn = $it<PushNotificationService>();
    final notification = message.notification;
    if (notification == null) return;
    pn.showLocalNotification(
      notification,
      message: message,
      image: _imageNotification(message.data),
    );
  }
}

String? _imageNotification(Map<String, dynamic> data) {
  try {
    final map = jsonDecode(data['data'] ?? '{}');
    return map['image'] as String?;
  } catch (_) {}
  return null;
}
