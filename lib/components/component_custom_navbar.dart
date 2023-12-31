import 'package:app/global_resource.dart';

Widget customNavbar(pageViewController, activePage) {
  return Container(
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
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: Colors.black,
      ),
      unselectedItemColor: Colors.black,
      currentIndex: activePage,
      elevation: 10,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 12,
        color: colorBluePrimary,
      ),
      fixedColor: colorBluePrimary,
      backgroundColor: colorBlueOpacity2,
      // backgroundColor: colorBlueOpacity2,
      onTap: (index) {
        pageViewController?.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      },
    ),
  );
}
