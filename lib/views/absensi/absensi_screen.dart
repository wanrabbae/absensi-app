import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

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
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    var currentAbsen = Get.arguments?["dataAbsen"] ?? {};
    var idAbsen = Get.arguments?["dataAbsen"]?["id"];

    return DefaultTabController(
      initialIndex: Get.arguments?["pulang"] ?? 0,
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
              icon: const Icon(FeatherIcons.arrowLeft),
              onPressed: () {
                SplashController().showConfirmationDialog4(
                    "Hadir",
                    s.timer != null
                        ? "Anda batal pulang?"
                        : "Batal mengisi kehadiran?", () {
                  Get.back();
                });
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
                      const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  // padding: EdgeInsets.symmetric(horizontal: 70),
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  indicatorColor: colorBluePrimary2,
                  indicatorPadding: const EdgeInsets.only(bottom: 5),
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      child: Text('Hadir',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: 'Rubik')),
                    ),
                    Tab(
                      child: Text(
                        'Pulang',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            fontFamily: 'Rubik'),
                      ),
                    ),
                  ]),
            ),
            backgroundColor: Colors.white,
          ),
          body: WillPopScope(
            onWillPop: () async {
              // This function will be called when the user presses the back button
              // Return true to allow the default back button behavior or false to perform custom actions
              // For example, you can show a confirmation dialog here
              bool confirmExit = await SplashController()
                  .showConfirmationDialog4(
                      "Hadir",
                      s.timer != null
                          ? "Anda batal pulang?"
                          : "Batal mengisi kehadiran?", () {
                Get.back();
              });

              return confirmExit ?? false;
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: Platform.isAndroid
                  ? const EdgeInsets.only(top: 100)
                  : const EdgeInsets.only(top: 130),
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        // height: 100,
                        child: SingleChildScrollView(
                          child: Column(
                            // shrinkWrap: true,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Foto",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 320,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: currentAbsen?['fotoKaryawan'] != null
                                    ? GestureDetector(
                                        onTap: () => Get.toNamed(
                                            RouteName.hasilHadirFullScreen,
                                            arguments:
                                                currentAbsen?["fotoKaryawan"]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            changeUrlImage(
                                                currentAbsen?['fotoKaryawan']),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : s.formFoto != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color:
                                                              colorBlueOpacity2)
                                                    ],
                                                    // color: colorBlueOpacity2,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Image.asset(
                                                    'assets/icons/image.png'),
                                              ),
                                            ],
                                          ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Jam",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                                        'assets/icons/clock.png',
                                        width: 100,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    currentAbsen?['waktuCheckIn'] != null ? getTimeFullFromDatetime(currentAbsen?['waktuCheckIn']) : '-',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(
                                color: colorBlueOpacity2,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Lokasi",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          "${currentAbsen?['alamatLoc'] != null ? currentAbsen['alamatLoc'] : s.alamatLoc ?? '-'}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
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
                                            currentAbsen?['alamatLongtitude'] !=
                                                null) {
                                          await openMap(
                                              currentAbsen?['alamatLatitude'],
                                              currentAbsen?[
                                                  'alamatLongtitude']);
                                        } else {
                                          debugPrint("KE ELSE");
                                          s.alamatLoc == null
                                              ? debugPrint("TEST")
                                              : await openMap(
                                                  s.currentLocation.latitude
                                                      .toString(),
                                                  s.currentLocation.longitude
                                                      .toString());
                                        }
                                      },
                                      style: ButtonStyle(
                                        elevation: const MaterialStatePropertyAll(0),
                                        backgroundColor: MaterialStatePropertyAll(
                                            currentAbsen?['alamatLongtitude'] !=
                                                            null &&
                                                        currentAbsen?[
                                                                'alamatLatitude'] !=
                                                            null ||
                                                    s.alamatLoc != null
                                                ? colorBlueOpacity2
                                                : colorBlueOpacity4),
                                      ),
                                      child: Text(
                                        "Buka",
                                        style: TextStyle(
                                            color: currentAbsen?[
                                                                'alamatLongtitude'] !=
                                                            null &&
                                                        currentAbsen?[
                                                                'alamatLatitude'] !=
                                                            null ||
                                                    s.alamatLoc != null
                                                ? colorBluePrimary2
                                                : colorBluePrimary3
                                                    .withOpacity(0.5),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(
                                color: colorBlueOpacity2,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Izin",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: colorBlueOpacity2,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Icon(
                                          FeatherIcons.paperclip,
                                          color: colorBluePrimary2,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          "${s.izinData?['ijin'] ?? '-'}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (s.izinData?['ijin'] != null) {
                                          Get.toNamed(
                                              RouteName.absenIzinDownloaded,
                                              arguments: s.izinData?['ijin']);
                                        } else {
                                          return;
                                        }
                                      },
                                      style: ButtonStyle(
                                        elevation: const MaterialStatePropertyAll(0),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                s.izinData != null
                                                    ? colorBlueOpacity2
                                                    : colorBlueOpacity4),
                                      ),
                                      child: Text(
                                        "Buka",
                                        style: TextStyle(
                                            color: s.izinData != null
                                                ? colorBluePrimary2
                                                : colorBluePrimary3
                                                    .withOpacity(0.5),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(
                                color: colorBlueOpacity2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Foto",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 320,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: currentAbsen?['fotoPulang'] != null
                                    ? GestureDetector(
                                        onTap: () => Get.toNamed(
                                            RouteName.hasilHadirFullScreen,
                                            arguments:
                                                currentAbsen?["fotoPulang"]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            changeUrlImage(
                                                currentAbsen?['fotoPulang']),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : s.formFotoPulang != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.file(
                                              File(s.formFotoPulang!.path),
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
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color:
                                                              colorBlueOpacity2)
                                                    ],
                                                    // color: colorBlueOpacity2,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Image.asset(
                                                    'assets/icons/image.png'),
                                              ),
                                            ],
                                          ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Jam",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                                        'assets/icons/clock.png',
                                        width: 100,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    currentAbsen?['waktuCheckOut'] != null ? getTimeFullFromDatetime(currentAbsen?['waktuCheckOut']) : '-',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(
                                color: colorBlueOpacity2,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Lokasi",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          "${currentAbsen?['alamatPulang'] != null ? currentAbsen['alamatPulang'] : s.alamatLocPulang ?? '-'}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
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
                                              currentAbsen?[
                                                  'longtitudePulang']);
                                        } else {
                                          debugPrint("kesini");
                                          s.alamatLocPulang == null
                                              ? debugPrint("TEST")
                                              : await openMap(
                                                  s.currentLocationPulang
                                                      .latitude
                                                      .toString(),
                                                  s.currentLocationPulang
                                                      .longitude
                                                      .toString());
                                        }
                                      },
                                      style: ButtonStyle(
                                        elevation: const MaterialStatePropertyAll(0),
                                        backgroundColor: MaterialStatePropertyAll(
                                            currentAbsen?['longtitudePulang'] !=
                                                            null &&
                                                        currentAbsen?[
                                                                'latitudePulang'] !=
                                                            null ||
                                                    s.alamatLocPulang != null
                                                ? colorBlueOpacity2
                                                : colorBlueOpacity4),
                                      ),
                                      child: Text(
                                        "Buka",
                                        style: TextStyle(
                                            color: currentAbsen?[
                                                                'longtitudePulang'] !=
                                                            null &&
                                                        currentAbsen?[
                                                                'latitudePulang'] !=
                                                            null ||
                                                    s.alamatLocPulang != null
                                                ? colorBluePrimary2
                                                : colorBluePrimary3
                                                    .withOpacity(0.5),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(
                                color: colorBlueOpacity2,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Izin",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: colorBlueOpacity2,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: const Icon(
                                          FeatherIcons.paperclip,
                                          color: colorBluePrimary2,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          "${s.izinData?['ijin'] ?? '-'}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (s.izinData?['ijin'] != null) {
                                          Get.toNamed(
                                              RouteName.absenIzinDownloaded,
                                              arguments: s.izinData?['ijin']);
                                        } else {
                                          return;
                                        }
                                      },
                                      style: ButtonStyle(
                                        elevation: const MaterialStatePropertyAll(0),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                s.izinData != null
                                                    ? colorBlueOpacity2
                                                    : colorBlueOpacity4),
                                      ),
                                      child: Text(
                                        "Buka",
                                        style: TextStyle(
                                            color: s.izinData != null
                                                ? colorBluePrimary2
                                                : colorBluePrimary3
                                                    .withOpacity(0.5),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Divider(
                                color: colorBlueOpacity2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: colorBlueOpacity3.withOpacity(0.5),
                            blurRadius: 3,
                            offset: const Offset(0, -2))
                      ],
                    ),
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Tekan tombol untuk masuk/pulang",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(51, 51, 51, 0.5)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (!s.klikAbsen) {
                                s.mulaiAbsen();
                              } else {
                                s.mulaiPulang(context, idAbsen);
                              }
                            },
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    // s.klikAbsen
                                    //     ? colorGrayPrimary
                                    //     : colorBluePrimary
                                    colorBluePrimary),
                                shape: MaterialStatePropertyAll(
                                    (RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))))),
                            child: timerCount(context, s))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
