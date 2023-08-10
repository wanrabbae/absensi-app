import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';

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
        Get.offAndToNamed(RouteName.home, arguments: 0);
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
    AwesomeNotificationService().removeNotification();
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

  loadingWithAsset(msg, asset) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (ctx) {
          return customDialogLoadingImage(ctx, msg, asset);
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

  showConfirmationDialog2(
      String title, String message, VoidCallback? actionFunc) {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(5),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 70,
            child: Column(
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text(
                        'Tidak',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.back(); // Returns false when canceled
                      },
                    ),
                    TextButton(
                      child: Text('Ya',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Returns true when confirmed
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          // actionsAlignment: MainAxisAlignment.spaceAround,
          // actions: <Widget>[

          // ],
        );
      },
    ).then((value) {
      if (value == true) {
        actionFunc!();
      } else {
        Get.back();
      }
    });
  }

  showConfirmationDialog3(
      String title, String message, VoidCallback? actionFunc) {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(5),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 70,
            child: Column(
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text(
                        'Batal',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.back(); // Returns false when canceled
                      },
                    ),
                    TextButton(
                      child: Text('Oke',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Returns true when confirmed
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          // actionsAlignment: MainAxisAlignment.spaceAround,
          // actions: <Widget>[

          // ],
        );
      },
    ).then((value) {
      if (value == true) {
        actionFunc!();
      } else {
        // Get.back();
      }
    });
  }

  showConfirmationDialogEmail(
      String title, String message, VoidCallback? actionFunc) {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(5),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 70,
            child: Column(
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text(
                        'Tidak',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.back(); // Returns false when canceled
                      },
                    ),
                    TextButton(
                      child: Text('Ya',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Returns true when confirmed
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          // actionsAlignment: MainAxisAlignment.spaceAround,
          // actions: <Widget>[

          // ],
        );
      },
    ).then((value) {
      if (value == true) {
        actionFunc!();
      } else {}
    });
  }

  showConfirmationDialog(
      String title, String message, VoidCallback? actionFunc) {
    Get.defaultDialog(
        backgroundColor: Colors.white,
        title: title,
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  showOkDialog2(String title, String message, VoidCallback? actionFunc) {
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(5),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 70,
            child: Column(
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text('Ok',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Returns true when confirmed
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          // actionsAlignment: MainAxisAlignment.spaceAround,
          // actions: <Widget>[

          // ],
        );
      },
    ).then((value) {
      if (value == true) {
        actionFunc!();
      } else {
        Get.back();
      }
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
