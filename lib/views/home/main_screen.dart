import 'package:after_layout/after_layout.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:open_file_plus/open_file_plus.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AfterLayoutMixin<MainScreen> {
  int _activePage = Get.arguments ?? 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    PageController _pageViewController = PageController(initialPage: Get.arguments ?? 0);

    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: [HomeScreen(), ProfileScreen()],
        onPageChanged: (index) {
          // print("TEST GESER");
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
            BottomNavigationBarItem(
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
            _pageViewController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          },
        ),
      ),
    );
  }

  StreamSubscription<ReceivedNotification>? _subscription;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    AwesomeNotificationService().removeNotificationUnUsed();
    FlutterAppBadger.removeBadge();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    _subscription = AwesomeNotifications().actionStream.listen((action) async {
      print("CHANEL KEY: " + action.channelKey.toString());
      if (action.channelKey == "basic") {
        var homeCtrl = Get.put(HomeController());
        var tanggal = action.payload?["datepresence"]?.split(" ")[0];

        var response = await AbsensiServices().findIndiv(homeCtrl.user?["idkaryawan"], tanggal);

        Get.toNamed(RouteName.absen, arguments: {"dataAbsen": response.data?[0], "pulang": 1});
      } else if (action.channelKey == "basic" && action.buttonKeyPressed == "open") {
        var homeCtrl = Get.put(HomeController());
        var tanggal = action.payload?["datepresence"]?.split(" ")[0];

        var response = await AbsensiServices().findIndiv(homeCtrl.user?["idkaryawan"], tanggal);

        Get.toNamed(RouteName.absen, arguments: {"dataAbsen": response.data?[0], "pulang": 1});
      } else if (action.buttonKeyPressed == "close") {
        AwesomeNotifications().cancelAll();
      } else if (action.channelKey == "basic") {
        var homeCtrl = Get.put(HomeController());
        var tanggal = action.payload?["datepresence"]?.split(" ")[0];

        var response = await AbsensiServices().findIndiv(homeCtrl.user?["idkaryawan"], tanggal);

        Get.toNamed(RouteName.absen, arguments: {"dataAbsen": response.data?[0], "pulang": 1});
      } else if (action.channelKey == "basic3") {
        // var absenCtrl = Get.put(AbsenController());
        var homeCtrl = Get.put(HomeController());
        var tanggal = action.payload?["datepresence"]?.split(" ")[0];

        var response = await AbsensiServices().findIndiv(homeCtrl.user?["idkaryawan"], tanggal);
        Get.toNamed(RouteName.absen, arguments: {"dataAbsen": response.data?[0]});
        // absenCtrl.mulaiPulangFromNotif(currentAbsen);
      } else if (action.channelKey == "basic3" && action.buttonKeyPressed == "pulang") {
        // var absenCtrl = Get.put(AbsenController());
        var homeCtrl = Get.put(HomeController());
        var tanggal = action.payload?["datepresence"]?.split(" ")[0];

        var response = await AbsensiServices().findIndiv(homeCtrl.user?["idkaryawan"], tanggal);
        Get.toNamed(RouteName.absen, arguments: {"dataAbsen": response.data?[0]});
        // absenCtrl.mulaiPulangFromNotif(currentAbsen);
      } else if (action.channelKey == "downloadedFile" && action.buttonKeyPressed == "open") {
        print("KE DOWNLOAD FILE NOTIF");
        print("PATH FROM NOTIF: ${action.payload?["path"]}");
        OpenFile.open(action.payload?["path"]);
        print("BERHASIL OPEN");
      } else if (action.channelKey == "downloadedFile") {
        print("KE DOWNLOAD FILE NOTIF");
        OpenFile.open(action.payload?["path"]);
        print("BERHASIL OPEN");
      } else if (action.channelKey == "downloadedImage" && action.buttonKeyPressed == "open") {
        print("KE DOWNLOAD IMAGE NOTIF");
        print("PATH DR IMAGE NET: ${action.payload?["path"].toString()}");
        OpenFile.open(action.payload?["path"]);
      } else if (action.channelKey == "downloadedImage") {
        print("KE DOWNLOAD IMAGE NOTIF");
        print("PATH DR IMAGE NET: ${action.payload?["path"].toString()}");
        OpenFile.open(action.payload?["path"]);
        print("BERHASIL OPEN");
      } else {
        print("action.payload"); //notification was pressed
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
