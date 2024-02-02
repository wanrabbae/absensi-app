import 'package:app/global_resource.dart';

class LoginController extends GetxController {
  //Global
  final box = GetStorage();
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
      customSnackbar1(tr('snackbar_please_relogin'));
      return;
    }

    try {
      customSnackbarLoading(tr('snackbar_sending_otp'));
      var response = await AuthServices().sendLinkPost(mail ?? emailForm);
      if (response.statusCode == 200) {
        if (response.data.toString() == 'OTP Terkirim') {
          Get.back();
          if (status != 1) {
            customSnackbar1(tr('snackbar_otp_sent'));
            Get.toNamed(RouteName.otpLogin, arguments: emailForm);
          } else {
            customSnackbar1(tr('snackbar_otp_sent'));
          }
        } else {
          Get.back();
          customSnackbar1(tr('snackbar_check_inbox'));
        }
      } else {
        debugPrint("EMAIL KIRIM ERROR: $response");
        Get.back();
        customSnackbar1(tr('snackbar_email_registered'));
      }
    } catch (e) {
      debugPrint("CATCH EMAIL KIRIM: $e");
      Get.back();
      customSnackbar1(tr('snackbar_email_not_registered'));
      Get.offAllNamed(RouteName.login);
    }
  }

  otpKirim(email) async {
    try {
      customSnackbarLoading(tr('snackbar_enter_confirmation'));
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
        customSnackbar1(tr('snackbar_otp_invalidar_otp_invalid'));
      }
    } catch (e) {
      Get.back();
      customSnackbar1(tr('snackbar_otp_invalidar_otp_invalid'));
    }
  }
}
