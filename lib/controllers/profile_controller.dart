import 'package:app/global_resource.dart';

final ProfileController _controller = ProfileController._();

class ProfileController extends GetxController {
  ProfileController._();

  factory ProfileController() => _controller;

  //Global
  final box = GetStorage();
  List? perusahaanList;
  Map? perusahaan;
  Map? user;
  String version = "Versi 01.02.03";
  //Detail Profile
  String? profileNama;
  String? profileGender;
  String? profileAlamat;
  String? profileFoto;
  File? formFoto;
  String? selectedGender = '';
  Position? _currentPosition;
  //Ganti Email
  String? emailBaru;
  //Otp Verifikasi
  String? otp;

  @override
  void onInit() async {
    super.onInit();
    user = box.read(Base.dataUser);
    user = await dataProfile(user?['alamatEmail']);
    debugPrint("PROFILE CTRL: $user");
    await dataPerusahaan();
  }

  dataPerusahaan() {
    var terpilih = box.read(Base.perusahaanTerpilih);
    perusahaanList = jsonDecode(box.read(Base.dataPerusahaan) ?? '[]');
    profileAlamat = user?['alamatLoc'];
    changeGender(user?['gender']);
    if (perusahaanList!.isNotEmpty) {
      if (terpilih == null) {
        perusahaan = perusahaanList![0];
      } else {
        perusahaan = perusahaanList!
            .where((value) => value['idperusahaan'] == terpilih)
            .toList()[0];
      }
    }
  }

  imagePick(status) async {
    if (status == 1) {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        formFoto = File(image.path);
      }
    } else {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        formFoto = File(image.path);
      }
    }
    update();
    Get.back();
  }

  changeGender(data) {
    selectedGender = data;
    valueGender();
    update();
  }

  valueGender() {
    if ((selectedGender ?? user?['gender']) != '') {
      if ((selectedGender ?? user?['gender']) == "pria") {
        return 'Pria';
      } else {
        return 'Wanita';
      }
    } else {
      return '';
    }
  }

  handleLocationPermission() async {
    SplashController().loading("Mendeteksi Lokasi...");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Mohon aktifkan lokasi anda',
          'Lokasi Dinonaktifkan, Harap Aktifkan Lokasi');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
            'Permission dilarang!!', 'Aplikasi Tidak Mendapatkan izin ');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Permission dilarang!!',
          'Lokasi tidak mendapatkan izin secara permanen');
      return false;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      getAddressFromLatLng();
      return true;
    });
  }

  getAddressFromLatLng() async {
    await placemarkFromCoordinates(
            _currentPosition?.latitude ?? double.parse(user?['alamatLatitude']),
            _currentPosition?.longitude ??
                double.parse(user?['alamatLongtitude']))
        .then((List<Placemark> placemarks) {
      profileAlamat =
          "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode} ";
      update();
      Get.back();
      Get.back();
    });
  }

  keluar() {
    SplashController().removeData();
    // Get.defaultDialog(
    //     title: "Akun",
    //     titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //     titlePadding: const EdgeInsets.all(10),
    //     content: const Padding(
    //       padding: EdgeInsets.all(5),
    //       child: Text('Anda ingin keluar?', style: TextStyle(fontSize: 16)),
    //     ),
    //     buttonColor: Colors.transparent,
    //     cancelTextColor: colorBluePrimary,
    //     confirmTextColor: colorBluePrimary,
    //     textCancel: "Tidak",
    //     textConfirm: "Ya",
    //     backgroundColor: Colors.white,
    //     onConfirm: () {
    //       SplashController().removeData();
    //     });
  }

  hapusAkun() {
    SplashController()
        .showConfirmationDialog2("Profil", "Anda ingin menghapus profil?", () {
      hapusData();
    });
    // Get.defaultDialog(
    //     title: "Profil",
    //     titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //     titlePadding: const EdgeInsets.all(10),
    //     content: const Padding(
    //       padding: EdgeInsets.all(5),
    //       child: Text('Anda ingin menghapus profil?',
    //           style: TextStyle(fontSize: 12)),
    //     ),
    //     buttonColor: Colors.transparent,
    //     cancelTextColor: colorBluePrimary,
    //     confirmTextColor: colorBluePrimary,
    //     backgroundColor: Colors.white,
    //     textCancel: "Tidak",
    //     textConfirm: "Ya",
    //     onConfirm: () {
    //       hapusData();
    //     });
  }

  dataProfile(mail) async {
    try {
      var response = await ProfileServices().profileGet({"email": mail});
      if (response.statusCode == 200) {
        box.write(Base.dataUser, response.body);
        user = response.body;
        update();
        return user;
      } else if (response.statusCode == 401) {
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        // SplashController().sessionHabis(user?['alamatEmail']);
        customSnackbar1("Menghubungkan kembali...");
        // Get.snackbar(
        //     'Oops.. terjadi kesalahan sistem.', response.body.toString());
      }
    } catch (e) {
      // Get.snackbar('Oops.. terjadi kesalahan sistem.', e.toString());
      // SplashController().sessionHabis(user?['alamatEmail']);
      customSnackbar1("Menghubungkan kembali...");
    }
  }

  editData() async {
    try {
      final FormData forms = FormData({
        'AlamatEmail': emailBaru ?? user?['alamatEmail'],
        'Idperusahaan': perusahaan?['idperusahaan'],
        'NamaPerusahaan': perusahaan?['namaPerusahaan'],
        'NamaKaryawan': profileNama ?? user?['namaKaryawan'],
        'alamatLongtitude':
            _currentPosition?.longitude ?? user?['alamatLongtitude'],
        'AlamatLatitude': _currentPosition?.latitude ?? user?['alamatLatitude'],
        'AlamatLoc': profileAlamat ?? user?['alamatLoc'],
        'Gender': selectedGender ?? user?['gender'],
        'FotoKaryawan': formFoto != null
            ? MultipartFile(formFoto!.path,
                filename: formFoto!.path.split('/').last)
            : user?['foto']
      });
      var response = await ProfileServices().profileUpdatePut({
        'email': user?['alamatEmail'],
        'perusahaan': perusahaan?['idperusahaan']
      }, forms);
      if (response.statusCode == 200) {
        customSnackbar1("Profil baru telah tersimpan.");
        await dataProfile(user?['alamatEmail']);
        Get.offAllNamed(RouteName.home, arguments: 1);
        // Get.offAll(() => MainScreen(
        //       index: 1,
        //     ));
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
      }
    } catch (e) {
      Get.back();
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  hapusData() async {
    try {
      customSnackbarLoading("Menghapus akun...");
      var response = await ProfileServices().profileDeletePut({
        'email': user?['alamatEmail'],
        'perusahaan': perusahaan?['idperusahaan']
      }, {});
      if (response.statusCode == 200) {
        Get.back();
        SplashController().removeData();
        customSnackbar1("Akun berhasil dihapus.");
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
      }
    } catch (e) {
      Get.back();
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  ubahEmail(msg, status) async {
    var isValidEmail = isEmailValid(emailBaru.toString());
    if (!isValidEmail) {
      customSnackbar1("Silakan masuk kembali.");
      return;
    }
    try {
      customSnackbarLoading(msg);
      var response = await ProfileServices().ubahEmailPost({
        'email': user?['alamatEmail'],
        'perusahaan': perusahaan?['idperusahaan']
      }, {
        'alamatEmail': emailBaru,
        'NamaKaryawan': profileNama ?? user?['namaKaryawan'],
        'Idperusahaan': perusahaan?['idperusahaan'],
        'NamaPerusahaan': perusahaan?['namaPerusahaan'],
      });
      print(response);
      if (response.statusCode == 200) {
        Get.back();
        customSnackbar1("Kode OTP terkirim.");
        // Get.snackbar("Otp Berhasil Dikirim !!", response.body.toString());
        if (status == 1) {
          Get.toNamed(RouteName.profileGantiemailOtp);
        } else {
          Get.offAllNamed(RouteName.home, arguments: 1);
        }
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        customSnackbar1("Oops.. terjadi kesalahan sistem.");
      }
    } catch (e) {
      print(e);
      Get.back();
      customSnackbar1("Oops.. terjadi kesalahan sistem.");
    }
  }

  verifyUbahEmail() async {
    try {
      customSnackbarLoading("Mengubah email...");
      var response = await ProfileServices().ubahEmailVerifyPost({
        'email': emailBaru,
        'otp': otp,
        'emaillama': user?['alamatEmail'],
        'idperusahaan': perusahaan?['idperusahaan'],
      });
      if (response.statusCode == 200) {
        await dataProfile(emailBaru);
        Get.back();
        Get.offAllNamed(RouteName.home, arguments: 1);
        // Get.snackbar("Berhasil !!", "email telah dirubah");
        customSnackbar1("Email berhasil diubah.");
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        // Get.snackbar(
        //     'Oops.. terjadi kesalahan sistem.', response.body.toString());
        customSnackbar1("Kode OTP tidak valid.");
      }
    } catch (e) {
      print(e);
      Get.back();
      // Get.snackbar('Oops.. terjadi kesalahan sistem.', e.toString());
      customSnackbar1("Kode OTP tidak valid.");
    }
  }
}
