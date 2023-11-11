import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/services/push_notification_service.dart';
import 'package:background_location/background_location.dart' as bg;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _activePage = Get.arguments ?? 0;

  @override
  void initState() {
    $it<PushNotificationService>().requestPermission();

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().updateTokenFcm();

      runServices();
    });
  }

  runServices() async {
    final bgLocGranted = await Permission.locationAlways.isGranted;
    if (!bgLocGranted) return;

    await bg.BackgroundLocation.setAndroidNotification(
      title: "Sedang mendeteksi lokasi di latar belakang",
      message: "Diharapkan untuk tetap membuka aplikasi Hora",
      icon: "@mipmap/ic_launcher",
    );

    await bg.BackgroundLocation.setAndroidConfiguration(
      kDebugMode ? (5 * 1000) : (5 * 60 * 1000),
    );
    await bg.BackgroundLocation.startLocationService(
      distanceFilter: 5,
    );
    bg.BackgroundLocation.getLocationUpdates((bg.Location location) {
      final app = context.read<AppCubit>();
      if (!app.isClosed &&
          location.latitude != null &&
          location.longitude != null) {
        app.updateLiveTrackingList(location.latitude!, location.longitude!);
      }
    });
  }

  @override
  void dispose() {
    bg.BackgroundLocation.stopLocationService();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    PageController pageViewController = PageController(
      initialPage: Get.arguments is int ? Get.arguments as int : 0,
    );

    return Scaffold(
      body: PageView(
        controller: pageViewController,
        children: const [HomeScreen(), ProfileScreen()],
        onPageChanged: (index) {
          // debugPrint("TEST GESER");
          setState(() {
            _activePage = index;
            // widget.index = null;
          });
        },
      ),
      bottomNavigationBar: Container(
        // padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: colorGrayPrimary,
            blurRadius: 10,
          ),
        ]),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/briefcase.png',
                  width: 30,
                  height: 30,
                ),
                activeIcon: Image.asset(
                  'assets/icons/briefcase-active.png',
                  width: 30,
                  height: 30,
                ),
                label: "Kerja"),
            const BottomNavigationBarItem(
              icon: Icon(
                FeatherIcons.user,
                size: 30,
              ),
              label: "Profil",
            ),
          ],
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.black,
          ),
          unselectedItemColor: Colors.black,
          currentIndex: _activePage,
          elevation: 10,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: colorBluePrimary,
          ),
          fixedColor: colorBluePrimary,
          backgroundColor: colorBlueOpacity2,
          // backgroundColor: colorBlueOpacity2,
          onTap: (index) {
            // setState(() {
            //   widget.index = null;
            // });
            pageViewController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);
          },
        ),
      ),
    );
  }
}
