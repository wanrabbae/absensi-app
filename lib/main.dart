import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/data/local/base_preference.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file_plus/open_file_plus.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  await GetStorage.init();
  await BasePreference.init();

  AwesomeNotificationService().initNotification();
  AwesomeNotifications().actionStream.listen((action) async {
    if (action.channelKey == "basic") {
      Get.put(HomeController());
      var tanggal = action.payload?["datepresence"]?.split(" ")[0];

      Get.offAndToNamed(RouteName.home, arguments: tanggal);
      return;
    }

    if (action.buttonKeyPressed == "close") {
      AwesomeNotifications().cancelAll();
      return;
    }

    if (action.channelKey == "basic3" && action.buttonKeyPressed == "pulang") {
      var homeCtrl = Get.put(HomeController());
      var tanggal = action.payload?["datepresence"]?.split(" ")[0];

      var response = await AbsensiServices()
          .findIndiv(homeCtrl.user?["idkaryawan"], tanggal);
      Get.toNamed(RouteName.absen, arguments: {"dataAbsen": response.data?[0]});
      return;
    }

    if (action.channelKey == "basic3") {
      var homeCtrl = Get.put(HomeController());
      var tanggal = action.payload?["datepresence"]?.split(" ")[0];

      var response = await AbsensiServices()
          .findIndiv(homeCtrl.user?["idkaryawan"], tanggal);
      Get.toNamed(RouteName.absen, arguments: {"dataAbsen": response.data?[0]});
      return;
    }

    if (action.channelKey == "downloadedFile" &&
        action.buttonKeyPressed == "open") {
      OpenFile.open(action.payload?["path"]);
      return;
    }

    if (action.channelKey == "downloadedFile") {
      OpenFile.open(action.payload?["path"]);
      return;
    }

    if (action.channelKey == "downloadedImage" &&
        action.buttonKeyPressed == "open") {
      OpenFile.open(action.payload?["path"]);
      return;
    }

    if (action.channelKey == "downloadedImage") {
      OpenFile.open(action.payload?["path"]);
      return;
    }
  });
  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [Locale("id", "ID"), Locale("en", "US")],
      fallbackLocale: const Locale("id", "ID"),
      path: 'assets/lang',
      child: BlocProvider(
        create: (context) => AppCubit($it(), $it(), $it(), $it(), $it()),
        child: const MyApp(),
      ),
    ),
  ));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AwesomeNotificationService().removeNotificationUnUsed();
    FlutterAppBadger.removeBadge();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return const MainApp();
  }
}
