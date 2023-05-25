import 'package:app/global_resource.dart';

class LoginController extends GetxController {
  //Global
  final box = GetStorage();
  final formLogin = GlobalKey<FormBuilderState>();
  final formOtp = GlobalKey<FormBuilderState>();
  Map? user;
  //Login
  String? emailForm;
  //Otp
  String? otpForm;

  @override
  void onInit() async {
    super.onInit();
    user = box.read(Base.dataUser);
  }

  emailKirim(mail, status) async {
    try {
      SplashController().loading("Mengirim kode OTP");
      var response = await AuthServices().sendLinkPost(mail ?? emailForm);
      if (response.statusCode == 200) {
        if (response.body.toString() == 'OTP Terkirim') {
          Get.back();
          if (status != 1) {
            Get.snackbar('Masuk Berhasil', response.body.toString());
            Get.toNamed(RouteName.otpLogin);
          } else {
            Get.snackbar(
                'Otp Berhasil Dikirim Ulang', response.body.toString());
          }
        } else {
          Get.back();
          Get.snackbar("${response.body.toString()} !!",
              "Silahkan Cek Email Anda Untuk Melanjutkan");
        }
      } else {
        print("EMAIL KIRIM ERROR: " + response.toString());
        Get.back();
        Get.snackbar('Masuk Gagal', response.body.toString());
      }
    } catch (e) {
      print("CATCH EMAIL KIRIM: " + e.toString());
      Get.back();
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }

  otpKirim() async {
    try {
      SplashController().loading("Mengkonfirmasi Masuk");
      var response = await AuthServices().verifyOtpGet(
          {"email": user?['alamatEmail'] ?? emailForm, "otp": otpForm});
      if (response.statusCode == 200) {
        box.write(Base.token, response.body['token']);
        var res = await ProfileController().dataProfile(emailForm);
        Get.back();
        box.write(Base.dataUser, res);
        Get.toNamed(RouteName.home);
      } else {
        Get.back();
        Get.snackbar('Gagal Menggunakan Otp', response.body.toString());
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }
}
