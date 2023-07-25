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
  var timerRecor = "00:00";
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
    super.onInit();
    user = box.read(Base.dataUser);
    currentDate = now.toString();
    await startTimer();
    await dataPerusahaan();
    await dataHome();
  }

  startTimer() {
    klikAbsen = box.read(Base.klikAbsen) ?? false;
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
    print("CANCEL TIMER HOME");
    timer?.cancel();
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
        var currentAbsen = absen?.firstWhere(
            (element) => element['idkaryawan'] == user?['idkaryawan']);
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
    if (data['fotoKaryawan'] != null) {
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
        box.write(Base.dataPerusahaan, jsonEncode(response.body));
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
        customSnackbar1("Anda offline.!");
      }
    } catch (e) {
      // SplashController().sessionHabis(user?['alamatEmail']);
      // Get.snackbar('Sesi habis', '');
      customSnackbar1("Anda offline.!");
    }
  }

  dataHome() async {
    try {
      var absens = await HomeServices().absenGet({
        "idperusahaan": perusahaan?['idperusahaan'],
        "tanggal": currentDate,
      });

      var izins = await HomeServices().izinGet({
        "idperusahaan": perusahaan?['idperusahaan'],
        "tanggal": currentDate,
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
      // Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
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
      // Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
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
        customSnackbar1('Gagal Menjalankan Fitur Ini !!');
      }
    } catch (e) {
      customSnackbar1("Anda offline.!");
    }
  }

  checkIsAbsen() {
    DateTime dateCurrent = DateTime.now();
    String formattedCurrentDate = DateFormat("yyyy-MM-dd").format(dateCurrent);
    var idKaryawan = user?["idkaryawan"];

    var findData = absen?.where((element) =>
        element?["idkaryawan"] == idKaryawan &&
        element['waktuCheckIn'].toString().startsWith(formattedCurrentDate));

    var checkDate = absen?.where((element) {
      DateTime waktuCheckIn = DateTime.parse(element['waktuCheckIn']);
      DateTime currentDate = DateTime.parse(formattedCurrentDate);
      return waktuCheckIn.isBefore(currentDate);
    });

    if (checkDate!.isNotEmpty) {
      isPresentHadir = checkDate.isNotEmpty;
    } else {
      isPresentHadir = findData?.isNotEmpty ?? findData?.isNotEmpty;
    }
  }

  checkIsIzin() {
    DateTime dateCurrent = DateTime.now();
    String formattedCurrentDate = DateFormat("yyyy-MM-dd").format(dateCurrent);
    var idKaryawan = user?["idkaryawan"];

    var findData = izin?.where((element) =>
        element?["idkaryawan"] == idKaryawan &&
        element['tanggalStart'].toString().startsWith(formattedCurrentDate));

    var checkDate = izin?.where((element) {
      DateTime tglStart = DateTime.parse(element['tanggalStart']);
      DateTime currentDate = DateTime.parse(formattedCurrentDate);
      return tglStart.isBefore(currentDate);
    });

    if (checkDate!.isNotEmpty) {
      isPresentIzin = checkDate.isNotEmpty;
    } else {
      isPresentIzin = findData?.isNotEmpty ?? findData?.isNotEmpty;
    }
  }
}
