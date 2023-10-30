import 'package:app/global_resource.dart';
import 'components/menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _pageViewController = PageController();

  final int _activePage = 1;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (s) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        // bottomNavigationBar: Get.arguments == "isRedirect"
        //     ? customNavbar(_pageViewController, _activePage)
        //     : null,
        extendBodyBehindAppBar: false,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hai, ${s.user?['namaKaryawan']}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteName.profileForm),
                        child: const Icon(
                          FeatherIcons.edit3,
                          size: 24,
                          color: colorBluePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Column(
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
                                left: 20, right: 20, top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildImageProfilePage(
                                    context,
                                    HomeController().gambarSearch(s.user, 1),
                                    HomeController().gambarSearch(s.user, 2)),
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
                              line2(context),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: Text(
                                  "Tentang",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              menuProfile(
                                  context, "Kebijakan Hora", FeatherIcons.book,
                                  onTap: () {
                                Get.toNamed(RouteName.webview,
                                    arguments:
                                        "https://docs.horaapp.id/#kebijakan");
                              }),
                              menuProfile(context, "Privasi Pengguna",
                                  FeatherIcons.lock, onTap: () {
                                Get.toNamed(RouteName.webview,
                                    arguments:
                                        "https://docs.horaapp.id/#privasi");
                              }),
                              menuProfile(
                                  context, "Kisah Hora", FeatherIcons.command,
                                  onTap: () {
                                Get.toNamed(RouteName.webview,
                                    arguments:
                                        "https://docs.horaapp.id/#kisah");
                              }),
                              menuProfile(context, "Perangkat lunak",
                                  FeatherIcons.terminal, onTap: () {
                                Get.toNamed(RouteName.webview,
                                    arguments:
                                        "https://docs.horaapp.id/#perangkatlunak");
                              }),
                              menuProfile(context, "Tanya jawab",
                                  FeatherIcons.helpCircle, onTap: () {
                                Get.toNamed(RouteName.webview,
                                    arguments: "https://docs.horaapp.id/#faq");
                              }),
                              menuProfile(
                                  context, "v1.9.1 (Agus)", FeatherIcons.info,
                                  onTap: () {
                                Get.toNamed(RouteName.webview,
                                    arguments: "https://horaapp.id/#contact");
                              }),
                              menuProfile(
                                  context, "Keluar", FeatherIcons.logOut,
                                  onTap: () async {
                                final homeCtrl = Get.put(HomeController());

                                if (homeCtrl.timer != null &&
                                    homeCtrl.timer?.isActive) {
                                  var tanggal = homeCtrl.currentDate
                                      .toString()
                                      .split(" ")[0];
                                  var findData = await AbsensiServices()
                                      .findIndiv(
                                          s.user?["idkaryawan"], tanggal);

                                  SplashController().showConfirmationDialog2(
                                      "Presensi", "Anda ingin pulang?",
                                      () async {
                                    // Get.back();
                                    // changePageScreen = 1;
                                    // update();
                                    Get.toNamed(RouteName.absen, arguments: {
                                      "dataAbsen": findData.data?[0],
                                      "pulang": 1
                                    });

                                    // await AbsenController()
                                    //     .getCurrentLocationPulang2(
                                    //         findData?["id"]);
                                  });
                                } else {
                                  SplashController().showConfirmationDialog2(
                                      "Akun", "Anda ingin keluar?", () {
                                    s.keluar();
                                  });
                                }
                                // s.keluar();
                              }),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
