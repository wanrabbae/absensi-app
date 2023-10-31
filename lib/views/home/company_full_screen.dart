import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

class CompanyFullScreen extends StatefulWidget {
  const CompanyFullScreen({super.key});

  @override
  State<CompanyFullScreen> createState() => _CompanyFullScreenState();
}

class _CompanyFullScreenState extends State<CompanyFullScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (s) {
        final logoPerusahaan = changeUrlImage(
          s.perusahaan?['logoPerusahaan'] ??
              'wwwroot/Images/CompanyLogo/logo_hora.png',
        );

        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(FeatherIcons.arrowLeft),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    saveNetworkImage(logoPerusahaan);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
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
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(logoPerusahaan),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
