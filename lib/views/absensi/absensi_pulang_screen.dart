import 'package:app/global_resource.dart';
import 'components/layout_map.dart';

class AbsensiPulangScreenView extends StatefulWidget {
  const AbsensiPulangScreenView({super.key});

  @override
  State<AbsensiPulangScreenView> createState() =>
      _AbsensiPulangScreenViewState();
}

class _AbsensiPulangScreenViewState extends State<AbsensiPulangScreenView> {
  PageController _pageController = PageController();
  int _currentPageIndex = 0;
  var isDrag = true;

  @override
  Widget build(BuildContext context) {
    var currentAbsen = Get.arguments?["dataAbsen"] ?? {};
    var idAbsen = Get.arguments?["dataAbsen"]?["id"] ?? null;

    final Completer<GoogleMapController> googleMapController =
        Completer<GoogleMapController>();

    List<Widget> pages = [
      // First page: Image network
      GestureDetector(
        onTap: () => Get.toNamed(RouteName.hasilHadirFullScreen,
            arguments: currentAbsen?["fotoKaryawan"]),
        child: Image.network(
          changeUrlImage(currentAbsen?["fotoKaryawan"]),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      // Second page: Map layout
      GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(currentAbsen?["alamatLatitude"]),
                  double.parse(currentAbsen?["alamatLongtitude"])),
              zoom: 15),
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          markers: {
            Marker(
              markerId: const MarkerId("value1"),
              position: LatLng(double.parse(currentAbsen?["alamatLatitude"]),
                  double.parse(currentAbsen?["alamatLongtitude"])),
              icon: BitmapDescriptor.defaultMarker,
            )
          }),
    ];

    return GetBuilder<AbsenController>(
      init: AbsenController(),
      dispose: (state) {
        state.controller!.cancelTimer();
      },
      builder: (s) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromRGBO(238, 240, 244, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Icon(FeatherIcons.arrowLeft)),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: pages,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                top: 620,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 14,
                        color:
                            _currentPageIndex == 0 ? Colors.white : Colors.grey,
                      ),
                      SizedBox(width: 7),
                      Icon(
                        Icons.circle,
                        size: 14,
                        color:
                            _currentPageIndex == 0 ? Colors.grey : Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Tekan tombol untuk masuk/pulang",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(51, 51, 51, 0.5)),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 20, left: 20, right: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                s.mulaiSelesaiAbsen(context, idAbsen);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      // s.klikAbsen
                                      //     ? colorGrayPrimary
                                      //     : colorBluePrimary
                                      colorBluePrimary),
                                  shape: const MaterialStatePropertyAll(
                                      (RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))))),
                              child: timerCount(context, s)))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
