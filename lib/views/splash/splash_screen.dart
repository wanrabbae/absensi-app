import 'package:after_layout/after_layout.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (s) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            widthFactor: 350,
            heightFactor: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage("assets/icons/logo/hora.png"),
                  width: 100,
                ),
                // Text(
                //   'Hora',
                //   style: TextStyle(
                //     fontSize: 40,
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //   ),
                // )
              ],
            )),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    AwesomeNotificationService().removeNotificationUnUsed();
    FlutterAppBadger.removeBadge();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}
