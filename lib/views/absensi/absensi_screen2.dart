import 'package:app/global_resource.dart';
import 'components/layout_map.dart';

class AbsensiScreenView extends StatefulWidget {
  const AbsensiScreenView({super.key});

  @override
  State<AbsensiScreenView> createState() => _AbsensiScreenViewState();
}

class _AbsensiScreenViewState extends State<AbsensiScreenView> {
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
          onTap: (argument) {
            // print(argument);
            Get.toNamed(RouteName.hasilLocationFullScreen,
                arguments: currentAbsen);
          },
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

    return Scaffold(
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
              top: 600,
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
                            // s.mulaiSelesaiAbsen(context, idAbsen);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  // s.klikAbsen
                                  //     ? colorGrayPrimary
                                  //     : colorBluePrimary
                                  currentAbsen?["waktuCheckOut"] == null
                                      ? colorBluePrimary
                                      : Colors.grey.shade400),
                              shape: const MaterialStatePropertyAll(
                                  (RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FeatherIcons.clock,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  getDuration(currentAbsen?["waktuCheckIn"],
                                      currentAbsen?["waktuCheckOut"]),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}