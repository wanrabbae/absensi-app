import 'package:app/global_resource.dart';

Widget dataHome(BuildContext context, s, bool isHadir) {
  Future onRefreshing() async {
    await s.dataHome();
  }

  return RefreshIndicator(
    onRefresh: onRefreshing,
    color: colorBluePrimary2,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: isHadir ? s.absen?.length : s.izin?.length,
        itemBuilder: (ctx, index) =>
            _ListTile(s: s, isHadir: isHadir, index: index),
      ),
    ),
  );
}

class _ListTile extends StatelessWidget {
  _ListTile({this.s, required this.isHadir, required this.index});

  final dynamic s;
  final bool isHadir;
  final int index;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // splashColor: colorBlueOpacity3,
      radius: 5,
      onLongPress: () {
        tooltipkey.currentState?.ensureTooltipVisible();
        Future.delayed(const Duration(seconds: 1), () {
          Tooltip.dismissAllToolTips();
        });
        //   isHadir
        //       ? showModalBottomSheet(
        //           shape: const RoundedRectangleBorder(
        //               borderRadius: BorderRadius.only(
        //                   topLeft: Radius.circular(20),
        //                   topRight: Radius.circular(20))),
        //           context: context,
        //           builder: (ctx) => DialogPresensi(
        //                 dataPresensi: s.absen[index],
        //                 isHadir: isHadir,
        //               )).then((value) {
        //           if (value != null) {
        //             Get.back();
        //             Get.toNamed(RouteName.absen);
        //           }
        //         })
        //       : showModalBottomSheet(
        //           shape: const RoundedRectangleBorder(
        //               borderRadius: BorderRadius.only(
        //                   topLeft: Radius.circular(20),
        //                   topRight: Radius.circular(20))),
        //           context: context,
        //           builder: (ctx) => DialogPresensi(
        //               dataPresensi: s.izin[index],
        //               isHadir: isHadir)).then((value) {
        //           if (value != null) {
        //             Get.back();
        //             Get.toNamed(RouteName.absen);
        //           }
        //         });
      },
      onTap: () {
        isHadir
            ? Get.toNamed(RouteName.absenViewMode,
                arguments: {"dataAbsen": s.absen[index]})
            : Get.toNamed(RouteName.absenIzinDownloaded,
                arguments: s.izin[index]);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildImage(isHadir, s, index, context),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      _buildNamaKaryawan(isHadir, s, index),
                      if (isHadir &&
                          s.absen[index]["waktuCheckOut"] == null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 4),
                          child: Tooltip(
                            triggerMode: TooltipTriggerMode.manual,
                            showDuration: const Duration(seconds: 1),
                            message: 'Aktif',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                            decoration: const BoxDecoration(
                              color: colorGreenPrimary2,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            preferBelow: false,
                            verticalOffset: -16,
                            margin: const EdgeInsets.only(left: 96),
                            key: tooltipkey,
                            child: const Icon(
                              Icons.circle,
                              color: colorGreenPrimary2,
                              size: 12,
                            ),
                          ),
                        ),
                      const Spacer(),
                      _buildTime(isHadir, s, index),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: _buildSubtitle(isHadir, s, index),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubtitle(bool isHadir, s, int index) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            isHadir
                ? Get.toNamed(RouteName.absenViewMode,
                    arguments: {"dataAbsen": s.absen[index]})
                // showDialog(
                //     context: context,
                //     builder: (ctx) => dialogGoogleMap(
                //         ctx,
                //         latLng: LatLng(
                //             double.parse(s?.absen[index]
                //                 ?["alamatLatitude"]),
                //             double.parse(s?.absen[index]
                //                 ?["alamatLongtitude"])),
                //         updateLocation: false))
                : Get.toNamed(RouteName.absenIzinDownloaded,
                    arguments: s.izin[index]);
          },
          child: isHadir
              ? Image.asset(
                  'assets/icons/map-pin.png',
                  width: 16,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/file-yellow.png',
                      height: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      s.izin[index]?["ijin"],
                      maxLines: 1,
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              isHadir
                  ? Get.toNamed(RouteName.absenViewMode,
                      arguments: {"dataAbsen": s.absen[index]})
                  // showDialog(
                  //     context: context,
                  //     builder: (ctx) => dialogGoogleMap(
                  //         ctx,
                  //         latLng: LatLng(
                  //             double.parse(s
                  //                     ?.absen[index]
                  //                 ?["alamatLatitude"]),
                  //             double.parse(s
                  //                     ?.absen[index]?[
                  //                 "alamatLongtitude"])),
                  //         updateLocation: false))
                  : Get.toNamed(RouteName.absenIzinDownloaded,
                      arguments: s.izin[index]);
            },
            child: Text(
              isHadir
                  ? s?.absen[index]['alamatPulang'].toString() as String ==
                              "null" &&
                          s?.absen[index]['alamatLoc'].toString() as String ==
                              "null"
                      ? ""
                      : s?.absen[index]['alamatPulang'].toString() as String !=
                              "null"
                          ? s?.absen[index]['alamatPulang'].toString() as String
                          : s?.absen[index]['alamatLoc'].toString() as String
                  : "",
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.keyboard_arrow_down, size: 20),
      ],
    );
  }

  Widget _buildTime(bool isHadir, s, int index) {
    return Text(
      getTimeFromDatetime(isHadir
          ? s.absen[index]["waktuCheckOut"] ?? s.absen[index]['waktuCheckIn']
          : s.izin[index]['tanggalStart']),
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildNamaKaryawan(bool isHadir, s, int index) {
    return Text(
      isHadir
          ? s.absen[index]['namaKaryawan']
          : s.izin?[index]['namaKaryawan'],
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      strutStyle: const StrutStyle(fontSize: 12.0),
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }

  GestureDetector _buildImage(
      bool isHadir, s, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        isHadir
            ? Get.toNamed(RouteName.absenViewMode,
                arguments: {"dataAbsen": s.absen[index]})
            : Get.toNamed(RouteName.absenIzinDownloaded,
                arguments: s.izin[index]);
      },
      child: buildImageList(
          context,
          s.gambarAbsen(isHadir ? s.absen[index] : s.izin[index], 1),
          s.gambarAbsen(isHadir ? s.absen[index] : s.izin[index], 2)),
    );
  }
}
