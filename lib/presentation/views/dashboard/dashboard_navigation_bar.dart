import 'package:app/global_resource.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

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
                icon: const Icon(Boxicons.bx_buildings),
                activeIcon: const Icon(Boxicons.bxs_buildings),
                label: tr('menu_office'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Boxicons.bx_search),
                activeIcon: const Icon(Boxicons.bxs_search),
                label: tr('menu_search'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Boxicons.bx_briefcase),
                activeIcon: const Icon(Boxicons.bxs_briefcase),
                label: tr('menu_work'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Boxicons.bx_user),
                activeIcon: const Icon(Boxicons.bxs_user),
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
