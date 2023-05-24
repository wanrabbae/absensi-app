import 'package:app/global_resource.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  @override
  void onInit() async {
    super.onInit();
    Timer(const Duration(seconds: 5), () {
      var splashScreen = box.read(Base.splash);
      var user = box.read(Base.dataUser);
      if (user == null) {
        if (splashScreen == null) {
          Get.offAndToNamed(RouteName.tutorial);
        } else {
          Get.offAndToNamed(RouteName.greeting);
        }
      } else {
        Get.offAndToNamed(RouteName.home);
      }
    });
  }

  tutupTutorial() {
    box.write(Base.splash, "sudah lewat tutorial");
    Get.offAllNamed(RouteName.greeting);
  }

  removeData() {
    box.remove(Base.dataUser);
    box.remove(Base.token);
    box.remove(Base.dataAbsen);
    box.remove(Base.waktuAbsen);
    box.remove(Base.izinAbsen);
    box.remove(Base.klikAbsen);
    box.remove(Base.dataPerusahaan);
    box.remove(Base.perusahaanTerpilih);
    Get.offAllNamed(RouteName.greeting);
  }

  sessionHabis(mail) {
    LoginController().emailKirim(mail, 1);
    Get.offAllNamed(RouteName.otpLogin);
  }

  loading(msg) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (ctx) {
          return customDialogLoading(ctx, msg);
        });
  }
}
