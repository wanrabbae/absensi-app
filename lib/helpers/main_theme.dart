import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/dialogs.dart';
import 'package:app/services/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _MainAppState extends State<MainApp> {
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
          _handleMessageOpen(message);
        }
      });

      _streamSubscriptionForeground =
          pn.foregroundMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          final data = message.data;
          final tag = data['tag'];
          final broadcasterId = data['broadcaster_id'];
          final listenerId = data['listener_id'];

          if (tag is String ||
              broadcasterId is String ||
              listenerId is String) {
            if (tag.startsWith('REQUEST_LIVE_TRACKING')) {
              _requestLiveTracking(notification, broadcasterId, listenerId);
              return;
            }
          }

          pn.showLocalNotification(
            notification,
            message: message,
            image: _imageNotification(message.data),
          );
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
  }

  @override
  void dispose() {
    _streamSubscriptionForeground?.cancel();
    _streamSubscriptionMessageClick?.cancel();
    _streamSubscriptionLocalMessageClick?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainTheme.materialApp(context, child: const SplashScreen());
  }

  _handleMessageOpen(RemoteMessage message) {
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
      return;
    }

    if (tag.startsWith('REQUEST_LIVE_TRACKING')) {
      _requestLiveTracking(notification, broadcasterId, listenerId);
      return;
    }

    if (tag.startsWith('REJECT_REQUEST_LIVE_TRACKING')) {
      customSnackbar1('Permintaan lokasi terkirim');
      context.read<AppCubit>().requestLiveTracking(broadcasterId);
      return;
    }

    if (tag.startsWith('APPROVE_REQUEST_LIVE_TRACKING')) {
      // do nothing
      return;
    }
  }

  _requestLiveTracking(
    RemoteNotification notification,
    String broadcasterId,
    String listenerId,
  ) {
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
      context
          .read<AppCubit>()
          .setLiveTracking(broadcasterId, listenerId, approve);
    });
  }
}

String? _imageNotification(Map<String, dynamic> data) {
  try {
    final map = jsonDecode(data['data'] ?? '{}');
    return map['image'] as String?;
  } catch (_) {}
  return null;
}
