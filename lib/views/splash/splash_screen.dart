import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
}
