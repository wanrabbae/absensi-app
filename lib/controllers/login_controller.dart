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

    var isValidEmail = isEmailValid(emailForm.toString());
    if (!isValidEmail) {
      customSnackbar1("Silakan masuk kembali.");
      return;
    }

    try {
      customSnackbarLoading("Sedang mengirimkan kode OTP...");
      var response = await AuthServices().sendLinkPost(mail ?? emailForm);
      if (response.statusCode == 200) {
        if (response.data.toString() == 'OTP Terkirim') {
          Get.back();
          if (status != 1) {
            customSnackbar1('Berhasil mengirimkan kode OTP.');
            Get.toNamed(RouteName.otpLogin, arguments: emailForm);
          } else {
            customSnackbar1('Berhasil mengirimkan kode OTP.');
          }
        } else {
          Get.back();
          customSnackbar1("Periksa kotak masuk email anda.");
        }
      } else {
        print("EMAIL KIRIM ERROR: " + response.toString());
        Get.back();
        customSnackbar1("Email telah terdaftar");
      }
    } catch (e) {
      print("CATCH EMAIL KIRIM: " + e.toString());
      Get.back();
      customSnackbar1("Email anda belum terdaftar.");
      Get.offAllNamed(RouteName.login);
    }
  }

  otpKirim(email) async {
    try {
      customSnackbarLoading("Mengonfirmasi masuk...");
      var response = await AuthServices().verifyOtpGet(
          {"email": user?['alamatEmail'] ?? email, "otp": otpForm});
      if (response.statusCode == 200) {
        box.write(Base.token, response.body['token']);
        var res = await ProfileController().dataProfile(email);
        Get.back();
        box.write(Base.dataUser, res);
        Get.offAllNamed(RouteName.home, arguments: 0);
      } else {
        Get.back();
        customSnackbar1("Kode OTP tidak valid.");
      }
    } catch (e) {
      Get.back();
      customSnackbar1("Kode OTP tidak valid.");
    }
  }
}
