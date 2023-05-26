import 'package:app/global_resource.dart';
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
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (s) {
        print(s.perusahaan);
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(changeUrlImage(
                      s.perusahaan?['logoPerusahaan'] ??
                          'wwwroot/Images/CompanyLogo/logo_hora.png')),
                  fit: BoxFit.cover,
                  alignment: Alignment.center),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
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
                    onTap: () {
                      SplashController().showOkDialog(
                          "Tangkapan Layar", "Gambar Telah Tersimpan");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0)),
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.download),
                    ),
                  ),
                ],
              ),
            ) /* add child content here */,
          ),
        );
      },
    );
  }
}
