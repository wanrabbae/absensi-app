import 'package:app/data/models/notification/push_notification.dart' as model;
import 'package:app/data/source/firebase/firebase_service.dart';
import 'package:app/data/source/notification/push_notif_api_service.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
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
      debugPrint("BELUM ABSEN");
      getCurrentLocation();
    }

    var findDataOnCheckIn = homeCtrl.absen?.firstWhere(
      (element) => element?["idKaryawan"] == user?["idkaryawan"],
      orElse: () => null,
    );

    if (klikAbsen && timer?.isActive) {
      debugPrint("TEST TOAST");
      debugPrint("DATA CHECKIN: $findDataOnCheckIn");
      debugPrint("STATUS STATE: $statusState");
      mulaiPulangRevisi1(findDataOnCheckIn?['id']);
    }
  }

  updateStatusStateFromNotif() {
    debugPrint("UPDATE STATE YOYY");
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
      debugPrint("===== CHECK DATA NULL ====");
      box.remove(Base.klikAbsen);
      box.remove(Base.waktuAbsen);
      cancelTimer();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (klikAbsen) {
        debugPrint("KE IF TIMER 1");
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
    debugPrint("CANCEL TIMER ABSEN");
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
        debugPrint("LOCATION: $value");
        if (!value) {
          Permission.location.request();
        }
      });

      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          SplashController().showConfirmationDialog2(
              "Perizinan", "Buka pengaturan perizinan perangkat?", () {
            // Redirect to allow location setting on phone
            openAppSettings();
          });
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        SplashController().showConfirmationDialog2(
            "Perizinan", "Buka pengaturan perizinan perangkat?", () {
          // Redirect to allow location setting on phone
          openAppSettings();
        });
        return false;
      }
      if (!serviceEnabled) {
        Get.offAllNamed(RouteName.home);
        customSnackbar1("Mohon aktifkan lokasi anda");
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
        "Mencari titik lokasi anda...", "images/map-pin-gif.gif");
    // debugPrint("========== TEST TOST YOYYYY =======");
    // customSnackbarLoading("Sedang mendeteksi lokasi anda...");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocation = LatLng(position.latitude, position.longitude);
      getAddressFromLatLng();

      Get.back();
      customSnackbarLoadingAsset(
          "Titik lokasi anda ditemukan.", "images/check-gif.gif");
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
      customSnackbar1("Lokasi Tidak Aktif");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SplashController().showConfirmationDialog2(
            "Perizinan", "Buka pengaturan perizinan perangkat?", () {
          // Redirect to allow location setting on phone
          openAppSettings();
        });
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      SplashController().showConfirmationDialog2(
          "Perizinan", "Buka pengaturan perizinan perangkat?", () {
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
      customSnackbar1("Lokasi Tidak Aktif");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        SplashController().showConfirmationDialog2(
            "Perizinan", "Buka pengaturan perizinan perangkat?", () {
          // Redirect to allow location setting on phone
          openAppSettings();
        });
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      SplashController().showConfirmationDialog2(
          "Perizinan", "Buka pengaturan perizinan perangkat?", () {
        // Redirect to allow location setting on phone
        openAppSettings();
      });
      return false;
    }
    update();
    lokasiDetectPulang2(idAbsen);
  }

  lokasiDetectPulang(idAbsen) {
    debugPrint("ID ABSEN FROM DETECTED: $idAbsen");
    customSnackbarLoadingAsset(
        "Mencari titik lokasi anda...", "images/map-pin-gif.gif");
    // customSnackbarLoading("Sedang mendeteksi lokasi anda...");
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then(
        (Position position) async {
      debugPrint('Current location updated = $position');
      currentLocationPulang = LatLng(position.latitude, position.longitude);
      getAddressFromLatLngPulang();
      Get.back();
      customSnackbarLoadingAsset(
          "Titik lokasi anda ditemukan.", "images/check-gif.gif");
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
        "Mencari titik lokasi anda...", "images/map-pin-gif.gif");

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocationPulang = LatLng(position.latitude, position.longitude);
      getAddressFromLatLngPulang();

      Get.back();
      customSnackbarLoadingAsset(
          "Titik lokasi anda ditemukan.", "images/check-gif.gif");
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
      SplashController()
          .showConfirmationDialog2("Swafoto", "Ambil foto sekarang?", () {
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
            customSnackbar1("Tidak bisa melanjutkan tanpa foto");
          }
        });
      });
    } else {
      SplashController()
          .showConfirmationDialog2("Presensi", "Anda ingin pulang?", () {
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
            customSnackbar1("Tidak bisa melanjutkan tanpa foto");
          }
        });
      });
    }
  }

  mulaiAbsen() async {
    SplashController()
        .showConfirmationDialog2("Swafoto", "Ambil foto sekarang?", () {
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
          customSnackbar1("Tidak bisa melanjutkan tanpa foto");
        }
      });
    });
  }

  mulaiPulang(context, idAbsen) {
    SplashController().showConfirmationDialog2("Presensi", "Anda ingin pulang?",
        () async {
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
    SplashController().showConfirmationDialog2("Presensi", "Anda ingin pulang?",
        () async {
      // Get.back();
      // changePageScreen = 1;
      // update();
      Get.toNamed(RouteName.absen,
          arguments: {"dataAbsen": idAbsen, "pulang": 1});

      await getCurrentLocationPulang2(idAbsen?["id"]);
    });
  }

  mulaiPulangFromNotif(idAbsen) {
    SplashController().showConfirmationDialog2("Presensi", "Anda ingin pulang?",
        () async {
      await getCurrentLocationPulang(idAbsen?["id"]);
    });
  }

  mulaiPulangAct(idAbsen) {
    SplashController()
        .showConfirmationDialog2("Swafoto", "Ambil foto sekarang?", () {
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
          customSnackbar1("Tidak bisa melanjutkan tanpa foto");
        }
      });
    });
  }

  mulaiPulangAct2(idAbsen) {
    SplashController()
        .showConfirmationDialog2("Swafoto", "Ambil foto sekarang?", () {
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
          customSnackbar1("Tidak bisa melanjutkan tanpa foto");
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
      customSnackbarLoading("Mendaftarkan kehadiran...");
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
        // customSnackbar1("Anda sudah absen.");
        box.write(Base.waktuAbsen, DateTime.now().toString());
        box.write(Base.klikAbsen, true);
        Get.offAllNamed(RouteName.home, arguments: 0);
        final now = DateTime.now();
        AwesomeNotificationService()
          ..showNotificationAbsen(now)
          ..showNotificationAfter12Hours(now);
      } else if (response.statusCode == 401) {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        // SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        // Get.snackbar('Oops.. terjadi kesalahan sistem.', response.toString());
        // debugPrint("INI HADIR: " + (response as Response<dynamic>).toString());
        // debugPrint("CODE: " + response.statusCode.toString());
      }
    } catch (e) {
      // customSnackbar1("Menghubungkan kembali...");
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  findIndie(idKaryawan) async {
    try {
      var response = await AbsensiServices().hadirPost(idKaryawan);
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 401) {
        // Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        // SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        // Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        // Get.snackbar('Oops.. terjadi kesalahan sistem.', response.toString());
        // debugPrint("INI HADIR: " + (response as Response<dynamic>).toString());
        // debugPrint("CODE: " + response.statusCode.toString());
      }
    } catch (e) {
      // customSnackbar1("Menghubungkan kembali...");
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  absenPulang(status, idAbsen, [String? tanggal]) async {
    if (idAbsen == null) {
      customSnackbar1("Oops..ID absensi tidak ditemukan");
      return;
    }

    var currentDate = DateTime.now();
    var newDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    debugPrint("ID ABSEN PULANG: $idAbsen");
    try {
      // if (status) {
      //   customSnackbarLoading("Sedang Pulang...");
      // }
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
      print(response);
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
          // Get.snackbar("Anda Sudah Pulang", "waktu telah dihentikan");
          customSnackbar1("Kehadiran hari ini telah terisi.");
          Get.offAllNamed(RouteName.home, arguments: args);
          await HomeController().dataHome();
        } else {
          // Get.snackbar("Mengajukan Izin Berhasil",
          //     "Berhasil mematikan absen sebelumnya. Berhasil mengirimkan izin. Silahkan hubungi admin.");
          Get.offAllNamed(RouteName.home, arguments: args);
          await HomeController().dataHome();
        }
        _showReviewAndClearLiveTracking(user?["idkaryawan"]);
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else if (response.statusCode == 400) {
        debugPrint("STATUS CODE 400");
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
      } else {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        debugPrint("INI PULANG: $response");
      }
    } catch (e) {
      print(e);
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  absenPulang2(status, idAbsen) async {
    debugPrint("PULANG YOYY");
    var currentDate = DateTime.now();
    var newDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    debugPrint("ID ABSEN PULANG: $idAbsen");
    try {
      // if (status) {
      //   customSnackbarLoading("Sedang Pulang...");
      // }
      print(user);
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
      debugPrint("FORMS PULANG 2: $forms");
      var response = await AbsensiServices()
          .pulangPut({'id': idAbsen, 'tanggal': newDate}, forms);
      print(response);
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
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
      } else {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        debugPrint("INI PULANG: $response");
      }
    } catch (e) {
      print(e);
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  absenIzin() async {
    try {
      customSnackbarLoading("Mengajukan surat izin...");
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
          DateTime dateCurrent = DateTime.now();
          String formattedCurrentDate =
              DateFormat("yyyy-MM-dd").format(dateCurrent);
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
        // Get.snackbar(
        //     'Oops.. terjadi kesalahan sistem.', response.body.toString());
      }
    } catch (e) {
      debugPrint("KE CATCH");
      // print(e);
      // customSnackbar1("Terjadi kesalahan");
      box.write(Base.izinAbsen, DateTime.now().toString());
      if (!klikAbsen) {
        Get.back();
        Get.offAllNamed(RouteName.home, arguments: 0);
        await HomeController().dataHome();
      } else {
        final homeCtrl = Get.put(HomeController());
        DateTime dateCurrent = DateTime.now();
        String formattedCurrentDate =
            DateFormat("yyyy-MM-dd").format(dateCurrent);
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
    firebaseService
        .clearAllLiveTracking(broadcasterId)
        .then((idKaryawans) {
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