import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';
import 'package:app/data/local/base_preference.dart';

// import 'package:app/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
// import 'dart:async';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() async {
  // runZonedGuarded(() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // FlutterNativeSplash.preserve(widgetsBinding: binding);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final GoogleMapsFlutterPlatform mapsImplementation =
  //     GoogleMapsFlutterPlatform.instance;
  // if (mapsImplementation is GoogleMapsFlutterAndroid) {
  //   mapsImplementation.useAndroidViewSurface = true;
  // }
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  // await Permission.location.serviceStatus.isEnabled.then((value) {
  //   if (value) {
  //     Permission.location.request();
  //   }
  // });

  await GetStorage.init();
  await BasePreference.init();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  AwesomeNotificationService().initNotification();

  AwesomeNotifications().actionStream.listen((action) {
    print("CHANEL KEY: " + action.channelKey.toString());
    if (action.channelKey == "basic" && action.buttonKeyPressed == "open") {
      var homeCtrl = Get.put(HomeController());
      var currentAbsen = homeCtrl.absen?.firstWhere(
        (element) =>
            element['idkaryawan'] == homeCtrl.user?['idkaryawan'] &&
            element?["waktuCheckOut"] == null,
        orElse: () => null,
      );
      // Get.back();
      Get.toNamed(RouteName.absen, arguments: {"dataAbsen": currentAbsen});
      print("Open button is pressed");
    } else if (action.buttonKeyPressed == "close") {
      AwesomeNotifications().cancelAll();
    } else if (action.channelKey == "basic") {
      var homeCtrl = Get.put(HomeController());
      var currentAbsen = homeCtrl.absen?.firstWhere(
        (element) =>
            element['idkaryawan'] == homeCtrl.user?['idkaryawan'] &&
            element?["waktuCheckOut"] == null,
        orElse: () => null,
      );
      // Get.back();
      Get.toNamed(RouteName.absen, arguments: {"dataAbsen": currentAbsen});
    } else if (action.channelKey == "basic3") {
      var absenCtrl = Get.put(AbsenController());
      var homeCtrl = Get.put(HomeController());
      var currentAbsen = homeCtrl.absen?.firstWhere(
        (element) => element['idkaryawan'] == homeCtrl.user?['idkaryawan'],
        orElse: () => null,
      );
      Get.toNamed(RouteName.absen,
          arguments: {"dataAbsen": currentAbsen, "pulang": 1});
      absenCtrl.mulaiPulangFromNotif(currentAbsen);
    } else if (action.channelKey == "basic3" &&
        action.buttonKeyPressed == "pulang") {
      var absenCtrl = Get.put(AbsenController());
      var homeCtrl = Get.put(HomeController());
      var currentAbsen = homeCtrl.absen?.firstWhere(
        (element) => element['idkaryawan'] == homeCtrl.user?['idkaryawan'],
        orElse: () => null,
      );
      Get.toNamed(RouteName.absen,
          arguments: {"dataAbsen": currentAbsen, "pulang": 1});
      absenCtrl.mulaiPulangFromNotif(currentAbsen);
    } else {
      print("action.payload"); //notification was pressed
    }
  });
  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [Locale("id", "ID"), Locale("en", "US")],
      fallbackLocale: const Locale("id", "ID"),
      path: 'assets/lang',
      child: const MyApp(),
    ),
  ));
  // FlutterNativeSplash.remove();
  // }, (error, stack) {});
  // runApp(const MyApp());
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MainTheme.materialApp(context, child: SplashScreen());
  }
}
