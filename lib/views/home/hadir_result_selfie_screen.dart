import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

class HasilHadirScreen extends StatefulWidget {
  const HasilHadirScreen({super.key});

  @override
  State<HasilHadirScreen> createState() => _HasilHadirScreenState();
}

class _HasilHadirScreenState extends State<HasilHadirScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (s) {
        print(s.perusahaan);
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              actions: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(FeatherIcons.arrowLeft),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          saveNetworkImage(changeUrlImage(
                              Get.arguments?.toString() ??
                                  'wwwroot/Images/CompanyLogo/logo_hora.png'));
                          // customSnackbar1("Tangkapan layar telah disimpan.");
                          // SplashController().showOkDialog2(
                          //     "Tangkapan Layar", "Gambar Telah Tersimpan", () {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/icons/ic_screen_shot.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(changeUrlImage(Get.arguments?.toString() ??
                      'wwwroot/Images/CompanyLogo/logo_hora.png')),
                  fit: BoxFit.cover,
                  alignment: Alignment.center),
            ), /* add child content here */
          ),
        );
      },
    );
  }
}
