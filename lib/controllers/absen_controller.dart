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
  bool klikAbsen = false;
  String? alamatLoc;
  // ignore: prefer_typing_uninitialized_variables
  var timer;
  //izin
  Map? perusahaan;
  List? perusahaanList;
  String formIzin = 'Izin';
  String? formDeskripsi;
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
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Lokasi Tidak Aktif !!',
          'Lokasi Dinonaktifkan, Harap Aktifkan Lokasi');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
            'Izin perangkat ditolak!', 'Aplikasi Tidak Mendapatkan izin ');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Izin perangkat ditolak!',
          'Lokasi tidak mendapatkan izin secara permanen');
      return false;
    }
    lokasiDetect();
  }

  lokasiDetect() async {
    // SplashController().loading("Memuat lokasi");
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

  mulaiSelesaiAbsen(context, idAbsen) {
    if (!klikAbsen) {
      Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "Verifikasi Wajah",
          titleStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          titlePadding: const EdgeInsets.all(10),
          content: const Padding(
            padding: EdgeInsets.all(5),
            child: Text('Yuk selfie...', style: TextStyle(fontSize: 12)),
          ),
          buttonColor: Colors.transparent,
          cancelTextColor: colorBluePrimary,
          confirmTextColor: colorBluePrimary,
          textConfirm: "Oke",
          textCancel: "Batal",
          onConfirm: () {
            Get.back();
            ImagePicker()
                .pickImage(
                    source: ImageSource.camera,
                    preferredCameraDevice: CameraDevice.front)
                .then((value) {
              if (value != null) {
                formFoto = File(value.path);
                update();
                absenHadir();
              } else {
                Get.snackbar("Tidak Bisa Melakukan Absensi !!",
                    "Tidak bisa melanjutkan tanpa foto");
              }
            });
          });
    } else {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: "Presensi",
        titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        titlePadding: const EdgeInsets.all(10),
        content: const Padding(
          padding: EdgeInsets.all(5),
          child: Text('Anda ingin pulang?', style: TextStyle(fontSize: 12)),
        ),
        buttonColor: Colors.transparent,
        cancelTextColor: colorBluePrimary,
        confirmTextColor: colorBluePrimary,
        textConfirm: "Ya",
        textCancel: "Tidak",
        onConfirm: () {
          Get.back();
          absenPulang(true, idAbsen);
        },
      );
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
      SplashController().loading("Mengirim Absen...");
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
        Get.snackbar("Anda Sudah Absen !!",
            "waktu akan berjalan selama belum melakukan absen pulang");
        box.write(Base.waktuAbsen, DateTime.now().toString());
        box.write(Base.klikAbsen, true);
        Get.offAllNamed(RouteName.home);
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        Get.snackbar('Gagal Menjalankan Fitur Ini !!', response.toString());
        // print("INI HADIR: " + (response as Response<dynamic>).toString());
        // print("CODE: " + response.statusCode.toString());
      }
    } catch (e) {
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }

  absenPulang(status, [idAbsen = null]) async {
    var currentDate = DateTime.now();
    var newDate =
        new DateTime(currentDate.year, currentDate.month, currentDate.day + 1)
            .toString()
            .split(" ")[0];
    print(idAbsen);
    try {
      if (status) {
        SplashController().loading("Sedang Pulang...");
      }
      var response = await AbsensiServices()
          .pulangPut({'id': idAbsen.toString(), 'tanggal': newDate}, {});
      if (response.statusCode == 200) {
        Get.back();
        box.write(Base.klikAbsen, false);
        if (status) {
          // Get.snackbar("Anda Sudah Pulang", "waktu telah dihentikan");
          Get.offAllNamed(RouteName.home);
        } else {
          // Get.snackbar("Mengajukan Izin Berhasil",
          //     "Berhasil mematikan absen sebelumnya. Berhasil mengirimkan izin. Silahkan hubungi admin.");
          Get.offAllNamed(RouteName.home);
        }
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else if (response.statusCode == 400) {
        Get.back();
        Get.snackbar('Ups', 'Terjadi kesalahan :(');
      } else {
        Get.back();
        Get.snackbar('Gagal Menjalankan Fitur Ini !!', response.toString());
        print("INI PULANG: " + response.toString());
      }
    } catch (e) {
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }

  absenIzin() async {
    try {
      // SplashController().loading("Mengajukan surat izin...");
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
          // Get.snackbar("Mengajukan Izin Berhasil !!",
          //     "Berhasil. Silahkan hubungi admin.");
          Get.offAllNamed(RouteName.home);
        } else {
          absenPulang(false);
        }
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        Get.snackbar(
            'Gagal Menjalankan Fitur Ini !!', response.body.toString());
      }
    } catch (e) {
      print(e);
      Get.snackbar('Izin', 'Anda sudah melakukan izin');
    }
  }
}


    // if (file != null && waktuAbsen != null) {
    //   showDialog(
    //       context: context,
    //       builder: (ctx) =>
    //           customDialog(context, "Siap untuk memulai?", "Ya", onTap: () {
    //             Get.back();
    //           })).then((value) {
    //     if (value != null) {
    //       // ref.read(timerProvider.notifier).start();
    //       // Get.back;
    //     }
    //   });
    // } else {
    // showDialog(
    //     context: context,
    //     builder: (ctx) => customDialog(
    //             context,
    //             "Silahkan ambil foto selfi untuk bisa melanjutkan",
    //             "Ok", onTap: () {
    //           Get.back();
    //         })).then((value) {
    //   //   print(value);
    //   //   if (value) {
    //   ImagePicker().pickImage(source: ImageSource.camera).then((value) {
    //     if (value != null) {
    //       Get.offAllNamed(RouteName.home);
    //       // print(value);
    //       // file = result.files.first;
    //       // fileName = "${file?.name} (${file?.size})";

    //       // showDialog(
    //       //     context: context,
    //       //     builder: (ctx) => customDialog(
    //       //             context, "Foto selfi berhasil.", "OK", onTap: () {
    //       //           ref.read(timerProvider.notifier).start();
    //       //           // AppRoute.pop();
    //       //         })).then((value) => Get.back());
    //     } else {
    //       showDialog(
    //           context: context,
    //           builder: (ctx) => customDialog(
    //               context, "Tidak bisa melanjutkan tanpa foto", "OK",
    //               onTap: () => Get.back()));
    //     }
    //   });
    //   // }
    // });
    // }
                // showDialog(
                //     context: context,
                //     builder: (ctx) => customDialog(
                //             context, "Foto selfi berhasil.", "OK", onTap: () {
                //           ref.read(timerProvider.notifier).start();
                // AppRoute.pop();
                //         })).then((value) => Get.back());

            // showDialog(
            //     context: context,
            //     builder: (ctx) => customDialog(
            //         context, "Tidak bisa melanjutkan tanpa foto", "OK",
            //         onTap: () => Get.back()));







//             import 'package:app/global_resource.dart';

// class AbsenController extends GetxController {
//   //global
//   final box = GetStorage();
//   String? currentDate;
//   String? fileName;
//   PlatformFile? file;
//   Map? user;
//   //absen
//   LatLng currentLocation = const LatLng(0.0, 0.0);
//   BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
//   Completer<GoogleMapController> googleMapController =
//       Completer<GoogleMapController>();
//   String? timerRecor = "00:00:00";
//   String? waktuAbsen;
//   File? formFoto;
//   bool klikAbsen = false;
//   // ignore: prefer_typing_uninitialized_variables
//   var timer;
//   //izin
//   Map? perusahaan;
//   List? perusahaanList;
//   String formIzin = 'Izin';
//   String? formDeskripsi;
//   List? izinList = [
//     {"nama": "Izin", "value": "Izin"},
//     {"nama": "Sakit", "value": "Sakit"},
//     {"nama": "Cuti", "value": "Cuti"}
//   ];

//   @override
//   void onInit() async {
//     super.onInit();
//     user = box.read(Base.dataUser);
//     klikAbsen = box.read(Base.klikAbsen) ?? false;
//     currentDate = DateTime.now().toString();
//     startTimer();
//     await dataPerusahaan();
//     getCurrentLocation();
//   }

//   startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (klikAbsen) {
//         timerRecor = timerAbsen();
//       } else {
//         timerRecor = "00:00:00";
//         cancelTimer();
//       }
//       update();
//     });
//   }

//   cancelTimer() {
//     timer?.cancel();
//     timer = null;
//   }

//   dataPerusahaan() {
//     var terpilih = box.read(Base.perusahaanTerpilih);
//     perusahaanList = jsonDecode(box.read(Base.dataPerusahaan));
//     if (terpilih == null) {
//       perusahaan = perusahaanList![0];
//     } else {
//       perusahaan = perusahaanList!
//           .where((value) => value['idperusahaan'] == terpilih)
//           .toList()[0];
//     }
//   }

//   getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Get.snackbar('Lokasi Tidak Aktif !!',
//           'Lokasi Dinonaktifkan, Harap Aktifkan Lokasi');
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Get.snackbar(
//             'Izin perangkat ditolak!', 'Aplikasi Tidak Mendapatkan izin ');
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       Get.snackbar('Izin perangkat ditolak!',
//           'Lokasi tidak mendapatkan izin secara permanen');
//       return false;
//     }
//     lokasiDetect();
//   }

//   lokasiDetect() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       // Get.back();
//       currentLocation = LatLng(position.latitude, position.longitude);
//       await googleMapController.future.then((newController) {
//         BitmapDescriptor.fromAssetImage(
//                 const ImageConfiguration(size: Size(800, 800)),
//                 "assets/icons/map-pin.png")
//             .then((value) => customMarker = value);
//         newController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//                 target: LatLng(position.latitude, position.longitude),
//                 zoom: 15),
//           ),
//         );
//       });
//       update();
//     });
//   }

//   mulaiSelesaiAbsen(context) {
//     if (!klikAbsen) {
//       Get.defaultDialog(
  
//           title: "Siap untuk memulai?",
//           titleStyle:
//               const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           titlePadding: const EdgeInsets.all(10),
//           content: const Padding(
//             padding: EdgeInsets.all(5),
//             child: Text('Silahkan ambil foto selfi untuk bisa melanjutkan',
//                 style: TextStyle(fontSize: 12)),
//           ),
//           buttonColor: Colors.white,
//           cancelTextColor: colorBluePrimary,
//           confirmTextColor: colorBluePrimary,
//           textConfirm: "Foto",
//           textCancel: "Batal",
//           onConfirm: () {
//             Get.back();
//             ImagePicker()
//                 .pickImage(
//               source: ImageSource.camera,
//               preferredCameraDevice: CameraDevice.front,
//             )
//                 .then((value) {
//               if (value != null) {
//                 formFoto = File(value.path);
//                 mulaiAbsen();
//               } else {
//                 Get.snackbar("Tidak Bisa Melakukan Absensi !!",
//                     "Tidak bisa melanjutkan tanpa foto");
//               }
//             });
//           });
//     } else {
//       Get.defaultDialog(
  
//         title: "Pulang sekarang ?",
//         titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         titlePadding: const EdgeInsets.all(10),
//         content: const Padding(
//           padding: EdgeInsets.all(5),
//           child: Text('Silahkan klik "pulang" jika anda akan pulang',
//               style: TextStyle(fontSize: 12)),
//         ),
//         buttonColor: Colors.white,
//         cancelTextColor: colorBluePrimary,
//         confirmTextColor: colorBluePrimary,
//         textConfirm: "Pulang",
//         textCancel: "Batal",
//         onConfirm: () {
//           Get.back();
//           absenPulang();
//         },
//       );
//     }
//   }

//   mulaiAbsen() async {
//     Get.defaultDialog(
  
//         title: "Sudah Melakukan foto selfie!!",
//         titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         titlePadding: const EdgeInsets.all(10),
//         content: const Padding(
//           padding: EdgeInsets.all(5),
//           child: Text('silahkan Melanjutkan', style: TextStyle(fontSize: 12)),
//         ),
//         buttonColor: Colors.white,
//         cancelTextColor: colorBluePrimary,
//         confirmTextColor: colorBluePrimary,
//         textConfirm: "Lanjutkan",
//         textCancel: "Batal",
//         onConfirm: () {
//           Get.back();
//           absenHadir();
//         });
//   }

//   updateFile() async {
//     // FilePicker
//     await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc']).then((result) {
//       if (result != null) {
//         file = result.files.first;
//         fileName = "${file?.name} (${file?.size})";
//         update();
//       }
//     });
//   }

//   updateFormIzin(value) {
//     formIzin = value;
//     update();
//   }

//   absenHadir() async {
//     try {
//       SplashController().loading("Mengirim Absen...");
//       final FormData forms = FormData({
//         'IDKaryawan': user?['idkaryawan'],
//         'NamaKaryawan': user?['namaKaryawan'],
//         'AlamatLatitude': currentLocation.latitude,
//         'AlamatLongtitude': currentLocation.longitude,
//         'Foto': MultipartFile(formFoto!.path,
//             filename: formFoto!.path.split('/').last),
//         'IDPerusahaan': perusahaan?['idperusahaan'],
//         'NamaPerusahaan': perusahaan?['namaPerusahaan']
//       });
//       var response = await AbsensiServices().hadirPost(forms);
//       if (response.statusCode == 200) {
//         Get.back();
//         Get.snackbar("Anda Sudah Absen !!",
//             "waktu akan berjalan selama belum melakukan absen pulang");
//         box.write(Base.waktuAbsen, DateTime.now().toString());
//         box.write(Base.klikAbsen, true);
//         Get.offAllNamed(RouteName.home);
//       } else if (response.statusCode == 401) {
//         Get.back();
//         SplashController().sessionHabis(user?['alamatEmail']);
//       } else {
//         Get.back();
//         Get.snackbar(
//             'Gagal Menjalankan Fitur Ini !!', response.body.toString());
//       }
//     } catch (e) {
//       Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
//     }
//   }

//   absenPulang() async {
//     try {
//       SplashController().loading("Sedang Pulang...");
//       var response = await AbsensiServices().pulangPut({
//         'id': user?['idkaryawan'],
//         'tanggal': changeFormatDate(1, DateTime.now().toString()).toString()
//       }, {});
//       if (response.statusCode == 200) {
//         Get.back();
//         Get.snackbar("Anda Sudah Pulang !!", "waktu telah dihentikan");
//         box.write(Base.klikAbsen, false);
//         Get.offAllNamed(RouteName.home);
//       } else if (response.statusCode == 401) {
//         Get.back();
//         SplashController().sessionHabis(user?['alamatEmail']);
//       } else {
//         Get.back();
//         Get.snackbar(
//             'Gagal Menjalankan Fitur Ini !!', response.body.toString());
//       }
//     } catch (e) {
//       Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
//     }
//   }

//   absenIzin() async {
//     try {
//       SplashController().loading("Mengajukan surat izin...");
//       final FormData forms = FormData({
//         'IDKaryawan': user?['idkaryawan'],
//         'NamaKaryawan': user?['namaKaryawan'],
//         'Keterangan': formDeskripsi,
//         'Ijin': formIzin,
//         'DokumenIjin': MultipartFile(file!.path, filename: file!.name),
//         'IDPerusahaan': perusahaan?['idperusahaan'],
//         'NamaPerusahaan': perusahaan?['namaPerusahaan']
//       });
//       var response = await AbsensiServices().izinPost(forms);
//       if (response.statusCode == 200) {
//         Get.back();
//         Get.snackbar("Berhasil !!", "Berhasil. Silahkan hubungi admin.");
//         Get.offAllNamed(RouteName.home);
//         update();
//       } else if (response.statusCode == 401) {
//         Get.back();
//         SplashController().sessionHabis(user?['alamatEmail']);
//       } else {
//         Get.back();
//         Get.snackbar(
//             'Gagal Menjalankan Fitur Ini !!', response.body.toString());
//       }
//     } catch (e) {
//       Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
//     }
//   }
// }


//     // if (file != null && waktuAbsen != null) {
//     //   showDialog(
//     //       context: context,
//     //       builder: (ctx) =>
//     //           customDialog(context, "Siap untuk memulai?", "Ya", onTap: () {
//     //             Get.back();
//     //           })).then((value) {
//     //     if (value != null) {
//     //       // ref.read(timerProvider.notifier).start();
//     //       // Get.back;
//     //     }
//     //   });
//     // } else {
//     // showDialog(
//     //     context: context,
//     //     builder: (ctx) => customDialog(
//     //             context,
//     //             "Silahkan ambil foto selfi untuk bisa melanjutkan",
//     //             "Ok", onTap: () {
//     //           Get.back();
//     //         })).then((value) {
//     //   //   print(value);
//     //   //   if (value) {
//     //   ImagePicker().pickImage(source: ImageSource.camera).then((value) {
//     //     if (value != null) {
//     //       Get.offAllNamed(RouteName.home);
//     //       // print(value);
//     //       // file = result.files.first;
//     //       // fileName = "${file?.name} (${file?.size})";

//     //       // showDialog(
//     //       //     context: context,
//     //       //     builder: (ctx) => customDialog(
//     //       //             context, "Foto selfi berhasil.", "OK", onTap: () {
//     //       //           ref.read(timerProvider.notifier).start();
//     //       //           // AppRoute.pop();
//     //       //         })).then((value) => Get.back());
//     //     } else {
//     //       showDialog(
//     //           context: context,
//     //           builder: (ctx) => customDialog(
//     //               context, "Tidak bisa melanjutkan tanpa foto", "OK",
//     //               onTap: () => Get.back()));
//     //     }
//     //   });
//     //   // }
//     // });
//     // }
//                 // showDialog(
//                 //     context: context,
//                 //     builder: (ctx) => customDialog(
//                 //             context, "Foto selfi berhasil.", "OK", onTap: () {
//                 //           ref.read(timerProvider.notifier).start();
//                 // AppRoute.pop();
//                 //         })).then((value) => Get.back());

//             // showDialog(
//             //     context: context,
//             //     builder: (ctx) => customDialog(
//             //         context, "Tidak bisa melanjutkan tanpa foto", "OK",
//             //         onTap: () => Get.back()));