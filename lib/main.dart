import 'package:app/global_resource.dart';
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
  await GetStorage.init();
  await BasePreference.init();
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
    return MainTheme.materialApp(context, child: SplashScreen());
  }
}
