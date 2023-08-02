import 'package:app/global_resource.dart';

class AbsenController extends GetxController {
  //global
  final box = GetStorage();
  String? currentDate;
  String? fileName;
  PlatformFile? file;
  Map? user;
  //absen
  LatLng currentLocation = const LatLng(5.880241, 95.336574);
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  String? timerRecor = "00:00:00";
  String? waktuAbsen;
  File? formFoto;
  File? formFotoIzin;
  bool disableButton = false;
  bool klikAbsen = false;
  String? alamatLoc;
  // ignore: prefer_typing_uninitialized_variables
  var timer;
  //izin
  Map? perusahaan;
  List? perusahaanList;
  String formIzin = 'Izin';
  String? formDeskripsi;
  String? namaOrang;
  List? izinList = [
    {"nama": "Izin", "value": "Izin"},
    {"nama": "Sakit", "value": "Sakit"},
    {"nama": "Cuti", "value": "Cuti"}
  ];

  @override
  void onInit() async {
    super.onInit();
    user = box.read(Base.dataUser);
    klikAbsen = box.read(Base.klikAbsen) ?? false;
    currentDate = DateTime.now().toString();
    user = await ProfileController().dataProfile(user?['alamatEmail']);
    await dataPerusahaan();
    startTimer();
    getCurrentLocation();
  }

  startTimer() {
    final homeCtrl = Get.put(HomeController());
    var findData = homeCtrl.absen?.firstWhere(
      (element) =>
          element?["idkaryawan"] == user?["idkaryawan"] &&
          element?["waktuCheckOut"] == null,
      orElse: () => null,
    );
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (klikAbsen) {
        timerRecor = timerAbsen();
      } else if (findData != null) {
        timerRecor = timerAbsen2(findData?["waktuCheckIn"]);
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
    disableButton = true;

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
    disableButton = false;
    update();
    lokasiDetect();
  }

  lokasiDetect() async {
    disableButton = true;
    customSnackbarLoadingAsset(
        "Mencari titik lokasi anda...", "images/map-pin-gif.gif");
    Future.delayed(Duration(seconds: 3), () {
      Get.back();
      customSnackbarLoadingAsset(
          "Titik lokasi anda ditemukan.", "images/check-gif.gif");
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    });
    // customSnackbarLoading("Sedang mendeteksi lokasi anda...");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocation = LatLng(position.latitude, position.longitude);
      getAddressFromLatLng();
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
        disableButton = false;
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

  mulaiSelesaiAbsen(context, idAbsen) {
    if (!klikAbsen) {
      SplashController()
          .showConfirmationDialog2("Verifikasi Wajah", "Yuk selfie...", () {
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
        absenPulang(true, idAbsen);
      });
    }
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
      } else if (response.statusCode == 401) {
        Get.back();
        // SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        // Get.snackbar('Terjadi gangguan sistem.', response.toString());
        // print("INI HADIR: " + (response as Response<dynamic>).toString());
        // print("CODE: " + response.statusCode.toString());
      }
    } catch (e) {
      customSnackbar1("Menghubungkan kembali...");
    }
  }

  absenPulang(status, idAbsen) async {
    var currentDate = DateTime.now();
    var newDate =
        new DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    print(idAbsen);
    try {
      // if (status) {
      //   customSnackbarLoading("Sedang Pulang...");
      // }
      var response = await AbsensiServices()
          .pulangPut({'id': idAbsen, 'tanggal': newDate}, {});
      if (response.statusCode == 200) {
        Get.back();
        box.write(Base.klikAbsen, false);
        await HomeController().cancelTimer();
        await cancelTimer();
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
        Get.back();
        customSnackbar1("Terjadi gangguan sistem.");
      } else {
        Get.back();
        customSnackbar1("Terjadi gangguan sistem.");
        print("INI PULANG: " + response.toString());
      }
    } catch (e) {
      print(e);
      customSnackbar1("Terjadi gangguan sistem.");
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
        //     'Terjadi gangguan sistem.', response.body.toString());
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
