import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:app/components/component_constant.dart';
import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/data/models/absence.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/images.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const CameraPosition _kDefaultCenter = CameraPosition(
  target: LatLng(3.5729021, 98.6292165),
  zoom: 17,
);

class AbsensiScreenView extends StatefulWidget {
  const AbsensiScreenView({super.key});

  @override
  State<AbsensiScreenView> createState() => _AbsensiScreenViewState();
}

class _AbsensiScreenViewState extends State<AbsensiScreenView>
    with SingleTickerProviderStateMixin {
  late final HomeController homeCtrl;
  late final AnimationController animationController;
  final panelController = PanelController();
  final rxExpanded = ValueNotifier(false);
  final rxMarkers = ValueNotifier(<Marker>[]);
  final rxPosition = ValueNotifier(_kDefaultCenter.target);
  final rxPositionUpdate = ValueNotifier<DateTime?>(null);
  final completer = Completer<GoogleMapController>();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  );
  Map<String, dynamic>? izinData;

  dynamic get currentAbsen => Get.arguments?["dataAbsen"] ?? {};

  Absence get absence => Absence.fromJson(currentAbsen);

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    if (Get.isRegistered<HomeController>()) {
      homeCtrl = Get.find<HomeController>();
    } else {
      homeCtrl = Get.put(HomeController());
    }

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var findDataIzin = homeCtrl.izin?.firstWhere(
        (element) => element?["idkaryawan"] == absence.idKaryawan,
        orElse: () => null,
      );
      if (findDataIzin != null) {
        setState(() {
          izinData = findDataIzin;
        });
      }

      final latLng = absence.checkInLocation ?? absence.checkOutLocation;
      if (latLng != null) {
        rxPosition.value = latLng;
      }

      final update = absence.waktuCheckIn ?? absence.waktuCheckOut;
      if (update != null) {
        rxPositionUpdate.value = update;
      }

      final broadcasterId = absence.idKaryawan;
      if (broadcasterId != null) {
        final data = context.read<AppCubit>().state.liveTracking(broadcasterId);
        if (data != null && data.latitude != null && data.longitude != null) {
          rxPosition.value = LatLng(data.latitude!, data.longitude!);
          if (data.lastUpdate != null) {
            rxPositionUpdate.value = data.lastUpdate;
          }
        }
      }

      setMarker();

      final foto = absence.fotoKaryawan;
      if (foto == null) return;
      getGoogleMapsMarker(foto).then((BitmapDescriptor markerIcon) {
        if (!mounted) return;
        setState(() {
          this.markerIcon = markerIcon;
        });
        setMarker();
      });
    });
  }

  setMarker() {
    rxMarkers.value = [
      Marker(
        markerId: MarkerId('${absence.id}'),
        icon: markerIcon,
        position: rxPosition.value,
      ),
    ];
    completer.future.then((controller) {
      controller.animateCamera(CameraUpdate.newLatLng(rxPosition.value));
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: GetBuilder<HomeController>(
            builder: (HomeController s) {
              // final body = Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              //   padding: Platform.isAndroid
              //       ? const EdgeInsets.only(top: 100)
              //       : const EdgeInsets.only(top: 130),
              //   color: Colors.white,
              //   child: Column(
              //     children: [
              //       Expanded(
              //         child: TabBarView(
              //           children: <Widget>[
              //             _HadirView(
              //               currentAbsen: currentAbsen,
              //               izinData: izinData,
              //             ),
              //             _PulangView(
              //               currentAbsen: currentAbsen,
              //               izinData: izinData,
              //             ),
              //           ],
              //         ),
              //       ),
              //       const SizedBox(height: 10),
              //       Container(
              //         // margin: EdgeInsets.only(top: 50),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //               color: colorBlueOpacity3.withOpacity(0.5),
              //               blurRadius: 3,
              //               offset: const Offset(0, -2),
              //             ),
              //           ],
              //         ),
              //         padding: const EdgeInsets.only(
              //           top: 10,
              //           left: 20,
              //           right: 20,
              //           bottom: 20,
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             const Text(
              //               "Tekan tombol untuk masuk/pulang",
              //               style: TextStyle(
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w500,
              //                 color: Color.fromRGBO(51, 51, 51, 0.5),
              //               ),
              //             ),
              //             const SizedBox(height: 10),
              //             ElevatedButton(
              //               onPressed: () {
              //                 // customSnackbar1(
              //                 //     "Kehadiran hari ini telah terisi.");
              //               },
              //               style: ButtonStyle(
              //                 backgroundColor: MaterialStatePropertyAll(
              //                   // s.klikAbsen
              //                   //     ? colorGrayPrimary
              //                   //     : colorBluePrimary
              //                   Colors.grey.shade400,
              //                 ),
              //                 shape: const MaterialStatePropertyAll(
              //                   RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.all(
              //                       Radius.circular(20),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               child: Padding(
              //                 padding:
              //                     const EdgeInsets.only(top: 20, bottom: 20),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.max,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     const Icon(
              //                       FeatherIcons.clock,
              //                       size: 18,
              //                       color: Colors.white,
              //                     ),
              //                     const SizedBox(width: 8),
              //                     Text(
              //                       timerAbsen3(
              //                         currentAbsen?["waktuCheckIn"],
              //                         currentAbsen?["waktuCheckOut"],
              //                       ),
              //                       style: const TextStyle(
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.w700,
              //                         fontSize: 16,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // );

              return Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: const Color.fromRGBO(238, 240, 244, 1),
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: ValueListenableBuilder(
                    valueListenable: rxExpanded,
                    builder: (context, expanded, child) {
                      if (!expanded) return const SizedBox.shrink();

                      return AnimatedBuilder(
                        animation: rxPositionUpdate,
                        builder: (context, child) {
                          final date = rxPositionUpdate.value;
                          if (date == null) return const SizedBox.shrink();

                          return _LastUpdatePositionContainer(date: date);
                        },
                      );
                    },
                  ),
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
                  actions: [
                    Container(
                      width: 40,
                      decoration: kCircleButtonDecoration,
                      child: BlocBuilder<AppCubit, AppState>(
                        buildWhen: (previous, current) =>
                            previous.currentUser != current.currentUser ||
                            previous.todayAttendance != current.todayAttendance,
                        builder: (context, state) {
                          final listenerId = state.currentUser?.idkaryawan;
                          final broadcasterId = absence.idKaryawan;
                          final isCheckOut = absence.isCheckOut;
                          final todayAttendance = state.todayAttendance;

                          final disabled = listenerId != null &&
                              broadcasterId != null &&
                              listenerId == broadcasterId;

                          return IconButton(
                            onPressed: isCheckOut
                                ? null
                                : () {
                                    if (todayAttendance == null) {
                                      customSnackbar1('Anda belum melakukan absensi hari ini');
                                      return;
                                    }

                                    if (disabled) {
                                      customSnackbar1(
                                        'Tidak bisa melakukan permintaan lokasi kepada data sendiri',
                                      );
                                      return;
                                    }

                                    if (broadcasterId != null) {
                                      customSnackbar1(
                                          'Permintaan lokasi terkirim');
                                      context
                                          .read<AppCubit>()
                                          .requestLiveTracking(broadcasterId);
                                    }
                                  },
                            icon: Image.asset(
                              'assets/icons/crosshair.png',
                              height: 24,
                              color: disabled || isCheckOut
                                  ? colorDisabled
                                  : colorBluePrimary,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
                body: Stack(
                  children: <Widget>[
                    ValueListenableBuilder(
                      valueListenable: rxMarkers,
                      builder: (context, markers, child) {
                        return GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _kDefaultCenter,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          padding: EdgeInsets.only(
                            bottom: constraints.maxHeight / 4,
                          ),
                          markers: markers.toSet(),
                          onMapCreated: (controller) {
                            if (!completer.isCompleted) {
                              completer.complete(controller);
                            }
                          },
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: rxPositionUpdate,
                      builder: (context, child) {
                        final date = rxPositionUpdate.value;
                        if (date == null) return const SizedBox.shrink();

                        return Positioned(
                          left: 0,
                          right: 0,
                          bottom: (constraints.maxHeight / 4) + 16,
                          child: _LastUpdatePositionContainer(date: date),
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
                                _HadirView(
                                  currentAbsen: currentAbsen,
                                  izinData: izinData,
                                ),
                                _PulangView(
                                  currentAbsen: currentAbsen,
                                  izinData: izinData,
                                ),
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
                      footer: Container(
                        width: constraints.maxWidth,
                        color: colorBluePrimary,
                        padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.access_time_filled,
                              size: 24,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                timerAbsen3(
                                  currentAbsen?["waktuCheckIn"],
                                  currentAbsen?["waktuCheckOut"],
                                ).replaceAll(':', ' : '),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 24,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) =>
          previous.liveTrackingList != current.liveTrackingList,
      listener: (context, state) {
        final broadcasterId = absence.idKaryawan;
        if (broadcasterId == null) return;
        final data = state.liveTracking(broadcasterId);
        if (data == null) return;
        if (data.latitude != null && data.longitude != null) {
          customSnackbar1('Sedang mendeteksi lokasi terbaru...');
          rxPosition.value = LatLng(data.latitude!, data.longitude!);
          if (data.lastUpdate != null) {
            rxPositionUpdate.value = data.lastUpdate;
          }
          setMarker();
        }
      },
      child: child,
    );
  }
}

class _LastUpdatePositionContainer extends StatelessWidget {
  const _LastUpdatePositionContainer({
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: colorBlackPrimary,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding:
            const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Text(
          'Diperbarui ${kLastUpdatePositionDateFormat.format(date.toLocal())}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _PulangView extends StatelessWidget {
  const _PulangView({
    required this.currentAbsen,
    required this.izinData,
  });

  final dynamic currentAbsen;
  final Map<String, dynamic>? izinData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Foto",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            _PulangFotoView(currentAbsen: currentAbsen, izinData: izinData),
            const SizedBox(height: 20),
            const Text(
              "Jam",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            _PulangTimeView(currentAbsen: currentAbsen),
            const SizedBox(
              height: 2,
            ),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 10),
            const Text(
              "Lokasi",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            _PulangLocationView(currentAbsen: currentAbsen, izinData: izinData),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 10),
            const Text(
              "Izin",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            _PulangIzinView(izinData: izinData),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _PulangIzinView extends StatelessWidget {
  const _PulangIzinView({
    required this.izinData,
  });

  final Map<String, dynamic>? izinData;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                "${izinData?['ijin'] ?? '-'}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            if (izinData?['ijin'] != null) {
              Get.toNamed(RouteName.absenIzinDownloaded, arguments: izinData);
            }
          },
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(
              izinData != null ? colorBlueOpacity2 : colorBlueOpacity4,
            ),
          ),
          child: Text(
            "Buka",
            style: TextStyle(
              color: izinData != null
                  ? colorBluePrimary2
                  : colorBluePrimary3.withOpacity(0.5),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _PulangLocationView extends StatelessWidget {
  const _PulangLocationView({
    required this.currentAbsen,
    required this.izinData,
  });

  final dynamic currentAbsen;
  final Map<String, dynamic>? izinData;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                "${currentAbsen?['alamatPulang'] == null ? '-' : currentAbsen['alamatPulang']}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            if (currentAbsen?['longtitudePulang'] != null &&
                currentAbsen?['latitudePulang'] != null) {
              if (izinData == null) {
                await openMap(
                  currentAbsen?['latitudePulang'],
                  currentAbsen?['longtitudePulang'],
                );
              }
            }
          },
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(
              currentAbsen?['longtitudePulang'] != null &&
                      currentAbsen?['latitudePulang'] != null
                  ? izinData == null
                      ? colorBlueOpacity2
                      : colorBlueOpacity4
                  : colorBlueOpacity4,
            ),
          ),
          child: Text(
            "Buka",
            style: TextStyle(
              color: currentAbsen?['longtitudePulang'] != null &&
                      currentAbsen?['latitudePulang'] != null
                  ? izinData == null
                      ? colorBluePrimary2
                      : colorBluePrimary3.withOpacity(0.5)
                  : colorBluePrimary3.withOpacity(0.5),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _PulangTimeView extends StatelessWidget {
  const _PulangTimeView({
    required this.currentAbsen,
  });

  final dynamic currentAbsen;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              ? getTimeFullFromDatetime(
                  currentAbsen?['waktuCheckOut'],
                )
              : '-',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _PulangFotoView extends StatelessWidget {
  const _PulangFotoView({
    required this.currentAbsen,
    required this.izinData,
  });

  final dynamic currentAbsen;
  final Map<String, dynamic>? izinData;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                arguments: currentAbsen?["fotoPulang"],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  changeUrlImage(
                    currentAbsen?['fotoPulang'],
                  ),
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return izinData != null
                        ? GestureDetector(
                            onTap: () => Get.toNamed(
                                RouteName.hasilHadirFullScreen,
                                arguments: izinData?["iconIjin"]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                changeUrlImage(
                                  izinData?['iconIjin'],
                                ),
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
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
                          );
                  },
                  fit: BoxFit.cover,
                ),
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
                    boxShadow: const [BoxShadow(color: colorBlueOpacity2)],
                    // color: colorBlueOpacity2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/icons/image.png',
                  ),
                ),
              ],
            ),
    );
  }
}

class _HadirView extends StatelessWidget {
  const _HadirView({
    required this.currentAbsen,
    required this.izinData,
  });

  final dynamic currentAbsen;
  final Map<String, dynamic>? izinData;

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
            const Text(
              "Foto",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            _HadirFotoView(currentAbsen: currentAbsen),
            const SizedBox(height: 20),
            const Text(
              "Jam",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            _HadirTimeView(currentAbsen: currentAbsen),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 10),
            const Text(
              "Lokasi",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            _HadirLocationView(currentAbsen: currentAbsen),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 10),
            const Text(
              "Izin",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            _HadirIzinView(izinData: izinData),
            const SizedBox(height: 2),
            const Divider(color: colorBlueOpacity2),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _HadirIzinView extends StatelessWidget {
  const _HadirIzinView({
    required this.izinData,
  });

  final Map<String, dynamic>? izinData;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                "${izinData?['ijin'] ?? '-'}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            if (izinData?['ijin'] != null) {
              Get.toNamed(
                RouteName.absenIzinDownloaded,
                arguments: izinData,
              );
            }
          },
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(
              izinData != null ? colorBlueOpacity2 : colorBlueOpacity4,
            ),
          ),
          child: Text(
            "Buka",
            style: TextStyle(
                color: izinData != null
                    ? colorBluePrimary2
                    : colorBluePrimary3.withOpacity(0.5),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _HadirLocationView extends StatelessWidget {
  const _HadirLocationView({
    required this.currentAbsen,
  });

  final dynamic currentAbsen;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                "${currentAbsen['alamatLoc'] ?? '-'}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            await openMap(
              currentAbsen?['alamatLatitude'],
              currentAbsen?['alamatLongtitude'],
            );
          },
          style: const ButtonStyle(
            elevation: MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(
              colorBlueOpacity2,
            ),
          ),
          child: const Text(
            "Buka",
            style: TextStyle(
              color: colorBluePrimary2,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _HadirTimeView extends StatelessWidget {
  const _HadirTimeView({
    required this.currentAbsen,
  });

  final dynamic currentAbsen;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              ? getTimeFullFromDatetime(
                  currentAbsen?['waktuCheckIn'],
                )
              : '-',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class _HadirFotoView extends StatelessWidget {
  const _HadirFotoView({
    required this.currentAbsen,
  });

  final dynamic currentAbsen;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  fit: BoxFit.cover,
                ),
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
                      BoxShadow(
                        color: colorBlueOpacity2,
                      )
                    ],
                    // color: colorBlueOpacity2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/icons/image.png',
                  ),
                ),
              ],
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
      tabs: const [
        Tab(child: Text('Hadir')),
        Tab(child: Text('Pulang')),
      ],
    );
  }
}
