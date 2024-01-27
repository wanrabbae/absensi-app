import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:app/components/component_constant.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/images.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const CameraPosition _kDefaultCenter = CameraPosition(
  target: LatLng(3.5729021, 98.6292165),
  zoom: 17,
);

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final panelController = PanelController();
  final rxExpanded = ValueNotifier(false);
  final rxMarkers = ValueNotifier(<Marker>[]);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  );

  dynamic get currentAbsen => Get.arguments?["dataAbsen"] ?? {};

  dynamic get idAbsen => Get.arguments?["dataAbsen"]?["id"];

  bool get isCheckedIn => currentAbsen?['waktuCheckIn'] != null;

  bool get isCheckedOut => currentAbsen?['waktuCheckOut'] != null;

  bool get showGoogleMap => isCheckedIn || isCheckedOut;

  LatLng get lastPosition {
    LatLng position = _kDefaultCenter.target;
    if (isCheckedIn) {
      final latitude =
          double.tryParse(currentAbsen?['alamatLatitude']) ?? position.latitude;
      final longitude = double.tryParse(currentAbsen?['alamatLongtitude']) ??
          position.longitude;
      position = LatLng(latitude, longitude);
    }

    if (isCheckedOut) {
      final latitude =
          double.tryParse(currentAbsen?['latitudePulang']) ?? position.latitude;
      final longitude = double.tryParse(currentAbsen?['longtitudePulang']) ??
          position.longitude;
      position = LatLng(latitude, longitude);
    }

    return position;
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setMarker(idAbsen);

      if (!showGoogleMap) {
        panelController.open();
      }

      final foto = currentAbsen?['fotoKaryawan']?.toString();
      if (foto == null) return;
      getGoogleMapsMarker(foto).then((BitmapDescriptor markerIcon) {
        if (!mounted) return;
        setState(() {
          this.markerIcon = markerIcon;
        });
        setMarker(idAbsen);
      });
    });
  }

  setMarker(dynamic idAbsen) {
    final title = currentAbsen?['alamatLoc'] ?? currentAbsen?['alamatPulang'];
    rxMarkers.value = [
      Marker(
        markerId: MarkerId(idAbsen.toString()),
        icon: markerIcon,
        position: lastPosition,
        infoWindow:
            title == null ? InfoWindow.noText : InfoWindow(title: title),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTabController(
          initialIndex: Get.arguments?["pulang"] as int? ?? 0,
          length: 2,
          child: GetBuilder<AbsenController>(
            init: AbsenController(),
            dispose: (state) {
              state.controller!.cancelTimer();
            },
            builder: (AbsenController s) {
              return WillPopScope(
                onWillPop: () => _popupConfirmationClose(s)
                    .then((confirmExit) => confirmExit == true),
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  backgroundColor: const Color.fromRGBO(238, 240, 244, 1),
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    leading: Container(
                      margin: const EdgeInsets.only(left: 16),
                      decoration: kCircleButtonDecoration,
                      child: const BackButton(),
                    ),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white,
                    ),
                  ),
                  body: Stack(
                    children: <Widget>[
                      ValueListenableBuilder(
                        valueListenable: rxMarkers,
                        builder: (context, markers, child) {
                          if (!showGoogleMap) return const SizedBox.shrink();

                          return GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kDefaultCenter,
                            zoomControlsEnabled: false,
                            padding: EdgeInsets.only(
                              bottom: constraints.maxHeight / 4,
                            ),
                            markers: markers.toSet(),
                          );
                        },
                      ),
                      SlidingUpPanel(
                        controller: panelController,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        minHeight: constraints.maxHeight / 4,
                        maxHeight: constraints.maxHeight * 0.875,
                        panel: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 2,
                                    color: colorBlueOpacity,
                                  ),
                                ),
                                ColumnSuper(
                                  innerDistance: -20,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: rxExpanded,
                                      builder: (context, expanded, child) {
                                        return AnimatedIconButton(
                                          animationController:
                                              animationController,
                                          size: 24,
                                          padding: EdgeInsets.zero,
                                          icons: [
                                            AnimatedIconItem(
                                              icon: const Icon(
                                                Icons.keyboard_arrow_up,
                                                color: colorBlackPrimaryHalf,
                                              ),
                                              onPressed: () {
                                                panelController.open();
                                              },
                                            ),
                                            AnimatedIconItem(
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: colorBlackPrimaryHalf,
                                              ),
                                              onPressed: () {
                                                panelController.close();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    const Center(child: _MainTabBar()),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  _HadirView(s: s, currentAbsen: currentAbsen),
                                  _PulangView(s: s, currentAbsen: currentAbsen),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onPanelClosed: () {
                          rxExpanded.value = false;
                          animationController.reverse();
                        },
                        onPanelOpened: () {
                          rxExpanded.value = true;
                          animationController.forward();
                        },
                        footer: InkWell(
                          onTap: () {
                            if (!s.klikAbsen) {
                              s.mulaiAbsen();
                            } else {
                              s.mulaiPulang(context, idAbsen);
                            }
                          },
                          child: Container(
                            width: constraints.maxWidth,
                            color: colorBluePrimary,
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: timerCount(context, s),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future _popupConfirmationClose(AbsenController s) =>
      SplashController().showConfirmationDialog4(
        tr('present'),
        s.timer != null
            ? tr('gohome_cancel_confirmation')
            : tr('presence_cancel_confirmation'),
        () => Get.back(),
      );
}

class _HadirView extends StatelessWidget {
  const _HadirView({
    required this.s,
    required this.currentAbsen,
  });

  final AbsenController s;
  final dynamic currentAbsen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      // height: 100,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Column(
          // shrinkWrap: true,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('photo'),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
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
                        arguments: currentAbsen?["fotoKaryawan"],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          changeUrlImage(
                            currentAbsen?['fotoKaryawan'],
                          ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(color: colorBlueOpacity2)
                                  ],
                                  // color: colorBlueOpacity2,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.asset('assets/icons/image.png'),
                            ),
                          ],
                        ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              tr('hour'),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorBlueOpacity2,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/clock.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  currentAbsen?['waktuCheckIn'] != null
                      ? getTimeFullFromDatetime(currentAbsen?['waktuCheckIn'])
                      : '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 10),
            Text(
              tr('location'),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 5),
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
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/map-pin-2.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
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
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (currentAbsen?['alamatLatitude'] != null &&
                        currentAbsen?['alamatLongtitude'] != null) {
                      await openMap(currentAbsen?['alamatLatitude'],
                          currentAbsen?['alamatLongtitude']);
                    } else {
                      if (s.alamatLoc != null) {
                        await openMap(
                          s.currentLocation.latitude.toString(),
                          s.currentLocation.longitude.toString(),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStatePropertyAll(
                      currentAbsen?['alamatLongtitude'] != null &&
                                  currentAbsen?['alamatLatitude'] != null ||
                              s.alamatLoc != null
                          ? colorBlueOpacity2
                          : colorBlueOpacity4,
                    ),
                  ),
                  child: Text(
                    tr('open'),
                    style: TextStyle(
                      color: currentAbsen?['alamatLongtitude'] != null &&
                                  currentAbsen?['alamatLatitude'] != null ||
                              s.alamatLoc != null
                          ? colorBluePrimary2
                          : colorBluePrimary3.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 10),
            Text(
              tr('permit'),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/file-yellow.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 130,
                      child: Text(
                        "${s.izinData?['ijin'] ?? '-'}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (s.izinData?['ijin'] != null) {
                      Get.toNamed(RouteName.absenIzinDownloaded,
                          arguments: s.izinData?['ijin']);
                    }
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStatePropertyAll(
                      s.izinData != null
                          ? colorBlueOpacity2
                          : colorBlueOpacity4,
                    ),
                  ),
                  child: Text(
                    tr('open'),
                    style: TextStyle(
                      color: s.izinData != null
                          ? colorBluePrimary2
                          : colorBluePrimary3.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
          ],
        ),
      ),
    );
  }
}

class _PulangView extends StatelessWidget {
  const _PulangView({
    required this.s,
    required this.currentAbsen,
  });

  final AbsenController s;
  final dynamic currentAbsen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('photo'),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              height: 320,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: currentAbsen?['fotoPulang'] != null
                  ? GestureDetector(
                      onTap: () => Get.toNamed(RouteName.hasilHadirFullScreen,
                          arguments: currentAbsen?["fotoPulang"]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          changeUrlImage(currentAbsen?['fotoPulang']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : s.formFotoPulang != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(s.formFotoPulang!.path),
                            fit: BoxFit.fill,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(color: colorBlueOpacity2)
                                  ],
                                  // color: colorBlueOpacity2,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.asset('assets/icons/image.png'),
                            ),
                          ],
                        ),
            ),
            const SizedBox(height: 20),
            Text(
              tr('hour'),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorBlueOpacity2,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/clock.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  currentAbsen?['waktuCheckOut'] != null
                      ? getTimeFullFromDatetime(currentAbsen?['waktuCheckOut'])
                      : '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 10),
            Text(
              tr('location'),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/map-pin-2.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 130,
                      child: Text(
                        "${currentAbsen?['alamatPulang'] != null ? currentAbsen['alamatPulang'] : s.alamatLocPulang ?? '-'}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (currentAbsen?['longtitudePulang'] != null &&
                        currentAbsen?['latitudePulang'] != null) {
                      await openMap(currentAbsen?['latitudePulang'],
                          currentAbsen?['longtitudePulang']);
                    } else {
                      if (s.alamatLocPulang != null) {
                        await openMap(
                          s.currentLocationPulang.latitude.toString(),
                          s.currentLocationPulang.longitude.toString(),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStatePropertyAll(
                      currentAbsen?['longtitudePulang'] != null &&
                                  currentAbsen?['latitudePulang'] != null ||
                              s.alamatLocPulang != null
                          ? colorBlueOpacity2
                          : colorBlueOpacity4,
                    ),
                  ),
                  child: Text(
                    tr('open'),
                    style: TextStyle(
                      color: currentAbsen?['longtitudePulang'] != null &&
                                  currentAbsen?['latitudePulang'] != null ||
                              s.alamatLocPulang != null
                          ? colorBluePrimary2
                          : colorBluePrimary3.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 10),
            Text(
              tr('permit'),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 5),
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/file-yellow.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 130,
                      child: Text(
                        "${s.izinData?['ijin'] ?? '-'}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (s.izinData?['ijin'] != null) {
                      Get.toNamed(
                        RouteName.absenIzinDownloaded,
                        arguments: s.izinData?['ijin'],
                      );
                    }
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStatePropertyAll(
                      s.izinData != null
                          ? colorBlueOpacity2
                          : colorBlueOpacity4,
                    ),
                  ),
                  child: Text(
                    tr('open'),
                    style: TextStyle(
                      color: s.izinData != null
                          ? colorBluePrimary2
                          : colorBluePrimary3.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
          ],
        ),
      ),
    );
  }
}

class _MainTabBar extends StatelessWidget {
  const _MainTabBar();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      dividerColor: Colors.white,
      unselectedLabelColor: Colors.black.withOpacity(0.3),
      labelColor: Colors.black,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        fontFamily: kGlobalFontFamily,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        fontFamily: kGlobalFontFamily,
      ),
      indicatorColor: colorBluePrimary2,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: [
        Tab(child: Text(tr('present'))),
        Tab(child: Text(tr('go_home'))),
      ],
    );
  }
}
