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
  // ignore: prefer_typing_uninitialized_variables
  var timer;
  //search
  String? search = '';
  List? searchHasil = [];
  //undangan
  String? emailUndangan;

  @override
  void onInit() async {
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

  absensi(context) async {
    if (izinAbs()) {
      SplashController().showOkDialog('Anda sudah izin hari ini',
          "tidak bisa melakukan absen lagi hari ini");
    } else {
      if (!klikAbsen) {
        if (await Permission.camera.isGranted &&
            await Permission.location.isGranted) {
          Get.back();
          Get.toNamed(RouteName.absen);
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
        Get.back();
        Get.toNamed(RouteName.absen, arguments: absen?[0]?["id"]);
        // Get.defaultDialog(
        //     contentPadding: EdgeInsets.all(10),
        //     title: "Presensi",
        //     titleStyle:
        //         const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //     titlePadding: const EdgeInsets.all(10),
        //     content: const Padding(
        //       padding: EdgeInsets.all(5),
        //       child: Text('Apakah anda ingin pulang ?',
        //           style: TextStyle(fontSize: 12)),
        //     ),
        //     buttonColor: Colors.transparent,
        //     cancelTextColor: colorBluePrimary,
        //     confirmTextColor: colorBluePrimary,
        //     textCancel: "Tidak",
        //     textConfirm: "Ya",
        //     onConfirm: () {
        //       Get.back();
        //       Get.toNamed(RouteName.absen,
        //           arguments: absen?[0]?[
        //               "id"]); // NOTES: INI MASIH AMBIL INDEX 0 AJA BELUM DINAMIS
        //     });
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
        Get.snackbar(
            'Gagal Menjalankan Fitur Ini !!', response.body.toString());
      }
    } catch (e) {
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }

  dataHome() async {
    print(perusahaan);
    try {
      var response = await HomeServices().absenGet({
        'idperusahaan': perusahaan?['idperusahaan'],
        "tanggal": currentDate,
      });
      print(response.body);
      if (response.statusCode == 200) {
        absen?.addAll(response.body['absen']);
        izin?.addAll(response.body['cuti']);
        box.remove(Base.dataAbsen);
        box.write(Base.dataAbsen, jsonEncode(absen));
        update();
      }
      //  else if (response.statusCode == 401) {
      //   SplashController().sessionHabis(user?['alamatEmail']);
      // }
      // else {
      //   Get.snackbar('Gagal Menggunakan Otp', response.body.toString());
      // }
    } catch (e) {
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
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
    try {
      SplashController().loading("Mengirim Undangan");
      var response = await HomeServices().undanganPost({
        'receiver': emailUndangan,
        'sender': user?['alamatEmail'],
        'idperusahaan': perusahaan?['idperusahaan'],
        'namaPerusahaan': perusahaan?['namaPerusahaan']
      });
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        SplashController().horizontalDialogOk('Undangan terkirim');
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        Get.snackbar(
            'Gagal Menjalankan Fitur Ini !!', response.body.toString());
      }
    } catch (e) {
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }
}
