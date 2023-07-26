import 'package:app/global_resource.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HasilHadirScreen extends StatefulWidget {
  const HasilHadirScreen({super.key});

  @override
  State<HasilHadirScreen> createState() => _HasilHadirScreenState();
}

class _HasilHadirScreenState extends State<HasilHadirScreen> {
  @override
  Widget build(BuildContext context) {
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
            title: Row(
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
                    padding: EdgeInsets.all(10),
                    child: Icon(FeatherIcons.arrowLeft),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    customSnackbar1("Tangkapan layar telah disimpan.");
                    // SplashController().showOkDialog2(
                    //     "Tangkapan Layar", "Gambar Telah Tersimpan", () {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0)),
                    padding: EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/icons/ic_screen_shot.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(changeUrlImage(Get.arguments.toString() ??
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
