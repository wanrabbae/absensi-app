import 'package:app/global_resource.dart';

class HomeToolbar extends StatelessWidget {
  const HomeToolbar(this.s, {super.key});

  final HomeController s;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      margin: EdgeInsets.only(top: top, left: 20, right: 16),
      height: kToolbarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Image.asset('assets/icons/logo/hora.png', height: 24),
                const SizedBox(width: 5),
                const Text(
                  "HORA",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Get.toNamed(RouteName.homeSearch);
              s.dataSearch();
            },
            icon: const Icon(
              FeatherIcons.search,
              size: 24,
              color: colorBluePrimary,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(RouteName.homeUndangan);
            },
            icon: const Icon(
              FeatherIcons.userPlus,
              size: 24,
              color: colorBluePrimary,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteName.companyScreen);
            },
            child: buildImageSizeIcon(
              context,
              changeUrlImage(s.perusahaan.logo),
            ),
          ),
        ],
      ),
    );
  }
}