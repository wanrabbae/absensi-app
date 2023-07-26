import 'package:app/global_resource.dart';

const colorBluePrimary = Color.fromRGBO(24, 102, 225, 1);
const colorBlueOpacity = Color(0xffE8F0FC);
const colorBluePrimary2 = Color(0xff1865E2);
const colorBlueOpacity2 = Color(0xffE8F0FC);
const colorBlueOpacity3 = Color(0xffAEC9F5);
const colorGrayPrimary = Color.fromRGBO(238, 240, 244, 1);
const colorGreenPrimary = Color.fromRGBO(0, 234, 37, 1);
const colorGreenPrimary2 = Color(0xff18E22C);
const LatLng currentLatLng = LatLng(-6.175221730228861, 106.827163526188);

Widget modalSelectCompany(BuildContext context, s) {
  return Wrap(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ovalCardIcon(context, FeatherIcons.x,
                          onTaped: () => Get.back()),
                    ),
                  ],
                ),
              ),
              Container(
                height: 250,
                alignment: Alignment.center,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: ListView.separated(
                    itemCount: s.perusahaanList?.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.horizontal,
                    separatorBuilder: (ctx, pos) => const Divider(
                      color: Color.fromRGBO(238, 240, 244, 1),
                    ),
                    itemBuilder: (ctx, pos) => GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.companyFullScreen);
                        // s.pilihPerusahaan(s.perusahaanList[pos]['idperusahaan']);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Perusahaan",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              buildImageSizeIconNetwork(
                                  context,
                                  s.gambarPerusahaan(s.perusahaanList[pos], 1),
                                  s.gambarPerusahaan(s.perusahaanList[pos], 2)),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${s.perusahaanList[pos]['namaPerusahaan']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              // Text(
                              //   "Tekan tombol 'Hapus' untuk meninggalkan perusahaan ini",
                              //   textAlign: TextAlign.center,
                              //   style:
                              //       TextStyle(color: Colors.red.shade200, fontSize: 12),
                              // ),
                              // TextButton(
                              //     onPressed: () {},
                              //     child: Text(
                              //       "Hapus",
                              //       style: TextStyle(color: Colors.red),
                              //     ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}

Widget dialogViewImage(BuildContext context, String url, bool local) {
  return AlertDialog(
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    content: Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 280,
      decoration: local
          ? BoxDecoration(
              image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover))
          : BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    ),
  );
}

Widget dialogViewLocalImage(BuildContext context, String url) {
  return AlertDialog(
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    content: Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 280,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: FileImage(File(url)), fit: BoxFit.cover)),
    ),
  );
}

Widget customDialog(BuildContext context, String msg, String actionBtnMsg,
    {required VoidCallback onTap}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              msg,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionBtnMsg,
            style: const TextStyle(
                fontSize: 14,
                color: colorBluePrimary,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    ),
  );
}

Widget customDialogLoading(BuildContext context, String msg) {
  return AlertDialog(
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            msg,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: colorBluePrimary,
            ),
          )
        ],
      ));
}

Widget customDialogOk(BuildContext context, String msg) {
  return AlertDialog(
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            msg,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Ok',
              style: const TextStyle(
                  fontSize: 14,
                  color: colorBluePrimary,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ));
}

Widget changeEmailLayout(BuildContext context) {
  return Wrap(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ovalCardIcon(context, FeatherIcons.x,
                          onTaped: () => Get.back()),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Icon(
                  FeatherIcons.repeat,
                  size: 50,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("Tekan tombol untuk menyimpan"),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(colorBluePrimary),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))))),
                      onPressed: () {
                        Get.back();
                        Get.toNamed(RouteName.profileGantiemail);
                      },
                      child: const Text(
                        "Ubah e-mail",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      )
    ],
  );
}

AlertDialog dialogGoogleMap(BuildContext context,
    {required LatLng latLng, required bool updateLocation}) {
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  // Location location = Location();
  return AlertDialog(
    content: SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      height: 280,
      child: Center(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: GoogleMap(
              initialCameraPosition: (updateLocation)
                  ? const CameraPosition(target: currentLatLng)
                  : CameraPosition(target: latLng),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              onMapCreated: (mapController) async {
                googleMapController.complete(mapController);
                if (updateLocation) {
                  // location.onLocationChanged.listen((event) async {
                  //   await googleMapController.future.then((controller) {
                  //     controller.animateCamera(CameraUpdate.newCameraPosition(
                  //         CameraPosition(
                  //             target: LatLng(event.latitude!, event.longitude!),
                  //             zoom: 15)));
                  //   });
                  // });
                } else {
                  await googleMapController.future.then((controller) {
                    controller.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: latLng, zoom: 15)));
                  });
                }
              },
              markers: {
                Marker(
                  markerId: const MarkerId("value1"),
                  position: latLng,
                  icon: BitmapDescriptor.defaultMarker,
                )
              }),
        ),
      ),
    ),
    insetPadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
}
