import 'package:app/global_resource.dart';

class ProfileController extends GetxController {
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
    print("PROFILE CTRL: " + user.toString());
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
      Get.snackbar('Lokasi Tidak Aktif !!',
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
    Get.defaultDialog(
        title: "Keluar Aplikasi??",
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        titlePadding: const EdgeInsets.all(10),
        content: const Padding(
          padding: EdgeInsets.all(5),
          child: Text('Tekan "Keluar" untuk keluar aplikasi.',
              style: TextStyle(fontSize: 12)),
        ),
        buttonColor: Colors.white,
        cancelTextColor: colorBluePrimary,
        confirmTextColor: colorBluePrimary,
        textCancel: "Batal",
        textConfirm: "Keluar",
        onConfirm: () {
          SplashController().removeData();
        });
  }

  hapusAkun() {
    Get.defaultDialog(
        title: "Apakah Anda yakin menghapus akun anda??",
        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        titlePadding: const EdgeInsets.all(10),
        content: const Padding(
          padding: EdgeInsets.all(5),
          child: Text('Tekan "Hapus Akun" untuk menghapus akun anda.',
              style: TextStyle(fontSize: 12)),
        ),
        buttonColor: Colors.white,
        cancelTextColor: colorBluePrimary,
        confirmTextColor: Colors.red,
        textCancel: "Batal",
        textConfirm: "Hapus Akun",
        onConfirm: () {
          hapusData();
        });
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
        Get.snackbar(
            'Gagal Menjalankan Fitur Ini !!', response.body.toString());
      }
    } catch (e) {
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }

  editData() async {
    try {
      SplashController().loading("Menyimpan Data..");
      final FormData forms = FormData({
        'AlamatEmail': user?['alamatEmail'],
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
        await dataProfile(user?['alamatEmail']);
        Get.back();
        Get.back();
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        Get.snackbar(
            'Gagal Menjalankan Fitur Ini !!', response.body.toString());
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }

  hapusData() async {
    try {
      SplashController().loading("Menghapus Akun...");
      var response = await ProfileServices().profileDeletePut({
        'email': user?['alamatEmail'],
        'perusahaan': perusahaan?['idperusahaan']
      }, {});
      if (response.statusCode == 200) {
        Get.back();
        SplashController().removeData();
        Get.snackbar(
            'Akun Telah Dihapus !!', "terimakasih telah menggunakan hora");
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        Get.snackbar(
            'Gagal Menjalankan Fitur Ini !!', response.body.toString());
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }

  ubahEmail(msg, status) async {
    try {
      SplashController().loading(msg);
      var response = await ProfileServices().ubahEmailPost({
        'email': user?['alamatEmail'],
        'perusahaan': perusahaan?['idperusahaan']
      }, {
        'alamatEmail': emailBaru,
        'NamaKaryawan': profileNama ?? user?['namaKaryawan'],
        'Idperusahaan': perusahaan?['idperusahaan'],
        'NamaPerusahaan': perusahaan?['namaPerusahaan'],
      });
      if (response.statusCode == 200) {
        Get.back();

        Get.snackbar("Otp Berhasil Dikirim !!", response.body.toString());
        if (status == 1) {
          Get.toNamed(RouteName.profileGantiemailOtp);
        }
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        Get.snackbar('Gagal Menjalankan Fitur Ini !!',
            'Ada kesalahan dalam penginputan');
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }

  verifyUbahEmail() async {
    try {
      SplashController().loading("Mengubah Email");
      var response = await ProfileServices().ubahEmailVerifyPost({
        'email': emailBaru,
        'otp': otp,
        'emaillama': user?['alamatEmail'],
        'idperusahaan': perusahaan?['idperusahaan'],
      });
      if (response.statusCode == 200) {
        dataProfile(emailBaru);
        Get.back();
        Get.offAllNamed(RouteName.profile);
        Get.toNamed(RouteName.profileForm);
        Get.snackbar("Berhasil !!", "email telah dirubah");
      } else if (response.statusCode == 401) {
        Get.back();
        SplashController().sessionHabis(user?['alamatEmail']);
      } else {
        Get.back();
        Get.snackbar(
            'Gagal Menjalankan Fitur Ini !!', response.body.toString());
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Fitur Tidak Bisa Dijalankan !!', e.toString());
    }
  }
}
