import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/controllers/klaim/form/klaim_form_cubit.dart';
import 'package:app/controllers/live_location_log/live_location_log_cubit.dart';
import 'package:app/controllers/management/management_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/presentation/blocs/auth/login/login_cubit.dart';
import 'package:app/presentation/blocs/office/present/detail/present_detail_cubit.dart';
import 'package:app/presentation/blocs/report/report_cubit.dart';
import 'package:app/presentation/blocs/work/laporan/form/laporan_form_cubit.dart';
import 'package:app/presentation/views/auth/login/login_page.dart';
import 'package:app/presentation/views/auth/otp/verify_otp_login_page.dart';
import 'package:app/presentation/views/dashboard/dashboard_screen.dart';
import 'package:app/presentation/views/landing/app_update_screen.dart';
import 'package:app/presentation/views/offfice/present/present_detail_view.dart';
import 'package:app/presentation/views/offfice/report/report_form_view.dart';
import 'package:app/presentation/views/work/reimburse/reimburse_detail_view.dart';
import 'package:app/presentation/views/work/reimburse/reimburse_form.dart';
import 'package:app/presentation/views/work/work_image_viewer.dart';
import 'package:app/presentation/views/work/report/report_form.dart';
import 'package:app/views/absensi/absensi_izin_downloaded_screen.dart';
import 'package:app/views/absensi/absensi_pulang_screen.dart';
import 'package:app/views/absensi/absensi_screen2.dart';
import 'package:app/views/absensi/location_log/location_log_screen.dart';
import 'package:app/views/home/company_full_screen.dart';
import 'package:app/views/home/company_screen.dart';
import 'package:app/views/home/hadir_result_location_screen.dart';
import 'package:app/views/home/hadir_result_selfie_screen.dart';
import 'package:app/views/home/stop_working_screen.dart';
import 'package:app/views/management/data_management_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static final pages = [
    // region Splash
    GetPage(name: RouteName.splash, page: () => const SplashScreen()),
    // endregion Splash

    // region Tutorial
    GetPage(name: RouteName.tutorial, page: () => const TutorialScreen()),
    GetPage(name: RouteName.appUpdate, page: () => const AppUpdateScreen()),
    // endregion Tutorial

    // region Greeting
    GetPage(name: RouteName.landing, page: () => const LandingPage()),
    // endregion Greeting

    // region Auth
    // Login
    GetPage(
      name: RouteName.login,
      page: () {
        return BlocProvider(
          create: (context) => LoginCubit(context.read(), context.read()),
          child: const LoginPage(),
        );
      },
    ),
    // Login Otp
    GetPage(
      name: RouteName.otpLogin,
      page: () {
        return BlocProvider<LoginCubit>.value(
          value: Get.arguments,
          child: const VerifyOTPLoginPage(),
        );
      },
    ),
    // endregion Auth

    // region Home
    // Home
    GetPage(name: RouteName.home, page: () => const DashboardScreen()),
    // Home
    GetPage(name: RouteName.homeSearch, page: () => const HomeSearchScreen()),
    // Home Undangan
    GetPage(
      name: RouteName.homeUndangan,
      page: () => const HomeUndanganScreen(),
    ),
    GetPage(
      name: RouteName.companyFullScreen,
      page: () => const CompanyFullScreen(),
    ),
    GetPage(name: RouteName.companyScreen, page: () => const CompanyScreen()),
    GetPage(name: RouteName.stopWorking, page: () => const StopWorkingScreen()),
    GetPage(
      name: RouteName.hasilHadirFullScreen,
      page: () => const HasilHadirScreen(),
    ),
    GetPage(
      name: RouteName.hasilLocationFullScreen,
      page: () => const HadirLocationResult(),
    ),
    // endregion Home

    // region Profile
    // Profile
    GetPage(name: RouteName.profile, page: () => const ProfileScreen()),
    // Profile Form
    GetPage(
      name: RouteName.profileForm,
      page: () => const ProfileFormScreen(),
      fullscreenDialog: true,
    ),
    // Profile Ganti Email
    GetPage(
      name: RouteName.profileGantiemail,
      page: () => const ProfileGantiemailOtpScreen(),
    ),
    // Profile Ganti Otp
    GetPage(
      name: RouteName.profileGantiemailOtp,
      page: () => const ProfileGantiemailScreen(),
    ),
    // endregion Profile

    // region Absensi
    // Absen
    GetPage(name: RouteName.absen, page: () => const AbsensiScreen()),
    GetPage(
      name: RouteName.absenPulangView,
      page: () => const AbsensiPulangScreenView(),
    ),
    GetPage(
      name: RouteName.absenViewMode,
      page: () => const AbsensiScreenView(),
    ),
    GetPage(
      name: RouteName.absenDetail,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return PresentDetailCubit(
                context.read(),
                context.read(),
                data: Get.arguments,
              );
            },
          ),
          BlocProvider(
            create: (context) {
              return LiveLocationLogCubit(context.read(), Get.arguments);
            },
          ),
        ],
        child: const PresentDetailView(),
      ),
      fullscreenDialog: true,
    ),
    // Izin
    GetPage(
      name: '/$ReportFormView',
      page: () => BlocProvider.value(
        value: Get.find<ReportCubit>(),
        child: const ReportFormView(),
      ),
    ),
    GetPage(name: RouteName.absenIzin, page: () => const AbsensiIzinScreen()),
    GetPage(
      name: RouteName.absenIzinDownloaded,
      page: () => const AbsensiIzinDownloadedScreen(),
    ),
    GetPage(
      name: RouteName.absenLocationLog,
      page: () => BlocProvider(
        create: (context) {
          return LiveLocationLogCubit($it(), Get.arguments);
        },
        child: const LocationLogScreen(),
      ),
    ),
    // endregion Absensi

    // region WebView
    GetPage(name: RouteName.webview, page: () => const WebviewScreen()),
    // endregion WebView

    // region Klaim
    GetPage(
      name: RouteName.klaimForm,
      page: () {
        return BlocProvider(
          create: (context) => KlaimFormCubit(api: $it(), file: Get.arguments),
          child: ReimburseForm(),
        );
      },
    ),
    GetPage(
      name: RouteName.klaimImageViewer,
      page: () => WorkImageViewer(file: Get.arguments),
    ),
    GetPage(
      name: RouteName.klaimDetail,
      page: () => ReimburseDetailView(klaim: Get.arguments),
    ),
    // endregion

    // region Laporan
    GetPage(
      name: RouteName.laporanForm,
      page: () {
        return BlocProvider(
          create: (context) {
            final app = context.read<AppCubit>();
            final state = app.state;
            final profile = state.currentUser!;
            return LaporanFormCubit(
              api: $it(),
              profile: profile,
              file: Get.arguments,
            );
          },
          child: ReportForm(),
        );
      },
    ),
    GetPage(
      name: RouteName.laporanImageViewer,
      page: () => WorkImageViewer(file: Get.arguments),
    ),
    // endregion

    // region management
    GetPage(
      name: RouteName.management,
      page: () {
        return BlocProvider(
          create: (context) {
            final app = context.read<AppCubit>();
            return ManagementCubit($it(), app.state.currentUser!);
          },
          child: const DataManagementPage(),
        );
      },
    ),
    // endregion
  ];
}
