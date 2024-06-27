import 'package:app/global_resource.dart';

class DashboardNavigationBar extends StatelessWidget {
  const DashboardNavigationBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(color: colorGrayPrimary, blurRadius: 10),
          ]),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/navbar/office.webp',
                  width: 30,
                  height: 30,
                ),
                activeIcon: Image.asset(
                  'assets/icons/navbar/office.webp',
                  color: colorBluePrimary,
                  width: 30,
                  height: 30,
                ),
                label: tr('menu_office'),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/navbar/search.webp',
                  width: 30,
                  height: 30,
                ),
                activeIcon: Image.asset(
                  'assets/icons/navbar/search.webp',
                  color: colorBluePrimary,
                  width: 30,
                  height: 30,
                ),
                label: tr('menu_search'),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/navbar/work.webp',
                  width: 30,
                  height: 30,
                ),
                activeIcon: Image.asset(
                  'assets/icons/navbar/work.webp',
                  color: colorBluePrimary,
                  width: 30,
                  height: 30,
                ),
                label: tr('menu_work'),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/navbar/profile.webp',
                  width: 30,
                  height: 30,
                ),
                activeIcon: Image.asset(
                  'assets/icons/navbar/profile.webp',
                  color: colorBluePrimary,
                  width: 30,
                  height: 30,
                ),
                label: tr('menu_profile'),
              ),
            ],
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.black,
            ),
            unselectedItemColor: Colors.black,
            currentIndex: tabController.index,
            elevation: 10,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: colorBluePrimary,
            ),
            fixedColor: colorBluePrimary,
            onTap: (index) {
              tabController.animateTo(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
              Tooltip.dismissAllToolTips();
            },
          ),
        );
      },
    );
  }
}
