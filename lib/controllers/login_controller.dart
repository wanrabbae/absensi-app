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
    emailForm = emailForm;
    print(mail.toString() + ", " + emailForm.toString());
    try {
      SplashController().loading("Mengirim kode OTP");
      var response = await AuthServices().sendLinkPost(mail ?? emailForm);
      if (response.statusCode == 200) {
        if (response.data.toString() == 'OTP Terkirim') {
          Get.back();
          if (status != 1) {
            Get.snackbar('Masuk Berhasil', response.data.toString());
            Get.toNamed(RouteName.otpLogin, arguments: emailForm);
          } else {
            Get.snackbar(
                'Otp Berhasil Dikirim Ulang', response.data.toString());
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
      Get.snackbar('Mohon maaf masukkan email anda kembali', '');
      Get.offAllNamed(RouteName.login);
    }
  }

  otpKirim(email) async {
    try {
      SplashController().loading("Mengkonfirmasi Masuk");
      var response = await AuthServices().verifyOtpGet(
          {"email": user?['alamatEmail'] ?? email, "otp": otpForm});
      if (response.statusCode == 200) {
        box.write(Base.token, response.body['token']);
        var res = await ProfileController().dataProfile(email);
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
