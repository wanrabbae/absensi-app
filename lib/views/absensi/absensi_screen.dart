import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';
import 'components/layout_map.dart';

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  var isDrag = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    var currentAbsen = Get.arguments?["dataAbsen"] ?? {};
    var idAbsen = Get.arguments?["dataAbsen"]?["id"] ?? null;
    print("ID ABSE: " + idAbsen.toString());

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
                      children: [
                        // ovalCardIcon(context, FeatherIcons.mapPin,
                        //     onTaped: () async {
                        //   s.lokasiDetect();
                        //   showDialog(
                        //     context: context,
                        //     builder: (ctx) => dialogGoogleMap(context,
                        //         latLng: s.currentLocation,
                        //         updateLocation: true),
                        //   );
                        // }),
                        // const SizedBox(width: 20),
                        // ovalCardIconAsset(
                        //     context, "assets/icons/ic_screen_shot.png",
                        //     onTaped: () async {
                        // final storagePermission = await [
                        //   Permission.storage,
                        //   Permission.manageExternalStorage
                        // ].request();
                        // Permission.manageExternalStorage.isGranted
                        //     .then((_) async {
                        //   await NativeScreenshot.takeScreenshot().then((value) {
                        //     if (value != null) {
                        //       showDialog(
                        //           context: context,
                        //           builder: (ctx) => customDialog(
                        //               context, "File save in $value", "OK",
                        //               onTap: () => AppRoute.pop()));
                        //     }
                        //   }).catchError((err) {
                        //     showDialog(
                        //         context: context,
                        //         builder: (ctx) => customDialog(
                        //             context, "msg ${err.toString()}", "OK",
                        //             onTap: () => AppRoute.pop()));
                        //   });
                        // });
                        // }),
                        // const SizedBox(width: 10),
                        // ovalCardIcon(
                        //   context,
                        //   FeatherIcons.mail,
                        //   onTaped: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (ctx) => customDialog(
                        //         context,
                        //         "Anda ingin izin hari ini?",
                        //         "Ok",
                        //         onTap: () {
                        //           Get.back();
                        //           Get.toNamed(RouteName.absenIzin);
                        //         },
                        //       ),
                        //     );
                        //   },
                        // )
                      ],
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
              idAbsen != null
                  ? GestureDetector(
                      onHorizontalDragStart: (details) {
                        setState(() {
                          isDrag = !isDrag;
                        });
                      },
                      child: isDrag
                          ? Image.network(
                              changeUrlImage(currentAbsen?["fotoKaryawan"]),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomCenter,
                            )
                          : mapLayout(context, s))
                  : mapLayout(context, s),
              idAbsen != null
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      top: 450,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 14,
                              color: isDrag ? Colors.white : Colors.grey,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(
                              Icons.circle,
                              size: 14,
                              color: isDrag ? Colors.grey : Colors.white,
                            )
                          ],
                        ),
                      ))
                  : Text(""),
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
                            onPressed: s.disableButton
                                ? null
                                : () {
                                    s.mulaiSelesaiAbsen(context, idAbsen);
                                  },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    // s.klikAbsen
                                    //     ? colorGrayPrimary
                                    //     : colorBluePrimary
                                    s.disableButton
                                        ? Colors.grey.shade400
                                        : colorBluePrimary),
                                shape: const MaterialStatePropertyAll(
                                    (RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))))),
                            child: timerCount(context, s)),
                      )
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
