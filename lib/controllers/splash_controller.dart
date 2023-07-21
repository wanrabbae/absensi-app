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
    removeData();
    Get.offAllNamed(RouteName.login);
  }

  loading(msg) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (ctx) {
          return customDialogLoading(ctx, msg);
        });
  }

  loadingLocation(msg) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (ctx) {
          return customDialogLoading(ctx, msg);
        });
  }

  horizontalDialogOk(msg) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: true,
        builder: (ctx) {
          return customDialogOk(ctx, msg);
        });
  }

  // showConfirmationDialog(
  //     String title, String message, VoidCallback? actionFunc) {
  //   showDialog(
  //     context: Get.overlayContext!,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //         title: Text(
  //           title,
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  //         ),
  //         content: Text(
  //           message,
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  //         ),
  //         actionsAlignment: MainAxisAlignment.spaceEvenly,
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text(
  //               'Tidak',
  //               style: TextStyle(fontWeight: FontWeight.w500),
  //             ),
  //             onPressed: () {
  //               Get.back(); // Returns false when canceled
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Ya', style: TextStyle(fontWeight: FontWeight.w500)),
  //             onPressed: () {
  //               Navigator.of(context).pop(true); // Returns true when confirmed
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   ).then((value) {
  //     if (value == true) {
  //       actionFunc!();
  //     } else {
  //       Get.back();
  //     }
  //   });
  // }

  showConfirmationDialog(
      String title, String message, VoidCallback? actionFunc) {
    Get.defaultDialog(
        backgroundColor: Colors.white,
        title: title,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titlePadding: const EdgeInsets.all(10),
        content: Padding(
          padding: EdgeInsets.all(5),
          child: Text(message,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        buttonColor: Colors.transparent,
        cancelTextColor: colorBluePrimary,
        confirmTextColor: colorBluePrimary,
        textConfirm: "Ya",
        textCancel: "Tidak",
        onConfirm: () {
          actionFunc!();
        });
  }

  showOkDialog(String title, String message) {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
