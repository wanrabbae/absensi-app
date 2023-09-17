import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CompanyFullScreen extends StatefulWidget {
  const CompanyFullScreen({super.key});

  @override
  State<CompanyFullScreen> createState() => _CompanyFullScreenState();
}

class _CompanyFullScreenState extends State<CompanyFullScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (s) {
        print(s.perusahaan);
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
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
                    onTap: () async {
                      saveNetworkImage(changeUrlImage(
                          s.perusahaan?['logoPerusahaan'] ??
                              'wwwroot/Images/CompanyLogo/logo_hora.png'));
                      // try {
                      // print("HORA PATH: " + createFolder("Hora").toString());
                      // await downloadImage(changeUrlImage(
                      //     s.perusahaan?['logoPerusahaan'] ??
                      //         'wwwroot/Images/CompanyLogo/logo_hora.png'));
                      SplashController().showOkDialog2(
                          "Tangkapan Layar", "Gambar Telah Tersimpan", () {
                        print("YOYY");
                      });
                      // await AwesomeNotificationService()
                      //     .showNotificationDownloadedFile();
                      // } on DioError catch (error) {
                      //   print(error);
                      // }
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
          ),
          body: Container(
            // width: double.infinity,
            // height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(changeUrlImage(
                      s.perusahaan?['logoPerusahaan'] ??
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
