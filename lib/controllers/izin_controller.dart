import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'dart:core';


class IzinController extends GetxController {
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
  String? timerRecor = "00:00";
  String? waktuAbsen;
  File? formFoto;
  File? formFotoIzin;
  bool klikAbsen = false;
  String? alamatLoc;
  // ignore: prefer_typing_uninitialized_variables
  var timer;
  //izin
  Map? perusahaan;
  List? perusahaanList;
  String? formIzin;
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
    startTimer();
    await dataPerusahaan();
    getCurrentLocation();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (klikAbsen) {
        timerRecor = timerAbsen();
      } else {
        timerRecor = "00:00";
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
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      // If permission is not granted, request it
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // If the user denies the permission, open app settings
        SplashController().showConfirmationDialog2(
            "Perizinan", "Buka pengaturan perizinan perangkat?", () {
          // Redirect to allow location setting on phone
          openAppSettings();
        });
        return false;
      }
    }

    // lokasiDetect();
  }

  lokasiDetect() async {
    customSnackbarLoading("Sedang mendeteksi lokasi anda...");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentLocation = LatLng(position.latitude, position.longitude);
      getAddressFromLatLng();
      await googleMapController.future.then((newController) {
        BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(size: Size(800, 800)),
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
      // Get.back();
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

  updateFile(isFoto) async {
    // FilePicker
    if (isFoto == true) {
      await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50)
          .then((value) {
        if (value != null) {
          updateFileFromFoto(PlatformFile(
            name: value.name,
            path: value.path,
            size: 0,
          ));
        }
      });
    } else {
      await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowCompression: true,
          allowedExtensions: [
            'jpg',
            'png',
            'jpeg',
            'pdf',
            'doc'
          ]).then((result) {
        if (result != null) {
          file = result.files.first;
          fileName = "${file?.name} (${file?.size})";
          update();
        }
      });
    }
  }

  updateFileFromFoto(foto) async {
    // FilePicker
    file = foto as PlatformFile;
    fileName = "${file?.name}";
    update();
  }

  clearFile() async {
    file = null;
    fileName = null;
    update();
  }

  updateFormIzin(value) {
    formIzin = value;
    update();
  }

  absenPulang(status, idAbsen) async {
    var currentDate = DateTime.now();
    var newDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    debugPrint("ID ABSEN: $idAbsen");
    try {
      if (status) {
        // customSnackbarLoading("Sedang Pulang...");
      }

      String assetFilePath = 'assets/icons/logo/hora.png';
      File tempFile = await readAssetFileImg(assetFilePath, 'horas.png');

      final forms = {
        'LatitudePulang': "user.zin",
        'LongtitudePulang': "user.izin",
        'NamaKaryawan': user?['namaKaryawan'],
        'Foto': {
          'filePath': tempFile.path,
          'fileName': tempFile.path.split("/").last
        },
        'AlamatPulang': "-",
      };
      debugPrint("FORM: $forms");
      var response = await AbsensiServices()
          .pulangPut({'id': idAbsen, 'tanggal': newDate}, forms);
      if (response.statusCode == 200) {
        await AwesomeNotificationService().removeNotification();
        tempFile.delete();
        // Get.back();
        box.write(Base.klikAbsen, false);
        box.remove(Base.waktuAbsen);
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
        box.write(Base.klikAbsen, false);
        Get.offAllNamed(RouteName.home, arguments: 0);
        // customSnackbar1("Terjadi kesalahan Pada Absen Pulang");
      } else {
        debugPrint("INI PULANG: $response");
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
      }
    } catch (e) {
      print(e);
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  absenPulangLogOut(status, idAbsen) async {
    var currentDate = DateTime.now();
    var newDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    debugPrint("ID ABSEN: $idAbsen");
    try {
      if (status) {
        // customSnackbarLoading("Sedang Pulang...");
      }

      String assetFilePath = 'assets/icons/logo/hora.png';
      File tempFile = await readAssetFileImg(assetFilePath, 'horas.png');

      final forms = {
        'LatitudePulang': "user.zin",
        'LongtitudePulang': "user.izin",
        'NamaKaryawan': user?['namaKaryawan'],
        'Foto': {
          'filePath': tempFile.path,
          'fileName': tempFile.path.split("/").last
        },
        'AlamatPulang': "-",
      };
      debugPrint("FORM: $forms");
      var response = await AbsensiServices()
          .pulangPut({'id': idAbsen, 'tanggal': newDate}, forms);
      if (response.statusCode == 200) {
        await AwesomeNotificationService().removeNotification();
        tempFile.delete();
        // Get.back();
        box.write(Base.klikAbsen, false);
        box.remove(Base.waktuAbsen);
        await HomeController().cancelTimer();
        await cancelTimer();
        debugPrint("KELUARRR");
        ProfileController().keluar();
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else if (response.statusCode == 400) {
        box.write(Base.klikAbsen, false);
        Get.offAllNamed(RouteName.home, arguments: 0);
        customSnackbar1("Terjadi kesalahan Pada Absen Pulang");
      } else {
        debugPrint("INI PULANG: $response");
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
      }
    } catch (e) {
      print(e);
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  absenIzin() async {
    if (fileName == null) {
      customSnackbar1("Lengkapi lampiran terlebih dahulu.");
      return;
    }

    try {
      customSnackbarLoading("Mengajukan surat izin...");
      var forms = {
        'idkaryawan': user?['idkaryawan'],
        'namaKaryawan': user?['namaKaryawan'],
        'Keterangan': formDeskripsi,
        'Ijin': formIzin,
        'DokumenIjin': {
          "path": file!.path,
          "name": file!.name,
        },
        'idperusahaan': perusahaan?['idperusahaan'],
        'namaPerusahaan': perusahaan?['namaPerusahaan']
      };
      var response = await AbsensiServices().izinPost(forms);
      debugPrint("RESPONSE: $response");
      if (response.statusCode == 200) {
        debugPrint("RESPON 200");
        box.write(Base.izinAbsen, DateTime.now().toString());
        if (!klikAbsen) {
          Get.back();
          Get.offAllNamed(RouteName.home, arguments: 0);
          await HomeController().doneAbsensi();
          await HomeController().dataHome();
        } else {
          debugPrint("KE ELESE");
          final homeCtrl = Get.put(HomeController());
          var findData = await homeCtrl.absen?.firstWhere(
              (element) => element?["idKaryawan"] == user?["idkaryawan"],
              orElse: () => null);

          if (findData?["id"] == null) return;
          absenPulang(false, findData?["id"]);
        }
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1('Oops.. terjadi kesalahan sistem.');
        // Get.snackbar(
        //     'Oops.. terjadi kesalahan sistem.', response.body.toString());
      }
    } catch (e) {
      print(e.toString());
      debugPrint("KE CATCH FITUR IZIN");
      Get.back();
      customSnackbar1('Oops.. terjadi kesalahan sistem.');
    }
  }
}
