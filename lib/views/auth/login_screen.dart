import 'package:app/global_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/login_form.dart';
import 'dart:math' as math;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBlueOpacity,
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (s) => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Positioned(
              //     child: Align(
              //   alignment: Alignment.topCenter,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 80),
              //     child: customHeaderAuth(context, "Verifikasi", "e-mail"),
              //   ),
              // )),
              Positioned(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Icon(FeatherIcons.arrowLeft)),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        s.emailKirim(null, 2);
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Transform.rotate(
                            angle: math.pi / 4,
                            child: Icon(
                              FeatherIcons.send,
                              color: colorBluePrimary,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              formData(s, context),
              Positioned(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 32, left: 20, right: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // customTextRich(
                          //     context, "Baca tentang ", "Kemanan Akun.",
                          //     onTextClicked: () {
                          //   Get.toNamed(RouteName.webview,
                          //       arguments: "https://docs.horaapp.id/#privasi");
                          // }),
                          Text(
                            'Pastikan anda terhubung dengan internet.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              customSnackbar1(Base.connected);
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "Cek koneksi",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
