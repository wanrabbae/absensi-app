import 'package:app/global_resource.dart';
import 'package:flutter/cupertino.dart';
import 'components/verify_otp_form.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailBefore = Get.arguments;
    return Scaffold(
      backgroundColor: colorBlueOpacity,
      resizeToAvoidBottomInset: false,
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
                        s.otpKirim(emailBefore);
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Icon(
                            FeatherIcons.send,
                            color: colorBluePrimary,
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
                  padding: const EdgeInsets.only(bottom: 32),
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
                            'Tekan “Kirim ulang OTP” jika anda belum menerima\n kode OTP',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              s.emailKirim(emailBefore, 1);
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  "Kirim ulang OTP",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
