import 'package:app/controllers/izin_controller.dart';
import 'package:app/global_resource.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeController extends GetxController {
  //Global
  final box = GetStorage();
  DateTime now = DateTime.now();
  final focus = FocusNode();
  Map? perusahaan;
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

  @override
  void onInit() async {
    print("TOKEN: " + GetStorage().read("tokens"));
    print("KLIK ABSEN: " + klikAbsen.toString());
    super.onInit();
    user = box.read(Base.dataUser);
    klikAbsen = GetStorage().read(Base.klikAbsen) ?? false;
    currentDate = now.toString();
    await dataPerusahaan();
    await dataHome();
    await startTimer();
    await checkIsAbsen();
  }

  startTimer() {
    var findData = absen?.firstWhere(
      (element) =>
          element?["idkaryawan"] == user?["idkaryawan"] &&
          element?["waktuCheckOut"] == null,
      orElse: () => null,
    );

    if (findData != null)
      box.write(Base.waktuAbsen, findData?["waktuCheckIn"].toString());

    DateTime startAbsen = DateTime.parse(GetStorage().read(Base.waktuAbsen));

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      print("TIMER: " + timer.toString());

      Duration timeDifference = DateTime.now().difference(startAbsen);
      bool moreThan8HoursPassed =
          timeDifference.inHours > 11; // waktu kerja sudah > dari 12 jam

      if (findData != null && moreThan8HoursPassed) {
        timerRecor = "00:00:00";
        cancelTimer();
        isPresentHadir = true;
        isPresentIzin = true;
        var findData = await absen?.firstWhere(
            (element) => element?["idkaryawan"] == user?["idkaryawan"],
            orElse: () => null);

        await IzinController().absenPulang(false, findData?["id"]);
      } else if (klikAbsen) {
        timerRecor = timerAbsen();
      } else if (findData != null) {
        print("KE ELSE IF");
        timerRecor = timerAbsen2(findData?["waktuCheckIn"]);
        box.write(Base.waktuAbsen, findData?["waktuCheckIn"].toString());
        box.write(Base.klikAbsen, true);
        klikAbsen = GetStorage().read(Base.klikAbsen);
        update();
      } else {
        timerRecor = "00:00:00";
        cancelTimer();
      }
      update();
    });
  }

  cancelTimer() {
    print("CANCEL TIMER HOME");
    timer?.cancel();
    timer = null;
  }

  absensi(context) async {
    if (izinAbs()) {
      customSnackbar1("Izin hari ini telah terisi.");
    } else {
      if (!klikAbsen) {
        if (await Permission.camera.isGranted &&
            await Permission.location.isGranted) {
          // var IsPresent = await absen!.firstWhere(
          //     (element) => element["idkaryawan"] == user?["idkaryawan"]);

          // if (absen!.length > 0 && IsPresent != null) {
          //   customSnackbar1("Kehadiran hari ini telah terisi.");
          // } else {
          Get.back();
          Get.toNamed(RouteName.absen);
          // }
        } else {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              context: context,
              builder: (ctx) => const DialogPermission()).then((value) {
            if (value != null) {
              Get.back();
              Get.toNamed(RouteName.absen);
            }
          });
        }
      } else {
        print(absen);
        print("KE PULANG");
        var currentAbsen = absen?.firstWhere(
          (element) =>
              element['idkaryawan'] == user?['idkaryawan'] &&
              element?["waktuCheckOut"] == null,
          orElse: () => null,
        );
        Get.back();
        Get.toNamed(RouteName.absen, arguments: {"dataAbsen": currentAbsen});
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
      currentDate = tgl.toString();
      absen?.removeRange(0, absen!.length);
      izin?.removeRange(0, izin!.length);
      update();
      dataHome();
    }
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
          perusahaan = hasil[0];
        } else {
          perusahaan = hasil
              .where((value) => value['idperusahaan'] == perusahaanTerpilih)
              .toList()[0];
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
      print("ERROR PERUSAHAAN: " + e.toString());
      // SplashController().sessionHabis(user?['alamatEmail']);
      // Get.snackbar('Sesi habis', '');
      customSnackbar1("Menghubungkan kembali...");
    }
  }

  dataHome() async {
    try {
      var absens = await HomeServices().absenGet({
        "idperusahaan": user?['idperusahaan'].toString(),
        "tanggal": currentDate.toString(),
      });

      var izins = await HomeServices().izinGet({
        "idperusahaan": user?['idperusahaan'].toString(),
        "tanggal": currentDate.toString(),
      });

      if (absens.statusCode == 200 && izins.statusCode == 200) {
        absen = absens.data;
        izin = izins.data;
        box.remove(Base.dataAbsen);
        box.write(Base.dataAbsen, jsonEncode(absen));
        checkIsAbsen();
        checkIsIzin();
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
          ? await HomeServices().searchPerusahaanGet(
              {'idperusahaan': perusahaan?['idperusahaan']})
          : await HomeServices().searchUserGet(
              {'idperusahaan': perusahaan?['idperusahaan'], 'nama': search});
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
      customSnackbar1("Format email tidak valid");
      return;
    }

    try {
      customSnackbarLoading("Sedang mengirimkan undangan...");
      var response = await HomeServices().undanganPost({
        'receiver': emailUndangan,
        'sender': user?['alamatEmail'],
        'idperusahaan': perusahaan?['idperusahaan'],
        'namaPerusahaan': perusahaan?['namaPerusahaan']
      });
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        customSnackbar1('Berhasil mengirimkan undangan.');
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1('Oops.. terjadi kesalahan sistem.');
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

  checkIsAbsen() {
    print("CHECK ABS");
    DateTime dateCurrent = DateTime.now();
    String formattedCurrentDate = DateFormat("yyyy-MM-dd").format(dateCurrent);
    var idKaryawan = user?["idkaryawan"];
    bool isDateGreaterThanToday = isGreaterThanToday(currentDate.toString());
    bool isDateSmallerThanToday = isSmallerThanToday(currentDate.toString());

    bool isMidnight = dateCurrent.hour == 0 &&
        dateCurrent.minute == 0 &&
        dateCurrent.second == 0;

    if (isMidnight) {
      isPresentHadir = true;
      isPresentIzin = true;
      cancelTimer();
      update();
      return false;
    }

    var findDataIzin = izin?.firstWhere(
      (element) => element?["idkaryawan"] == idKaryawan,
      orElse: () => null,
    );

    var findData = absen?.firstWhere(
      (element) =>
          element?["idkaryawan"] == idKaryawan &&
          element?["waktuCheckOut"] == null,
      orElse: () => null,
    );

    var findDataPulang = absen?.firstWhere(
      (element) =>
          element?["idkaryawan"] == idKaryawan &&
          element?["waktuCheckOut"] != null,
      orElse: () => null,
    );

    if (isDateGreaterThanToday) {
      isPresentHadir = isDateGreaterThanToday;
      update();
    } else if (isDateSmallerThanToday) {
      isPresentHadir = isDateSmallerThanToday;
      update();
    } else if (findDataIzin != null) {
      isPresentHadir = true;
      // cancelTimer();
      update();
    } else if (findData != null) {
      print("KESEINI");
      isPresentHadir = false;
      update();
    } else if (findDataPulang != null) {
      isPresentHadir = true;
      // cancelTimer();
      update();
    } else if (findData != null && findDataPulang != null) {
      print("KESINI");
      isPresentHadir = true;
      // cancelTimer();
      update();
    } else {
      print("KESINI");
      isPresentHadir = false;
      update();
    }
  }

  checkIsIzin() {
    print("CHECK izn");
    DateTime dateCurrent = DateTime.now();
    String formattedCurrentDate = DateFormat("yyyy-MM-dd").format(dateCurrent);
    var idKaryawan = user?["idkaryawan"];
    bool isDateGreaterThanToday = isGreaterThanToday(currentDate.toString());
    bool isDateSmallerThanToday = isSmallerThanToday(currentDate.toString());

    var findData = izin?.firstWhere(
      (element) => element?["idkaryawan"] == idKaryawan,
      orElse: () => null,
    );

    var findDataAbs = absen?.firstWhere(
      (element) =>
          element?["idkaryawan"] == idKaryawan &&
          element?["waktuCheckOut"] != null,
      orElse: () => null,
    );

    if (isDateGreaterThanToday) {
      isPresentIzin = isDateGreaterThanToday;
      update();
    } else if (isDateSmallerThanToday) {
      isPresentIzin = isDateSmallerThanToday;
      update();
    } else if (findData != null) {
      isPresentIzin = true;
      // cancelTimer();
      update();
    } else if (findDataAbs != null) {
      isPresentIzin = true;
      // cancelTimer();
      update();
    } else if (findData != null && findDataAbs != null) {
      isPresentIzin = true;
      // cancelTimer();
      update();
    } else {
      isPresentIzin = false;
      update();
    }
  }
}
