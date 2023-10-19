abstract class Base {
//Start link URL
  static const String url = "https://api.horaapp.id/";
//End link URL

//Start Auth
  static const String linkLogin = "api/login/sendlink";
  static const String loginOtp = "api/login/verifyOTP";
//Emd Auth

//Start Home
  static const String absensi = "api/absensi/HomeA";
  static const String absenIzinEndpoint = "api/absensi/HomeI";
  static const String perusahaan = "api/profile/home-company";
  static const String searchPerusahaan = "api/profile/search-company";
  static const String searchUser = "api/profile/search-nama";
  static const String undangan = "api/invite";
//End Home

//Start Profile
  static const String profileView = "api/profile/viewprofile";
  static const String profileUpdate = "api/profile/update";
  static const String profileDelete = "api/profile/delete";
//End profile

//Start Ubah Email
  static const String ubahEmail = "api/profile/emailchange";
  static const String verifyUbahEmail = "api/profile/verifyOTP";
//End Ubah Email

//Start Absensi
  static const String absenHadir = "api/absensi";
  static const String absenPulang = "api/absensi/pulang";
  static const String absenIzin = "api/absensi/Izin";
  static const String absenIndie = "api/absensi/indie";
//End Absensi

//Start data auth
  static String token = "tokens";
  static String dataUser = "users";
  static String waktuAbsen = "waktuAbsen";
  static String izinAbsen = "izinAbsen";
  static String klikAbsen = "klikAbsen";
  static String dataPerusahaan = "perusahaan";
  static String perusahaanTerpilih = "perusahaanTerpilih";
  static String dataAbsen = "absen";
  static String splash = "splash";
  static String greating = "greating";
  static String connected = "Koneksi anda tersambung.";
  static String userLiveLoc = 'userLiveLoc';
//End data auth
}

abstract class RouteName {
  //Splash Screen
  static const splash = "/splash_screen";

  //Greeting Screen
  static const greeting = "/greeting_screen";

  //Tutorial Screen
  static const tutorial = "/tutorial_screen";

  //Onboarding Screen
  static const onboarding = "/onboarding_screen";

  //Auth Login Screen
  static const login = "/login_screen";

  //Auth Otp Screen
  static const otpLogin = "/otp_login_screen";

  //Home Screen
  static const home = "/home_screen";
  static const companyFullScreen = "/company_full_screen";
  static const hasilHadirFullScreen = "/hasil_hadir_full_screen";
  static const hasilLocationFullScreen = "/hasil_location_full_screen";

  //Home Search Screen
  static const homeSearch = "/home_search_screen";

  //Home Undangan Screen
  static const homeUndangan = "/home_undangan_screen";

  //Profile View Screen
  static const profileView = "/profile_view_screen";

  //Profile Screen
  static const profile = "/profile_screen";

  //Profile Form Screen
  static const profileForm = "/profile_form_screen";

  //Profile Ganti Email Screen
  static const profileGantiemail = "/profile_gantiemail_screen";

  //Profile Ganti Email Otp Screen
  static const profileGantiemailOtp = "/profile_gantiemail_otp_screen";

  //Absen
  static const absen = "/absen_screen";
  static const absenPulangView = "/absen_pulang_screen";
  static const absenViewMode = "/absen_screen_view";

  //Absen Izin
  static const absenIzin = "/absen_izin_screen";
  static const absenIzinDownloaded = "/absen_izin_downloaded_screen";

  //Webview
  static const webview = "/webview_screen";
}
