import 'package:app/global_resource.dart';
import 'components/menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (s) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: customNavbar(1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 50, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          buildImageProfile(
                              context,
                              HomeController().gambarSearch(s.user, 1),
                              HomeController().gambarSearch(s.user, 2)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${s.user?['namaKaryawan']}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                            "Bergabung ${changeFormatDate(3, s.user?['joinDate'])}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        Get.toNamed(RouteName.profileForm),
                                    child: const Icon(
                                      FeatherIcons.chevronRight,
                                      size: 24,
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        line(context),
                        menuProfile(
                            context, "Kebijakan Hora", FeatherIcons.book,
                            onTap: () {
                          Get.toNamed(RouteName.webview,
                              arguments: "https://docs.horaapp.id/#kebijakan");
                        }),
                        menuProfile(
                            context, "Privasi Pengguna", FeatherIcons.lock,
                            onTap: () {
                          Get.toNamed(RouteName.webview,
                              arguments: "https://docs.horaapp.id/#privasi");
                        }),
                        menuProfile(
                            context, "Perangkat lunak", FeatherIcons.terminal,
                            onTap: () {
                          Get.toNamed(RouteName.webview,
                              arguments:
                                  "https://docs.horaapp.id/#perangkatlunak");
                        }),
                        line(context),
                        menuProfile(
                            context, "Pusat bantuan", FeatherIcons.lifeBuoy,
                            onTap: () {
                          Get.toNamed(RouteName.webview,
                              arguments: "https://horaapp.id/#contact");
                        }),
                        menuProfile(context, "Keluar", FeatherIcons.logOut,
                            onTap: () {
                          s.keluar();
                        }),
                      ],
                    )),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    s.version,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w100,
                        color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
