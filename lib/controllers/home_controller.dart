import 'package:app/data/models/company.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/global_resource.dart';

final HomeController _homeController = HomeController._();

class HomeController extends GetxController {
  HomeController._();

  factory HomeController() => _homeController;

  //Global
  final box = GetStorage();
  DateTime now = DateTime.now();
  final focus = FocusNode();
  Company perusahaan = const Company();
  Map? user;
  String? currentDate;
  var timerRecor = "00:00:00";

  //home
  List? absen = [];
  List? izin = [];
  List? perusahaanList = [];
  String? perusahaanTerpilih;
  bool klikAbsen = false;
  bool? isPresentHadir = false;
  bool? isPresentIzin = false;

  // ignore: prefer_typing_uninitialized_variables
  var timer;

  //search
  String? search = '';
  List? searchHasil = [];

  //undangan
  String? emailUndangan;

  Profile? get userProfile {
    if (user == null) return null;

    try {
      return Profile.fromJson(user!.cast());
    } catch (_) {
      return null;
    }
  }

  bool get isToday {
    if (currentDate != null) {
      final currentDate = DateTime.tryParse(this.currentDate!)?.toLocal();
      if (currentDate != null &&
          currentDate.year == now.year &&
          currentDate.month == now.month &&
          currentDate.day == now.day) {
        return true;
      }
    }

    return false;
  }

  @override
  void onInit() async {
    // await Permission.location.serviceStatus.isEnabled.then((value) {
    //   debugPrint("LOCATION: " + value.toString());
    //   if (!value) {
    //     Permission.location.request();
    //   }
    // });
    debugPrint("TOKEN: ${GetStorage().read("tokens")}");
    debugPrint("KLIK ABSEN: $klikAbsen");
    super.onInit();
    user = box.read(Base.dataUser);
    klikAbsen = GetStorage().read(Base.klikAbsen) ?? false;
    currentDate = now.toString();
    await dataPerusahaan();
    await dataHome();
    // await checkAnyAbsen();
    // await checkIsAbsen();
  }

  startTimer() {
    // var findData = absen?.firstWhere(
    //   (element) =>
    //       element?["idkaryawan"] == user?["idkaryawan"] &&
    //       element?["waktuCheckOut"] == null,
    //   orElse: () => null,
    // );
    // var checkData = absen?.firstWhere(
    //   (element) => element?["idkaryawan"] == user?["idkaryawan"],
    //   orElse: () => null,
    // );

    // if (checkData == null) {
    //   box.remove(Base.klikAbsen);
    //   box.remove(Base.waktuAbsen);
    //   cancelTimer();
    // }

    // if (findData != null)
    //   box.write(Base.waktuAbsen, findData?["waktuCheckIn"].toString());

    // DateTime startAbsen = DateTime.parse(GetStorage().read(Base.waktuAbsen));

    // timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   Duration timeDifference = DateTime.now().difference(startAbsen);
    //   bool moreThan12HoursPassed =
    //       timeDifference.inHours > 11; // waktu kerja sudah > dari 12 jam
    //   // checkAnyAbsen();
    //   // if (findData != null && moreThan12HoursPassed) {
    //   //   timerRecor = "00:00:00";
    //   //   cancelTimer();
    //   //   isPresentHadir = true;
    //   //   isPresentIzin = true;
    //   //   var findData = await AbsenController().findIndie(user?['idkaryawan']);

    //   //   await IzinController().absenPulang(false, findData?[0]["id"]);
    //   // } else if (moreThan12HoursPassed) {
    //   //   timerRecor = "00:00:00";
    //   //   cancelTimer();
    //   //   isPresentHadir = true;
    //   //   isPresentIzin = true;
    //   //   var findData = await AbsenController().findIndie(user?['idkaryawan']);

    //   //   await IzinController().absenPulang(false, findData?[0]["id"]);
    //   // } else
    //   if (klikAbsen) {
    //     debugPrint("KE ELSE IF 1");
    //     timerRecor = timerAbsen();
    //   } else if (findData != null) {
    //     debugPrint("KE ELSE IF 2");
    //     timerRecor = timerAbsen2(findData?["waktuCheckIn"]);
    //     box.write(Base.waktuAbsen, findData?["waktuCheckIn"].toString());
    //     box.write(Base.klikAbsen, true);
    //     klikAbsen = GetStorage().read(Base.klikAbsen);
    //     update();
    //   } else {
    //     timerRecor = "00:00:00";
    //     cancelTimer();
    //   }
    //   // print(findData)
    //   update();
    // });
  }

  cancelTimer() {
    debugPrint("CANCEL TIMER HOME");
    timer?.cancel();
    timer = null;
  }

  absensi(context) async {
    if (izinAbs()) {
      customSnackbar1("Izin hari ini telah terisi.");
    } else {
      if (klikAbsen) {
        debugPrint('$absen');
        debugPrint("=======KE PULANG========");
        var tanggal = currentDate.toString().split(" ")[0];
        var response =
            await AbsensiServices().findIndiv(user?["idkaryawan"], tanggal);
        debugPrint("DATA ABSEN: ${response.data.length}");

        box.write(Base.waktuAbsen, response.data?[0]["waktuCheckIn"]);
        Get.back();
        Get.toNamed(
          RouteName.absen,
          arguments: {"dataAbsen": response.data?[0], "pulang": 1},
        );
      } else {
        if (await Permission.camera.isGranted &&
            await Permission.location.isGranted) {
          Get.toNamed(RouteName.absen);
        } else {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (ctx) => const DialogPermission(),
          );
        }
      }
    }
  }

  pilihPerusahaan(id) async {
    box.remove(Base.perusahaanTerpilih);
    box.write(Base.perusahaanTerpilih, id);
    absen?.removeRange(0, absen!.length);
    izin?.removeRange(0, izin!.length);
    await dataPerusahaan();
    await dataHome();
    Get.back();
    Get.snackbar("Perusahaan Telah Diganti !!",
        "data perusahaan yang digunakan sudah berubah");
  }

  gantiTanggal(tgl) {
    if (tgl != null) {
      debugPrint("======== TEST GANTI TANGGAL =======");
      currentDate = tgl.toString();
      absen?.removeRange(0, absen!.length);
      izin?.removeRange(0, izin!.length);
      update();
      dataHome();
      checkAnyAbsen();
    }
  }

  checkAnyAbsen() async {
    cancelTimer();
    var tanggal = currentDate.toString().split(" ")[0];
    bool isDateGreaterThanToday = isGreaterThanToday(currentDate.toString());
    bool isDateSmallerThanToday = isSmallerThanToday(currentDate.toString());

    var findData = izin?.firstWhere(
      (element) => element?["idkaryawan"] == user?['idkaryawan'],
      orElse: () => null,
    );

    if (isDateSmallerThanToday == false) {
      isPresentHadir = false;
      isPresentIzin = false;
    }
    if (isDateGreaterThanToday == false) {
      isPresentHadir = false;
      isPresentIzin = false;
    }

    try {
      var response =
          await AbsensiServices().findIndiv(user?["idkaryawan"], tanggal);
      debugPrint("DATA ABSEN: ${response.data.length}");
      if (response.data.length >= 1 &&
          response.data?[0]["waktuCheckOut"] == null) {
        // timer!.cancel();
        debugPrint("ABSEN JALAN YOYY");

        box.write(Base.waktuAbsen, response.data[0]?["waktuCheckIn"]);
        box.write(Base.klikAbsen, true);
        klikAbsen = GetStorage().read(Base.klikAbsen);
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          timerRecor = timerAbsen3(response.data[0]?["waktuCheckIn"], null);
          update();
        });
      } else if (response.data.length == 0 && isDateGreaterThanToday ||
          isDateSmallerThanToday) {
        // timer.cancel();
        debugPrint("ABSEN GK JALAN YOYY");
        timerRecor = "00:00:00";
        timer = null;
        cancelTimer();
        box.remove(Base.waktuAbsen);
        box.write(Base.klikAbsen, false);
        klikAbsen = GetStorage().read(Base.klikAbsen);
        if (isDateSmallerThanToday) {
          isPresentHadir = true;
          isPresentIzin = true;
        }

        if (isDateGreaterThanToday) {
          isPresentHadir = true;
          isPresentIzin = true;
        }
        update();
      } else {
        debugPrint(" ==== KE ELSE CHECK ANY ABSEN ====");
        print(isDateGreaterThanToday);
        print(isDateSmallerThanToday);
        timer = null;
        timerRecor = "00:00:00";
        box.remove(Base.waktuAbsen);
        box.write(Base.klikAbsen, false);
        klikAbsen = GetStorage().read(Base.klikAbsen);
        cancelTimer();

        if (isDateSmallerThanToday) {
          isPresentHadir = true;
          isPresentIzin = true;
        }

        if (isDateGreaterThanToday) {
          isPresentHadir = true;
          isPresentIzin = true;
        }

        if (response.data.length >= 1 &&
            response.data?[0]["waktuCheckOut"] != null) {
          isPresentHadir = true;
          isPresentIzin = true;
        }

        update();
      }
    } catch (e) {
      // customSnackbar1('Oops.. terjadi kesalahan sistem.');
      debugPrint("KE CATCH CHECK ANY ABSEN");
      print(e);
    }

    if (findData != null) {
      debugPrint("IZIN DATA: $findData");
      isPresentHadir = true;
      isPresentIzin = true;
      update();
    }

    debugPrint("IS HADIR: $isPresentHadir");
    debugPrint("IS IZIN: $isPresentIzin");
  }

  gambarAbsen(data, status) {
    if (data['fotoPulang'] != null) {
      if (status == 1) {
        return changeUrlImage(
            data['fotoPulang'] ?? 'assets/icons/logo/hora.png');
      } else {
        return data['fotoPulang'] == null ? true : false;
      }
    } else if (data['fotoKaryawan'] != null) {
      if (status == 1) {
        return changeUrlImage(
            data['fotoKaryawan'] ?? 'assets/icons/logo/hora.png');
      } else {
        return data['fotoKaryawan'] == null ? true : false;
      }
    } else {
      if (status == 1) {
        return changeUrlImage(data['iconIjin'] ?? 'assets/icons/logo/hora.png');
      } else {
        return data['iconIjin'] == null ? true : false;
      }
    }
  }

  gambarSearch(data, status) {
    if (status == 1) {
      return changeUrlImage(data['foto'] ?? 'assets/icons/logo/hora.png');
    } else {
      return data['foto'] == null ? true : false;
    }
  }

  gambarPerusahaan(data, status) {
    if (status == 1) {
      return changeUrlImage(
          data['logoPerusahaan'] ?? 'assets/icons/logo/hora.png');
    } else {
      return data['logoPerusahaan'] == null ? true : false;
    }
  }

  dataPerusahaan() async {
    try {
      var response =
          await HomeServices().perusahaanGet({'email': user?['alamatEmail']});
      if (response.statusCode == 200) {
        box.write(Base.dataPerusahaan, jsonEncode(response.data));
        perusahaanTerpilih = box.read(Base.perusahaanTerpilih);
        var hasil = jsonDecode(box.read(Base.dataPerusahaan));
        perusahaanList = hasil;
        if (perusahaanTerpilih == null) {
          perusahaan = Company.fromJson(hasil[0]);
        } else {
          perusahaan = Company.fromJson(hasil
              .where((value) => value['idperusahaan'] == perusahaanTerpilih)
              .toList()[0]);
        }
        update();
      } else if (response.statusCode == 401) {
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        // SplashController().sessionHabis(user?['alamatEmail']);
        // Get.snackbar('Sesi habis', '');
        customSnackbar1("Menghubungkan kembali...");
      }
    } catch (e) {
      debugPrint("ERROR PERUSAHAAN: $e");
      // SplashController().sessionHabis(user?['alamatEmail']);
      // Get.snackbar('Sesi habis', '');
      customSnackbar1("Menghubungkan kembali...");
    }
  }

  dataHome() async {
    final profile = userProfile;
    if (profile == null) {
      customSnackbar1('Data user tidak ditemukan');
      return;
    }

    if (profile.perusahaanId ==  null) {
      customSnackbar1('Data perusahaan tidak ditemukan');
      return;
    }

    final request = {
      "idperusahaan": profile.perusahaanId!,
      "tanggal": currentDate ?? kMysqlDateFormat.format(DateTime.now()),
    };

    try {
      var absens = await HomeServices().absenGet(request);

      var izins = await HomeServices().izinGet(request);

      if (absens.statusCode == 200 && izins.statusCode == 200) {
        absen = absens.data;
        izin = izins.data;
        box.remove(Base.dataAbsen);
        box.write(Base.dataAbsen, jsonEncode(absen));
        checkAnyAbsen();
        // checkIsAbsen();
        // checkIsIzin();
        update();
      }
    } catch (e) {
      print(e);
      // customSnackbar1("")
    }
  }

  searchFunc(value) async {
    search = value ?? '';
    Future.delayed(const Duration(seconds: 2)).then((value) => dataSearch());
  }

  dataSearch() async {
    try {
      var response = search == ''
          ? await HomeServices()
              .searchPerusahaanGet({'idperusahaan': perusahaan.id})
          : await HomeServices()
              .searchUserGet({'idperusahaan': perusahaan.id, 'nama': search});
      if (response.statusCode == 200) {
        searchHasil?.removeRange(0, searchHasil!.length);
        searchHasil?.addAll(
            search == '' ? response.body ?? [] : response.body?['view']);
        update();
      } else if (response.statusCode == 401) {
        SplashController().sessionHabis(user?['alamatEmail']);
      }
      // else {
      //   Get.snackbar('Search Gagal Dijalankan', response.body.toString());
      // }
    } catch (e) {
      // print(e);
      // Get.snackbar('Oops.. terjadi kesalahan sistem.', e.toString());
    }
  }

  kirimUndangan() async {
    var isValidEmail = isEmailValid(emailUndangan.toString());
    if (!isValidEmail) {
      customSnackbar1("Silakan masuk kembali.");
      return;
    }

    try {
      customSnackbarLoading("Mengirimkan undangan...");
      var response = await HomeServices().undanganPost({
        'receiver': emailUndangan,
        'sender': user?['alamatEmail'],
        'idperusahaan': perusahaan.id,
        'namaPerusahaan': perusahaan.name,
      });
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        customSnackbar1('Undangan terkirim.');
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1('Email telah terdaftar');
      }
    } catch (e) {
      customSnackbar1("Menghubungkan kembali...");
    }
  }

  doneAbsensi() {
    isPresentHadir = true;
    isPresentIzin = true;
    update();
  }

// checkIsAbsen() {
//   debugPrint("CHECK ABS");
//   DateTime dateCurrent = DateTime.now();
//   String formattedCurrentDate = DateFormat("yyyy-MM-dd").format(dateCurrent);
//   var idKaryawan = user?["idkaryawan"];

//   var findDataIzin = izin?.firstWhere(
//     (element) => element?["idkaryawan"] == idKaryawan,
//     orElse: () => null,
//   );

//   var findData = absen?.firstWhere(
//     (element) =>
//         element?["idkaryawan"] == idKaryawan &&
//         element?["waktuCheckOut"] == null,
//     orElse: () => null,
//   );

//   var findDataPulang = absen?.firstWhere(
//     (element) =>
//         element?["idkaryawan"] == idKaryawan &&
//         element?["waktuCheckOut"] != null,
//     orElse: () => null,
//   );

//   if (findDataIzin != null) {
//     isPresentHadir = true;
//     // cancelTimer();
//     update();
//   } else if (findData != null) {
//     debugPrint("KESEINI ELSE IF 2");
//     isPresentHadir = false;
//     update();
//   } else if (findDataPulang != null) {
//     isPresentHadir = true;
//     // cancelTimer();
//     update();
//   } else if (findData != null && findDataPulang != null) {
//     debugPrint("KESINI ELSE IF 3");
//     isPresentHadir = true;
//     // cancelTimer();
//     update();
//   } else {
//     debugPrint("KESINI ELSE");
//     isPresentHadir = false;
//     update();
//   }
// }

// checkIsIzin() {
//   debugPrint("CHECK izn");
//   DateTime dateCurrent = DateTime.now();
//   String formattedCurrentDate = DateFormat("yyyy-MM-dd").format(dateCurrent);
//   var idKaryawan = user?["idkaryawan"];
//   bool isDateGreaterThanToday = isGreaterThanToday(currentDate.toString());
//   bool isDateSmallerThanToday = isSmallerThanToday(currentDate.toString());

//   var findData = izin?.firstWhere(
//     (element) => element?["idkaryawan"] == idKaryawan,
//     orElse: () => null,
//   );

//   var findDataAbs = absen?.firstWhere(
//     (element) =>
//         element?["idkaryawan"] == idKaryawan &&
//         element?["waktuCheckOut"] != null,
//     orElse: () => null,
//   );

//   if (findData != null) {
//     isPresentIzin = true;
//     // cancelTimer();
//     update();
//   } else if (findDataAbs != null) {
//     isPresentIzin = true;
//     // cancelTimer();
//     update();
//   } else if (findData != null && findDataAbs != null) {
//     isPresentIzin = true;
//     // cancelTimer();
//     update();
//   } else {
//     isPresentIzin = false;
//     update();
//   }
// }
}
