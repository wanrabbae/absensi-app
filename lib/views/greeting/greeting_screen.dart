import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: colorGrayPrimary,
        body: Stack(
          children: [
            Positioned(
                top: 60,
                child: customHeaderAuth(context, "HORA,", "Selamat datang!")),
            Center(
                child: Image.asset(
              "assets/icons/logo/main_logo.png",
              width: 100,
              height: 100,
            )),
            Positioned(
                bottom: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // customTextRich(
                        //     context, "Baca tentang ", "Kebijakan Privasi.",
                        //     onTextClicked: () {
                        //   Get.toNamed(RouteName.webview,
                        //       arguments: "https://docs.horaapp.id/#kebijakan");
                        // }),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        const Text(
                          "Tekan “SETUJU & LANJUTKAN” untuk menyetujui. Terima kasih.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        buttonGreen("SETUJU & LANJUTKAN", onTap: () {
                          Get.toNamed(RouteName.login);
                        })
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
