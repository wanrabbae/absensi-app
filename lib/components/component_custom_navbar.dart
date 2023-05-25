import 'package:app/global_resource.dart';

Widget customNavbar(s) {
  return Container(
    // padding: EdgeInsets.all(10),
    decoration: const BoxDecoration(boxShadow: [
      BoxShadow(
        color: colorGrayPrimary,
        blurRadius: 10,
      ),
    ]),
    child: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              FeatherIcons.briefcase,
              size: 30,
            ),
            label: "Kerja"),
        BottomNavigationBarItem(
          icon: Icon(
            FeatherIcons.user,
            size: 30,
          ),
          label: "Profile",
        ),
      ],
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: Colors.black,
      ),
      unselectedItemColor: Colors.black,
      currentIndex: s ?? 0,
      elevation: 10,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: colorBluePrimary,
      ),
      fixedColor: colorBluePrimary,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      onTap: (index) {
        switch (index) {
          case 0:
            Get.offAllNamed(RouteName.home);
            break;
          case 1:
            Get.offAllNamed(RouteName.profile);
            break;
          default:
            Get.offAllNamed(RouteName.home);
        }
      },
    ),
  );
}
