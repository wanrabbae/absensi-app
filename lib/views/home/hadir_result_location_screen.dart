import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

class HadirLocationResult extends StatefulWidget {
  const HadirLocationResult({super.key});

  @override
  State<HadirLocationResult> createState() => _HadirLocationResultState();
}

class _HadirLocationResultState extends State<HadirLocationResult> {
  var currentAbsen = Get.arguments;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (s) {
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
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(FeatherIcons.arrowLeft),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        customSnackbar1(tr('screenshot_saved'));
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
            ],
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  double.parse(currentAbsen?["alamatLatitude"]),
                  double.parse(currentAbsen?["alamatLongtitude"]),
                ),
                zoom: 15,
              ),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              markers: {
                Marker(
                  markerId: const MarkerId("value1"),
                  position: LatLng(
                    double.parse(currentAbsen?["alamatLatitude"]),
                    double.parse(currentAbsen?["alamatLongtitude"]),
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
            ),
          ),
        );
      },
    );
  }
}
