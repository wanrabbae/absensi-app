import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';

class AbsensiScreenView extends StatefulWidget {
  const AbsensiScreenView({super.key});

  @override
  State<AbsensiScreenView> createState() => _AbsensiScreenViewState();
}

class _AbsensiScreenViewState extends State<AbsensiScreenView> {
  var isDrag = true;
  Map<String, dynamic>? izinData;

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.put(HomeController());

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    var currentAbsen = Get.arguments?["dataAbsen"] ?? {};
    var idAbsen = Get.arguments?["dataAbsen"]?["id"];
    debugPrint("ID ABS: $idAbsen");
    var findDataIzin = homeCtrl.izin?.firstWhere(
      (element) => element?["idkaryawan"] == currentAbsen?["idkaryawan"],
      orElse: () => null,
    );
    if (findDataIzin != null) {
      setState(() {
        izinData = findDataIzin;
      });
    }

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (s) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: const Color.fromRGBO(238, 240, 244, 1),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(FeatherIcons.arrowLeft),
              onPressed: () {
                Get.back();
              },
            ),
            // centerTitle: false,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: true,
            title: TabBar(
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
                            )),
                  ),
                  Tab(
                    child: Text(
                      'Pulang',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          ),
                    ),
                  ),
                ]),
            backgroundColor: Colors.white,
          ),
          body: Container(
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
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          changeUrlImage(
                                              currentAbsen?['fotoKaryawan']),
                                          fit: BoxFit.cover,
                                        ),
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 130,
                                      child: Text(
                                        "${currentAbsen['alamatLoc'] ?? '-'}",
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
                                      await openMap(
                                          currentAbsen?['alamatLatitude'],
                                          currentAbsen?['alamatLongtitude']);
                                    },
                                    style: const ButtonStyle(
                                      elevation: MaterialStatePropertyAll(0),
                                      backgroundColor: MaterialStatePropertyAll(
                                          colorBlueOpacity2),
                                    ),
                                    child: const Text(
                                      "Buka",
                                      style: TextStyle(
                                          color: colorBluePrimary2,
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
                                        "${izinData?['ijin'] ?? '-'}",
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
                                      if (izinData?['ijin'] != null) {
                                        Get.toNamed(
                                            RouteName.absenIzinDownloaded,
                                            arguments: izinData);
                                      } else {
                                        return;
                                      }
                                    },
                                    style: ButtonStyle(
                                      elevation: const MaterialStatePropertyAll(0),
                                      backgroundColor: MaterialStatePropertyAll(
                                          izinData != null
                                              ? colorBlueOpacity2
                                              : colorBlueOpacity4),
                                    ),
                                    child: Text(
                                      "Buka",
                                      style: TextStyle(
                                          color: izinData != null
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
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          changeUrlImage(
                                            currentAbsen?['fotoPulang'],
                                          ),
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return izinData != null
                                                ? GestureDetector(
                                                    onTap: () => Get.toNamed(
                                                        RouteName
                                                            .hasilHadirFullScreen,
                                                        arguments: izinData?[
                                                            "iconIjin"]),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        changeUrlImage(
                                                          izinData?['iconIjin'],
                                                        ),
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object
                                                                    exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        boxShadow: const [
                                                                      BoxShadow(
                                                                          color:
                                                                              colorBlueOpacity2)
                                                                    ],
                                                                        // color: colorBlueOpacity2,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                child: Image.asset(
                                                                    'assets/icons/image.png'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                                boxShadow: const [
                                                              BoxShadow(
                                                                  color:
                                                                      colorBlueOpacity2)
                                                            ],
                                                                // color: colorBlueOpacity2,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                        child: Image.asset(
                                                            'assets/icons/image.png'),
                                                      ),
                                                    ],
                                                  );
                                          },
                                          fit: BoxFit.cover,
                                        ),
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 130,
                                      child: Text(
                                        "${currentAbsen?['alamatPulang'] == null ? '-' : currentAbsen['alamatPulang']}",
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
                                      print(currentAbsen);
                                      if (currentAbsen?['longtitudePulang'] !=
                                              null &&
                                          currentAbsen?['latitudePulang'] !=
                                              null) {
                                        if (izinData != null) {
                                          print(izinData);
                                          debugPrint("disabled");
                                        } else {
                                          await openMap(
                                              currentAbsen?['latitudePulang'],
                                              currentAbsen?[
                                                  'longtitudePulang']);
                                        }
                                      } else {
                                        debugPrint("kesini");
                                        return;
                                      }
                                    },
                                    style: ButtonStyle(
                                      elevation: const MaterialStatePropertyAll(0),
                                      backgroundColor: MaterialStatePropertyAll(
                                          currentAbsen?['longtitudePulang'] !=
                                                      null &&
                                                  currentAbsen?[
                                                          'latitudePulang'] !=
                                                      null
                                              ? izinData == null
                                                  ? colorBlueOpacity2
                                                  : colorBlueOpacity4
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
                                                      null
                                              ? izinData == null
                                                  ? colorBluePrimary2
                                                  : colorBluePrimary3
                                                      .withOpacity(0.5)
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
                                        "${izinData?['ijin'] ?? '-'}",
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
                                      if (izinData?['ijin'] != null) {
                                        Get.toNamed(
                                            RouteName.absenIzinDownloaded,
                                            arguments: izinData);
                                      } else {
                                        return;
                                      }
                                    },
                                    style: ButtonStyle(
                                      elevation: const MaterialStatePropertyAll(0),
                                      backgroundColor: MaterialStatePropertyAll(
                                          izinData != null
                                              ? colorBlueOpacity2
                                              : colorBlueOpacity4),
                                    ),
                                    child: Text(
                                      "Buka",
                                      style: TextStyle(
                                          color: izinData != null
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
                  // margin: EdgeInsets.only(top: 50),
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
                            // customSnackbar1(
                            //     "Kehadiran hari ini telah terisi.");
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  // s.klikAbsen
                                  //     ? colorGrayPrimary
                                  //     : colorBluePrimary
                                  Colors.grey.shade400),
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
                                  timerAbsen3(currentAbsen?["waktuCheckIn"],
                                      currentAbsen?["waktuCheckOut"]),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ))
                    ],
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
