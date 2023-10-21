import 'package:app/cubits/live_location_cubit/live_location_cubit.dart';
import 'package:app/cubits/user_cubit/user_cubit.dart';
import 'package:app/data/local/base_preference.dart';
import 'package:app/firebase_options.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await GetStorage.init();
  await Flamingo.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await BasePreference.init();
  await NotificationService().initNotification();
  AwesomeNotificationService().initNotification();
  Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [Locale("id", "ID"), Locale("en", "US")],
      fallbackLocale: const Locale("id", "ID"),
      path: 'assets/lang',
      child: const MyApp(),
    ),
  ));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => LiveLocationCubit()),
      ],
      child: MainTheme.materialApp(
        context,
        child: const SplashScreen(),
      ),
    );
  }
}
