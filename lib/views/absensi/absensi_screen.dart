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

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GetBuilder<AbsenController>(
        init: AbsenController(),
        dispose: (state) {
          state.controller!.cancelTimer();
        },
        builder: (s) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: const Color.fromRGBO(238, 240, 244, 1),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(FeatherIcons.arrowLeft),
              onPressed: () {
                Get.back();
              },
            ),
            // centerTitle: false,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: true,
            title: Container(
              // decoration: BoxDecoration(border: Border.all()),
              child: TabBar(
                  isScrollable: true,
                  dividerColor: Colors.white,
                  unselectedLabelColor: Colors.black.withOpacity(0.3),
                  labelColor: Colors.black,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  // padding: EdgeInsets.symmetric(horizontal: 70),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  indicatorColor: colorBluePrimary2,
                  indicatorPadding: EdgeInsets.only(bottom: 5),
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: Text('Hadir'),
                    ),
                    Tab(
                      child: Text('Pulang'),
                    ),
                  ]),
            ),
            backgroundColor: Colors.white,
            // actions: [
            //   Container(
            //     padding: const EdgeInsets.only(left: 20, right: 20),
            //     width: MediaQuery.of(context).size.width,
            //     color: Colors.transparent,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.max,
            //       children: [
            //         GestureDetector(
            //           onTap: () {
            //             Get.back();
            //           },
            //           child: Container(
            //               padding: EdgeInsets.all(10),
            //               decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(50.0)),
            //               child: Icon(FeatherIcons.arrowLeft)),
            //         ),
            //         Align(
            //           alignment: Alignment.topRight,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisSize: MainAxisSize.max,
            //             children: [
            //               // ovalCardIcon(context, FeatherIcons.mapPin,
            //               //     onTaped: () async {
            //               //   s.lokasiDetect();
            //               //   showDialog(
            //               //     context: context,
            //               //     builder: (ctx) => dialogGoogleMap(context,
            //               //         latLng: s.currentLocation,
            //               //         updateLocation: true),
            //               //   );
            //               // }),
            //               // const SizedBox(width: 20),
            //               // ovalCardIconAsset(
            //               //     context, "assets/icons/ic_screen_shot.png",
            //               //     onTaped: () async {
            //               // final storagePermission = await [
            //               //   Permission.storage,
            //               //   Permission.manageExternalStorage
            //               // ].request();
            //               // Permission.manageExternalStorage.isGranted
            //               //     .then((_) async {
            //               //   await NativeScreenshot.takeScreenshot().then((value) {
            //               //     if (value != null) {
            //               //       showDialog(
            //               //           context: context,
            //               //           builder: (ctx) => customDialog(
            //               //               context, "File save in $value", "OK",
            //               //               onTap: () => AppRoute.pop()));
            //               //     }
            //               //   }).catchError((err) {
            //               //     showDialog(
            //               //         context: context,
            //               //         builder: (ctx) => customDialog(
            //               //             context, "msg ${err.toString()}", "OK",
            //               //             onTap: () => AppRoute.pop()));
            //               //   });
            //               // });
            //               // }),
            //               // const SizedBox(width: 10),
            //               // ovalCardIcon(
            //               //   context,
            //               //   FeatherIcons.mail,
            //               //   onTaped: () {
            //               //     showDialog(
            //               //       context: context,
            //               //       builder: (ctx) => customDialog(
            //               //         context,
            //               //         "Anda ingin izin hari ini?",
            //               //         "Ok",
            //               //         onTap: () {
            //               //           Get.back();
            //               //           Get.toNamed(RouteName.absenIzin);
            //               //         },
            //               //       ),
            //               //     );
            //               //   },
            //               // )
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: Platform.isAndroid
                ? EdgeInsets.only(top: 100)
                : EdgeInsets.only(top: 130),
            color: Colors.white,
            child: Stack(
              children: [
                TabBarView(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Foto",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 320,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: currentAbsen?['fotoKaryawan'] != null
                                ? GestureDetector(
                                    onTap: () => Get.toNamed(
                                        RouteName.hasilHadirFullScreen,
                                        arguments:
                                            currentAbsen?["fotoKaryawan"]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        changeUrlImage(
                                            currentAbsen?['fotoKaryawan']),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : s.formFoto != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          File(s.formFoto!.path),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: colorBlueOpacity2)
                                                ],
                                                // color: colorBlueOpacity2,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Image.asset(
                                                'assets/icons/image.png'),
                                          ),
                                        ],
                                      ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Jam",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: colorBlueOpacity2,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Image.asset(
                                    'assets/icons/clock.png',
                                    width: 100,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${currentAbsen?['waktuCheckIn'] != null ? getTimeFullFromDatetime(currentAbsen?['waktuCheckIn']) : '-'}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Lokasi",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: colorBlueOpacity2,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Image.asset(
                                        'assets/icons/map-pin-2.png'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      "${currentAbsen['alamatLoc'] != null ? currentAbsen['alamatLoc'] : s.alamatLoc}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (currentAbsen?['alamatLatitude'] !=
                                            null &&
                                        currentAbsen?['alamatLongitude'] !=
                                            null) {
                                      await openMap(
                                          currentAbsen?['alamatLatitude'],
                                          currentAbsen?['alamatLongtitude']);
                                    } else {
                                      await openMap(s.currentLocation.latitude,
                                          s.currentLocation.longitude);
                                    }
                                  },
                                  style: ButtonStyle(
                                      elevation: MaterialStatePropertyAll(0),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide(
                                                  color: colorBluePrimary2,
                                                  width: 2)))),
                                  child: Text(
                                    "Buka Peta",
                                    style: TextStyle(
                                        color: colorBluePrimary2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Foto",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 320,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: currentAbsen?['fotoPulang'] != null
                                ? GestureDetector(
                                    onTap: () => Get.toNamed(
                                        RouteName.hasilHadirFullScreen,
                                        arguments: currentAbsen?["fotoPulang"]),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        changeUrlImage(
                                            currentAbsen?['fotoPulang']),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : s.formFotoPulang != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          File(s.formFoto!.path),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: colorBlueOpacity2)
                                                ],
                                                // color: colorBlueOpacity2,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Image.asset(
                                                'assets/icons/image.png'),
                                          ),
                                        ],
                                      ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Jam",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: colorBlueOpacity2,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Image.asset(
                                    'assets/icons/clock.png',
                                    width: 100,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${currentAbsen?['waktuCheckOut'] != null ? getTimeFullFromDatetime(currentAbsen?['waktuCheckOut']) : '-'}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Lokasi",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: colorBlueOpacity2,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Image.asset(
                                        'assets/icons/map-pin-2.png'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      "${currentAbsen['alamatPulang'] != null ? currentAbsen['alamatPulang'] : s.alamatLoc}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (currentAbsen?['longtitudePulang'] !=
                                            null &&
                                        currentAbsen?['latitudePulang'] !=
                                            null) {
                                      await openMap(
                                          currentAbsen?['latitudePulang'],
                                          currentAbsen?['longtitudePulang']);
                                    } else {
                                      return;
                                    }
                                  },
                                  style: ButtonStyle(
                                      elevation: MaterialStatePropertyAll(0),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide(
                                                  color: colorBluePrimary2,
                                                  width: 2)))),
                                  child: Text(
                                    "Buka Peta",
                                    style: TextStyle(
                                        color: colorBluePrimary2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
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
                                if (currentAbsen?['waktuCheckOut'] == null) {
                                  if (!s.klikAbsen) {
                                    s.mulaiAbsen();
                                  } else {
                                    if (currentAbsen?["idkaryawan"] ==
                                        s.user?["idkaryawan"]) {
                                      s.mulaiPulang(context, idAbsen);
                                    } else {
                                      customSnackbar1(
                                          "Kehadiran hari ini telah terisi.");
                                      return;
                                    }
                                  }
                                } else {
                                  customSnackbar1(
                                      "Kehadiran hari ini telah terisi.");
                                  return;
                                }
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
                              child: currentAbsen?["waktuCheckOut"] != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            getDuration(
                                                currentAbsen?["waktuCheckIn"],
                                                currentAbsen?["waktuCheckOut"]),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    )
                                  : timerCount(context, s)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
