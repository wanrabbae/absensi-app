import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (s) => const Scaffold(
        backgroundColor: colorSplash,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/icons/logo/hora.png"),
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
