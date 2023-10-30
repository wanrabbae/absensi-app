import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _activePage = Get.arguments ?? 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    PageController pageViewController =
        PageController(initialPage: Get.arguments ?? 0);

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
                duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
          },
        ),
      ),
    );
  }
}
