import 'package:app/global_resource.dart';
import 'package:flutter/cupertino.dart';
import 'components/card_home.dart';

class MainScreen extends StatefulWidget {
  int? index;
  MainScreen({this.index});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageViewController = PageController();

  int _activePage = 0;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   print("INIT MAIN SCREEN");
  //   if (widget.index != null && _pageViewController.hasClients) {
  //     _pageViewController.jumpToPage(
  //       widget.index!.toInt(),
  //     );
  //   }
  //   super.initState();
  // }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _activePage = widget.index != null ? widget.index!.toInt() : _activePage;
    // });
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[HomeScreen(), ProfileScreen()],
        onPageChanged: (index) {
          print("TEST GESER");
          setState(() {
            _activePage = index;
            widget.index = null;
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
          currentIndex: _activePage,
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
            setState(() {
              widget.index = null;
            });
            _pageViewController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          },
        ),
      ),
    );
  }
}
