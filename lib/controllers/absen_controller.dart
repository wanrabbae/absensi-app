import 'package:app/data/models/notification/push_notification.dart' as model;
import 'package:app/data/source/firebase/firebase_service.dart';
import 'package:app/data/source/notification/push_notif_api_service.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:app/views/_components/dialog.dart';
import 'package:in_app_review/in_app_review.dart';

class AbsenController extends GetxController {
  //global
  final box = GetStorage();
  String? currentDate;
  String? fileName;
  PlatformFile? file;
  int changePageScreen = 0;
  Map? user;
  Map<String, dynamic>? izinData;

  //absen
  LatLng currentLocation = const LatLng(5.880241, 95.336574);
  LatLng currentLocationPulang = const LatLng(5.880241, 95.336574);
  String? timerRecor = "00:00:00";
  String? waktuAbsen;
  File? formFoto;
  File? formFotoPulang;
  File? formFotoIzin;
  bool disableButton = false;
  bool klikAbsen = false;
  String? alamatLoc;
  String? alamatLocPulang;

  // ignore: prefer_typing_uninitialized_variables
  var timer;

  //izin
  Map? perusahaan;
  List? perusahaanList;
  String formIzin = 'Izin';
  String? formDeskripsi;
  String? namaOrang;
  String? statusState;
  List? izinList = [
    {"nama": "Izin", "value": "Izin"},
    {"nama": "Sakit", "value": "Sakit"},
    {"nama": "Cuti", "value": "Cuti"}
  ];

  @override
  void onInit() async {
    final homeCtrl = Get.put(HomeController());
    var findData = homeCtrl.absen?.firstWhere(
      (element) =>
          element?["idKaryawan"] == user?["idkaryawan"] &&
          element?["waktuCheckOut"] != null,
      orElse: () => null,
    );

    var findDataIzin = homeCtrl.izin?.firstWhere(
      (element) => element?["idKaryawan"] == user?["idkaryawan"],
      orElse: () => null,
    );
    super.onInit();
    user = box.read(Base.dataUser);
    klikAbsen = box.read(Base.klikAbsen) ?? false;
    currentDate = DateTime.now().toString();
    user = await ProfileController().dataProfile(user?['alamatEmail']);
    await dataPerusahaan();
    startTimer();

    if (findDataIzin != null) izinData = findDataIzin;

    if (!klikAbsen && findData == null) {
      getCurrentLocation();
    }

    var findDataOnCheckIn = homeCtrl.absen?.firstWhere(
      (element) => element?["idKaryawan"] == user?["idkaryawan"],
      orElse: () => null,
    );

    if (klikAbsen && timer?.isActive) {
      mulaiPulangRevisi1(findDataOnCheckIn?['id']);
    }
  }

  updateStatusStateFromNotif() {
    statusState = "dariNotif";
    update();
  }

  startTimer() {
    final homeCtrl = Get.put(HomeController());
    var findData = homeCtrl.absen?.firstWhere(
      (element) =>
          element?["idKaryawan"] == user?["idkaryawan"] &&
          element?["waktuCheckOut"] == null,
      orElse: () => null,
    );

    var checkData = homeCtrl.absen?.firstWhere(
      (element) => element?["idKaryawan"] == user?["idkaryawan"],
      orElse: () => null,
    );

    if (checkData == null) {
      box.remove(Base.klikAbsen);
      box.remove(Base.waktuAbsen);
      cancelTimer();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (klikAbsen) {
        timerRecor = timerAbsen4();
      } else if (findData != null) {
        timerRecor = timerAbsen3(findData?["waktuCheckIn"], null);
        update();
      } else {
        timerRecor = "00:00:00";
        cancelTimer();
      }
      update();
    });
  }

  cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  dataPerusahaan() {
    var terpilih = box.read(Base.perusahaanTerpilih);
    perusahaanList = jsonDecode(box.read(Base.dataPerusahaan));
    if (terpilih == null) {
      perusahaan = perusahaanList![0];
    } else {
      perusahaan = perusahaanList!
          .where((value) => value['idperusahaan'] == terpilih)
          .toList()[0];
    }
  }

  getCurrentLocation() async {
    if (Platform.isIOS) {
      bool serviceEnabled;
      LocationPermission permission;

      await Permission.location.serviceStatus.isEnabled.then((value) {
        if (!value) {
          Permission.location.request();
        }
      });

      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showConfirmationDialog2(
            tr('dialog_permission_title2'), tr('dialog_permission_message2'), () {
            // Redirect to allow location setting on phone
            openAppSettings();
          });
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        showConfirmationDialog2(
          tr('dialog_permission_title2'), tr('dialog_permission_message2'), () {
          // Redirect to allow location setting on phone
          openAppSettings();
        });
        return false;
      }
      if (!serviceEnabled) {
        Get.offAllNamed(RouteName.home);
        customSnackbar1(tr('snackbar_please_enable_location'));
        return false;
      }
      update();
      lokasiDetect();
    } else {
      lokasiDetect();
    }
  }

  lokasiDetect() async {
    customSnackbarLoadingAsset(
        tr('snackbar_finding_location'), "images/map-pin-gif.gif");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocation = LatLng(position.latitude, position.longitude);
      getAddressFromLatLng();

      Get.back();
      customSnackbarLoadingAsset(
          tr('snackbar_location_found'), "images/check-gif.gif");
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.back();
          mulaiAbsen();
        },
      );
      update();
    });
  }

  getCurrentLocationPulang(idAbsen) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      customSnackbar1(tr('snackbar_location_disabled'));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showConfirmationDialog2(
          tr('dialog_permission_title2'), tr('dialog_permission_message2'), () {
          // Redirect to allow location setting on phone
          openAppSettings();
        });
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showConfirmationDialog2(
        tr('dialog_permission_title2'), tr('dialog_permission_message2'), () {
        // Redirect to allow location setting on phone
        openAppSettings();
      });
      return false;
    }
    update();
    lokasiDetectPulang(idAbsen);
  }

  getCurrentLocationPulang2(idAbsen) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      customSnackbar1(tr('snackbar_location_disabled'));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showConfirmationDialog2(
          tr('dialog_permission_title2'), tr('dialog_permission_message2'), () {
          // Redirect to allow location setting on phone
          openAppSettings();
        });
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showConfirmationDialog2(
        tr('dialog_permission_title2'), tr('dialog_permission_message2'), () {
        // Redirect to allow location setting on phone
        openAppSettings();
      });
      return false;
    }
    update();
    lokasiDetectPulang2(idAbsen);
  }

  lokasiDetectPulang(idAbsen) {
    customSnackbarLoadingAsset(
        tr('snackbar_finding_location'), "images/map-pin-gif.gif");
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then(
        (Position position) async {
      currentLocationPulang = LatLng(position.latitude, position.longitude);
      getAddressFromLatLngPulang();
      Get.back();
      customSnackbarLoadingAsset(
          tr('snackbar_location_found'), "images/check-gif.gif");
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
        mulaiPulangAct(idAbsen);
      });
      update();
    }, onError: (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    });
  }

  lokasiDetectPulang2(idAbsen) async {
    customSnackbarLoadingAsset(
        tr('snackbar_finding_location'), "images/map-pin-gif.gif");

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocationPulang = LatLng(position.latitude, position.longitude);
      getAddressFromLatLngPulang();

      Get.back();
      customSnackbarLoadingAsset(
          tr('snackbar_location_found'), "images/check-gif.gif");
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
        mulaiPulangAct2(idAbsen);
      });

      update();
    });
  }

  getAddressFromLatLng() async {
    await placemarkFromCoordinates(
            currentLocation.latitude, currentLocation.longitude)
        .then((List<Placemark> placemarks) {
      alamatLoc =
          "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode} ";
      update();
    });
  }

  Future<void> getAddressFromLatLngPulang() {
    return placemarkFromCoordinates(
            currentLocationPulang.latitude, currentLocationPulang.longitude)
        .then((List<Placemark> placemarks) {
      alamatLocPulang = "${placemarks[0].street}, "
          "${placemarks[0].subLocality}, "
          "${placemarks[0].locality}, "
          "${placemarks[0].subAdministrativeArea}, "
          "${placemarks[0].administrativeArea}, "
          "${placemarks[0].postalCode} ";
      update();
    });
  }

  mulaiSelesaiAbsen(context, idAbsen) {
    if (!klikAbsen) {
      showConfirmationDialog2(tr('selfie'), tr('snackbar_take_photo_now'), () {
        Get.back();
        ImagePicker()
            .pickImage(
                source: ImageSource.camera,
                preferredCameraDevice: CameraDevice.front,
                imageQuality: 50)
            .then((value) {
          if (value != null) {
            formFoto = File(value.path);
            update();
            absenHadir();
          } else {
            customSnackbar1(tr('snackbar_no_photo'));
          }
        });
      });
    } else {
      showConfirmationDialog2(tr('dialog_presence_title'), tr('dialog_presence_message'), () {
        Get.back();
        ImagePicker()
            .pickImage(
                source: ImageSource.camera,
                preferredCameraDevice: CameraDevice.front,
                imageQuality: 50)
            .then((value) {
          if (value != null) {
            formFotoPulang = File(value.path);
            update();
            absenPulang(true, idAbsen);
          } else {
            customSnackbar1(tr('snackbar_no_photo'));
          }
        });
      });
    }
  }

  mulaiAbsen() async {
    showConfirmationDialog2(tr('selfie'), tr('snackbar_take_photo_now'), () {
      // Get.back();
      ImagePicker()
          .pickImage(
              source: ImageSource.camera,
              preferredCameraDevice: CameraDevice.front,
              imageQuality: 50)
          .then((value) {
        if (value != null) {
          formFoto = File(value.path);
          update();
          absenHadir();
        } else {
          customSnackbar1(tr('snackbar_no_photo'));
        }
      });
    });
  }

  mulaiPulang(context, idAbsen) {
    showConfirmationDialog2(tr('dialog_presence_title'), tr('dialog_presence_message'), () async {
      // Get.back();
      // changePageScreen = 1;
      // update();
      await getCurrentLocationPulang(idAbsen);
    });
  }

  mulaiPulangRevisi1(idAbsen) async {
    await getCurrentLocationPulang(idAbsen);
  }

  mulaiPulang2(idAbsen) {
    showConfirmationDialog2(tr('dialog_presence_title'), tr('dialog_presence_message'), () async {
      // Get.back();
      // changePageScreen = 1;
      // update();
      Get.toNamed(RouteName.absen,
          arguments: {"dataAbsen": idAbsen, "pulang": 1});

      await getCurrentLocationPulang2(idAbsen?["id"]);
    });
  }

  mulaiPulangFromNotif(idAbsen) {
    showConfirmationDialog2(tr('dialog_presence_title'), tr('dialog_presence_message'), () async {
      await getCurrentLocationPulang(idAbsen?["id"]);
    });
  }

  mulaiPulangAct(idAbsen) {
    showConfirmationDialog2(tr('selfie'), tr('snackbar_take_photo_now'), () {
      ImagePicker()
          .pickImage(
              source: ImageSource.camera,
              preferredCameraDevice: CameraDevice.front,
              imageQuality: 50)
          .then((value) {
        if (value != null) {
          formFotoPulang = File(value.path);
          update();
          absenPulang(true, idAbsen);
        } else {
          customSnackbar1(tr('snackbar_no_photo'));
        }
      });
    });
  }

  mulaiPulangAct2(idAbsen) {
    showConfirmationDialog2(tr('selfie'), tr('snackbar_take_photo_now'), () {
      ImagePicker()
          .pickImage(
              source: ImageSource.camera,
              preferredCameraDevice: CameraDevice.front,
              imageQuality: 50)
          .then((value) {
        if (value != null) {
          formFotoPulang = File(value.path);
          update();
          absenPulang2(true, idAbsen);
        } else {
          customSnackbar1(tr('snackbar_no_photo'));
        }
      });
    });
  }

  updateFile() async {
    // FilePicker
    await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc']).then((result) {
      if (result != null) {
        file = result.files.first;
        fileName = "${file?.name} (${file?.size})";
        update();
      }
    });
  }

  updateFormIzin(value) {
    formIzin = value;
    update();
  }

  absenHadir() async {
    try {
      customSnackbarLoading(tr('snackbar_submiting_presence'));
      final forms = {
        'IDKaryawan': user?['idkaryawan'],
        'NamaKaryawan': user?['namaKaryawan'],
        'AlamatLatitude': currentLocation.latitude,
        'AlamatLongtitude': currentLocation.longitude,
        'Foto': {
          'filePath': formFoto!.path,
          'fileName': formFoto!.path.split('/').last
        },
        // MultipartFile(formFoto, filename: formFoto!.path.split('/').last),
        'AlamatLoc': alamatLoc,
        'IDPerusahaan': perusahaan?['idperusahaan'],
        'NamaPerusahaan': perusahaan?['namaPerusahaan']
      };

      var response = await AbsensiServices().hadirPost(forms);
      if (response.statusCode == 200) {
        Get.back();
        box.write(Base.waktuAbsen, DateTime.now().toString());
        box.write(Base.klikAbsen, true);
        Get.offAllNamed(RouteName.home, arguments: 0);
        final now = DateTime.now();
        AwesomeNotificationService()
          ..showNotificationAbsen(now)
          ..showNotificationAfter12Hours(now);
      } else if (response.statusCode == 401) {
        Get.back();
        customSnackbar1(tr('snackbar_error_system'));
        // SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1(tr('snackbar_error_system'));
      }
    } catch (e) {
      customSnackbar1(tr('snackbar_error_system'));
    }
  }

  findIndie(idKaryawan) async {
    try {
      var response = await AbsensiServices().hadirPost(idKaryawan);
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 401) {
        // Get.back();
        customSnackbar1(tr('snackbar_error_system'));
        // SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        // Get.back();
        customSnackbar1(tr('snackbar_error_system'));
      }
    } catch (e) {
      customSnackbar1(tr('snackbar_error_system'));
    }
  }

  absenPulang(status, idAbsen, [String? tanggal]) async {
    if (idAbsen == null) {
      customSnackbar1(tr('snackbar_presence_not_found'));
      return;
    }

    var currentDate = DateTime.now();
    var newDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    try {
      final forms = {
        'LatitudePulang': currentLocationPulang.latitude,
        'LongtitudePulang': currentLocationPulang.longitude,
        'NamaKaryawan': user?['namaKaryawan'],
        'Foto': {
          'filePath': formFotoPulang!.path,
          'fileName': formFotoPulang!.path.split('/').last
        },
        'AlamatPulang': alamatLocPulang,
      };

      var response = await AbsensiServices()
          .pulangPut({'id': idAbsen, 'tanggal': newDate}, forms);

      if (response.statusCode == 200) {
        Get.back();
        box.write(Base.klikAbsen, false);
        box.remove(Base.waktuAbsen);
        await HomeController().cancelTimer();
        await cancelTimer();
        await AwesomeNotificationService().showNotificationAbsenDone();

        dynamic args = 0;
        if (Get.isRegistered<HomeController>()) {
          final homeCtrl = Get.find<HomeController>();
          var findDataOnCheckIn = homeCtrl.absen?.firstWhere(
            (element) => element?["idKaryawan"] == user?["idkaryawan"],
            orElse: () => null,
          );
          if (findDataOnCheckIn is Map) {
            final tanggal = findDataOnCheckIn['tanggal'];
            if (tanggal is String) {
              final date = DateTime.tryParse(tanggal)?.toLocal();
              if (date != null) {
                args = kMysqlDateFormat.format(date);
              }
            }
          }
        }
        if (status) {
          customSnackbar1(tr('snackbar_already_present'));
          Get.offAllNamed(RouteName.home, arguments: args);
          await HomeController().dataHome();
        } else {
          Get.offAllNamed(RouteName.home, arguments: args);
          await HomeController().dataHome();
        }
        _showReviewAndClearLiveTracking(user?["idkaryawan"]);
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else if (response.statusCode == 400) {
        Get.back();
        customSnackbar1(tr('snackbar_error_system'));
      } else {
        Get.back();
        customSnackbar1(tr('snackbar_error_system'));
      }
    } catch (e) {
      debugPrint(e.toString());
      customSnackbar1(tr('snackbar_error_system'));
    }
  }

  absenPulang2(status, idAbsen) async {
    var currentDate = DateTime.now();
    var newDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    try {
      final forms = {
        'LatitudePulang': currentLocationPulang.latitude,
        'LongtitudePulang': currentLocationPulang.longitude,
        'NamaKaryawan': user?['namaKaryawan'],
        'Foto': {
          'filePath': formFotoPulang!.path,
          'fileName': formFotoPulang!.path.split('/').last
        },
        'AlamatPulang': alamatLocPulang,
      };
      var response = await AbsensiServices()
          .pulangPut({'id': idAbsen, 'tanggal': newDate}, forms);

      if (response.statusCode == 200) {
        box.write(Base.klikAbsen, false);
        box.remove(Base.waktuAbsen);
        await HomeController().cancelTimer();
        await cancelTimer();
        AwesomeNotificationService()
          ..removeNotification()
          ..showNotificationAbsenDone();
        _showReviewAndClearLiveTracking(user?["idkaryawan"]);
        ProfileController().keluar();
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else if (response.statusCode == 400) {
        Get.back();
        customSnackbar1(tr('snackbar_error_system'));
      } else {
        Get.back();
        customSnackbar1(tr('snackbar_error_system'));
      }
    } catch (e) {
      debugPrint(e.toString());
      customSnackbar1(tr('snackbar_error_system'));
    }
  }

  absenIzin() async {
    try {
      customSnackbarLoading(tr('snackbar_submiting_permit'));
      final FormData forms = FormData({
        'IDKaryawan': user?['idkaryawan'],
        'NamaKaryawan': user?['namaKaryawan'],
        'Keterangan': formDeskripsi,
        'Ijin': formIzin,
        'DokumenIjin': MultipartFile(file!.path, filename: file!.name),
        'IDPerusahaan': perusahaan?['idperusahaan'],
        'NamaPerusahaan': perusahaan?['namaPerusahaan']
      });
      var response = await AbsensiServices().izinPost(forms);
      if (response.statusCode == 200) {
        box.write(Base.izinAbsen, DateTime.now().toString());
        if (!klikAbsen) {
          Get.back();
          Get.offAllNamed(RouteName.home, arguments: 0);
          await HomeController().dataHome();
        } else {
          final homeCtrl = Get.put(HomeController());
          var findData = await homeCtrl.absen?.firstWhere(
              (element) => element?["idKaryawan"] == user?["idkaryawan"],
              orElse: () => null);

          absenPulang(false, findData?["id"]);
        }
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
      }
    } catch (e) {
      box.write(Base.izinAbsen, DateTime.now().toString());
      if (!klikAbsen) {
        Get.back();
        Get.offAllNamed(RouteName.home, arguments: 0);
        await HomeController().dataHome();
      } else {
        final homeCtrl = Get.put(HomeController());
        var findData = await homeCtrl.absen?.firstWhere(
            (element) => element?["idKaryawan"] == user?["idkaryawan"],
            orElse: () => null);

        absenPulang(false, findData?["id"]);
      }
    }
  }
}

_showReviewAndClearLiveTracking(dynamic broadcasterId) async {
  final InAppReview inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()) {
    inAppReview.requestReview();
  }

  if (broadcasterId is String) {
    final firebaseService = $it<FirebaseService>();
    final pushNotificationApiService = $it<PushNotificationApiService>();
    firebaseService.clearAllLiveTracking(broadcasterId).then((idKaryawans) {
      pushNotificationApiService.sendPushNotification(
        model.PushNotification(
          notification: const model.Notification(
            title: 'Pengiriman lokasi dihentikan',
            body: 'Sentuh untuk membuka aplikasi',
          ),
          data: {
            'tag': 'STOP_REQUEST_LIVE_TRACKING',
          },
          android: const model.Android(
            notification: model.AndroidNotification(),
          ),
          karyawanIds: idKaryawans,
        ),
      );
    });
  }
}
