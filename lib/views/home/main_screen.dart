import 'package:app/global_resource.dart';
import 'package:flutter/cupertino.dart';
import 'components/card_home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageViewController = PageController();

  int _activePage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[HomeScreen(), ProfileScreen()],
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
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
            fontWeight: FontWeight.w300,
            fontSize: 12,
            color: Colors.black,
          ),
          unselectedItemColor: Colors.black,
          currentIndex: _activePage ?? 0,
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
            _pageViewController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          },
        ),
      ),
    );
  }
}
