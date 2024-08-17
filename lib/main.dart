import 'package:app/presentation/blocs/app/app_cubit.dart';
import 'package:app/data/local/base_preference.dart';
import 'package:app/data/source/firebase/firebase_service.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/global_resource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await initialize();
  if (kReleaseMode) {
    EasyLocalization.logger.enableBuildModes = [];
  }
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

  Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  await GetStorage.init();
  await BasePreference.init();

  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [kLocaleID, kLocaleEN],
      fallbackLocale: kLocaleID,
      startLocale: kLocaleID,
      path: 'assets/lang',
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ApiService>.value(value: $it()),
          RepositoryProvider<PackageInfo>.value(value: $it()),
          RepositoryProvider<FirebaseService>.value(value: $it()),
          RepositoryProvider<GetStorage>.value(value: $it()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppCubit>(create: (context) => $it()),
          ],
          child: const MainApp(),
        ),
      ),
    ),
  ));
}
