import 'package:app/global_resource.dart';

Widget gantiEmailOtp(context, s) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          customHeaderAuth(context, "Verifikasi", "E-mail baru"),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            onChanged: (value) {
              s.otp = value;
              // if (value == "1234") {
              //   ref.read(prefProvider).setIsLogin(true);
              //   AppRoute.pop();
              // } else {
              //   showDialog(
              //       context: context,
              //       builder: (ctx) => customDialog(
              //           context, "Periksa kembali kode OTP", "OK",
              //           onTap: () => AppRoute.pop()));
              // }
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Masukkan kode OTP",
                contentPadding:
                    const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                suffixIconConstraints:
                    const BoxConstraints(minHeight: 30, minWidth: 30),
                suffixIconColor: Colors.white,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      s.verifyUbahEmail();
                      // final loading = showDialog(
                      //     context: context,
                      //     builder: (ctx) {
                      //       Future.delayed(const Duration(seconds: 2))
                      //           .then((value) => Get.back());
                      //       return customDialogLoading(
                      //           ctx, "Mengirim kode OTP");
                      //     });
                      // loading.then((value) {
                      // if (otpController.text == "1234") {
                      //   ref.read(prefProvider).setIsLogin(true);
                      //   AppRoute.pop();
                      // } else {
                      //   showDialog(
                      //       context: context,
                      //       builder: (ctx) => customDialog(
                      //           context, "Periksa kembali kode OTP", "OK",
                      //           onTap: () => AppRoute.pop()));
                      // }
                      // });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/arrow_right_primary.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: customTextRich(
                context, "Tidak menerima kode OTP ? ", "Kirim Ulang",
                onTextClicked: () {
              s.ubahEmail("Mengirim ulang kode OTP", 2);
              //   final loading = showDialog(
              //       context: context,
              //       builder: (ctx) {
              //         Future.delayed(const Duration(seconds: 2))
              //             .then((value) => Get.back());
              //         return customDialogLoading(ctx, "Mengirim ulang kode OTP");
              //       });
              //   loading.then((value) {
              //     showDialog(
              //         context: context,
              //         builder: (ctx) {
              //           Future.delayed(const Duration(seconds: 2))
              //               .then((value) => Get.back());
              //           return customDialogLoading(
              //               ctx, "Kode OTP berhasil dikirim");
              //         });
              //   });
            }),
          ),
          const SizedBox(
            height: 220,
          )
        ],
      ),
    ),
  );
}
