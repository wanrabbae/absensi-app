import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';

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
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
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
          element?["idkaryawan"] == user?["idkaryawan"] &&
          element?["waktuCheckOut"] != null,
      orElse: () => null,
    );

    var findDataIzin = homeCtrl.izin?.firstWhere(
      (element) => element?["idkaryawan"] == user?["idkaryawan"],
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
      print("BELUM ABSEN");
      getCurrentLocation();
    }

    var findDataOnCheckIn = homeCtrl.absen?.firstWhere(
      (element) => element?["idkaryawan"] == user?["idkaryawan"],
      orElse: () => null,
    );

    if (klikAbsen && timer?.isActive) {
      print("TEST TOAST");
      print("DATA CHECKIN: " + findDataOnCheckIn.toString());
      print("STATUS STATE: " + statusState.toString());
      mulaiPulangRevisi1(findDataOnCheckIn?['id']);
    }
  }

  updateStatusStateFromNotif() {
    print("UPDATE STATE YOYY");
    statusState = "dariNotif";
    update();
  }

  startTimer() {
    final homeCtrl = Get.put(HomeController());
    var findData = homeCtrl.absen?.firstWhere(
      (element) =>
          element?["idkaryawan"] == user?["idkaryawan"] &&
          element?["waktuCheckOut"] == null,
      orElse: () => null,
    );

    var checkData = homeCtrl.absen?.firstWhere(
      (element) => element?["idkaryawan"] == user?["idkaryawan"],
      orElse: () => null,
    );

    if (checkData == null) {
      print("===== CHECK DATA NULL ====");
      box.remove(Base.klikAbsen);
      box.remove(Base.waktuAbsen);
      cancelTimer();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (klikAbsen) {
        print("KE IF TIMER 1");
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
    print("CANCEL TIMER ABSEN");
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
    bool serviceEnabled;
    LocationPermission permission;

    await Permission.location.serviceStatus.isEnabled.then((value) {
      print("LOCATION: " + value.toString());
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
      customSnackbar1("Lokasi Tidak Aktif");
      return false;
    }
    update();
    lokasiDetect();
  }

  lokasiDetect() async {
    customSnackbarLoadingAsset(
        "Mencari titik lokasi anda...", "images/map-pin-gif.gif");
    // print("========== TEST TOST YOYYYY =======");
    // customSnackbarLoading("Sedang mendeteksi lokasi anda...");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocation = LatLng(position.latitude, position.longitude);
      getAddressFromLatLng();

      Get.back();
      customSnackbarLoadingAsset(
          "Titik lokasi anda ditemukan.", "images/check-gif.gif");
      Future.delayed(
        Duration(seconds: 2),
        () {
          Get.back();
          mulaiAbsen();
        },
      );
      await googleMapController.future.then((newController) {
        BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(textDirection: TextDirection.ltr),
                "assets/icons/map-pin.png")
            .then((value) => customMarker = value);
        newController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 15),
          ),
        );
      });
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

  lokasiDetectPulang(idAbsen) async {
    print("ID ABSEN FROM DETECTED: " + idAbsen.toString());
    customSnackbarLoadingAsset(
        "Mencari titik lokasi anda...", "images/map-pin-gif.gif");
    // customSnackbarLoading("Sedang mendeteksi lokasi anda...");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocationPulang = LatLng(position.latitude, position.longitude);
      getAddressFromLatLngPulang();
      Get.back();
      customSnackbarLoadingAsset(
          "Titik lokasi anda ditemukan.", "images/check-gif.gif");
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
        mulaiPulangAct(idAbsen);
      });
      await googleMapController.future.then((newController) {
        BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(textDirection: TextDirection.ltr),
                "assets/icons/map-pin.png")
            .then((value) => customMarker = value);
        newController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 15),
          ),
        );
      });
      update();
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
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
        mulaiPulangAct2(idAbsen);
      });

      await googleMapController.future.then((newController) {
        BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(textDirection: TextDirection.ltr),
                "assets/icons/map-pin.png")
            .then((value) => customMarker = value);
        newController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 15),
          ),
        );
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

  getAddressFromLatLngPulang() async {
    await placemarkFromCoordinates(
            currentLocationPulang.latitude, currentLocationPulang.longitude)
        .then((List<Placemark> placemarks) {
      alamatLocPulang =
          "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode} ";
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
        await AwesomeNotificationService()
            .showNotificationAbsen(DateTime.now().toString());
        await AwesomeNotificationService()
            .showNotificationAfter12Hours(DateTime.now().toString());
      } else if (response.statusCode == 401) {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        // SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        // Get.snackbar('Oops.. terjadi kesalahan sistem.', response.toString());
        // print("INI HADIR: " + (response as Response<dynamic>).toString());
        // print("CODE: " + response.statusCode.toString());
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
        // print("INI HADIR: " + (response as Response<dynamic>).toString());
        // print("CODE: " + response.statusCode.toString());
      }
    } catch (e) {
      // customSnackbar1("Menghubungkan kembali...");
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  absenPulang(status, idAbsen) async {
    var currentDate = DateTime.now();
    var newDate =
        new DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    print("ID ABSEN PULANG: " + idAbsen.toString());
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
        await AwesomeNotificationService().removeNotification();
        Get.back();
        box.write(Base.klikAbsen, false);
        box.remove(Base.waktuAbsen);
        await HomeController().cancelTimer();
        await cancelTimer();
        await AwesomeNotificationService().showNotificationAbsenDone();
        if (status) {
          // Get.snackbar("Anda Sudah Pulang", "waktu telah dihentikan");
          customSnackbar1("Kehadiran hari ini telah terisi.");
          Get.offAllNamed(RouteName.home, arguments: 0);
          await HomeController().dataHome();
        } else {
          // Get.snackbar("Mengajukan Izin Berhasil",
          //     "Berhasil mematikan absen sebelumnya. Berhasil mengirimkan izin. Silahkan hubungi admin.");
          Get.offAllNamed(RouteName.home, arguments: 0);
          await HomeController().dataHome();
        }
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else if (response.statusCode == 400) {
        print("STATUS CODE 400");
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
      } else {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
        print("INI PULANG: " + response.toString());
      }
    } catch (e) {
      print(e);
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  absenPulang2(status, idAbsen) async {
    print("PULANG YOYY");
    var currentDate = DateTime.now();
    var newDate =
        new DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    print("ID ABSEN PULANG: " + idAbsen.toString());
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
      print("FORMS PULANG 2: " + forms.toString());
      var response = await AbsensiServices()
          .pulangPut({'id': idAbsen, 'tanggal': newDate}, forms);
      print(response);
      if (response.statusCode == 200) {
        await AwesomeNotificationService().removeNotification();
        box.write(Base.klikAbsen, false);
        box.remove(Base.waktuAbsen);
        await HomeController().cancelTimer();
        await cancelTimer();
        await AwesomeNotificationService().showNotificationAbsenDone();
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
        print("INI PULANG: " + response.toString());
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
              (element) => element?["idkaryawan"] == user?["idkaryawan"],
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
      print("KE CATCH");
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
            (element) => element?["idkaryawan"] == user?["idkaryawan"],
            orElse: () => null);

        absenPulang(false, findData?["id"]);
      }
    }
  }
}
