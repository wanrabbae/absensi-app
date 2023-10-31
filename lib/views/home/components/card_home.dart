import 'package:app/global_resource.dart';

Widget dataHome(BuildContext context, s, isHadir) {
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
        itemBuilder: (ctx, index) => SizedBox(
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            // splashColor: colorBlueOpacity3,
            radius: 5,
            // onLongPress: () {
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
            // },
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
                  GestureDetector(
                    onTap: () {
                      isHadir
                          ? Get.toNamed(RouteName.absenViewMode,
                              arguments: {"dataAbsen": s.absen[index]})
                          : Get.toNamed(RouteName.absenIzinDownloaded,
                              arguments: s.izin[index]);
                    },
                    child: buildImageList(
                        context,
                        s.gambarAbsen(
                            isHadir ? s.absen[index] : s.izin[index], 1),
                        s.gambarAbsen(
                            isHadir ? s.absen[index] : s.izin[index], 2)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text.rich(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle:
                                        const StrutStyle(fontSize: 12.0),
                                    TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                      text: isHadir
                                          ? s.absen[index]['namaKaryawan']
                                          : s.izin?[index]['namaKaryawan'],
                                    ),
                                  ),
                                ),
                                // for
                                Text(
                                    getTimeFromDatetime(isHadir
                                        ? s.absen[index]["waktuCheckOut"] ??
                                            s.absen[index]['waktuCheckIn']
                                        : s.izin[index]['tanggalStart']),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Colors.black)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      isHadir
                                          ? Get.toNamed(RouteName.absenViewMode,
                                              arguments: {
                                                  "dataAbsen": s.absen[index]
                                                })
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
                                          : Get.toNamed(
                                              RouteName.absenIzinDownloaded,
                                              arguments: s.izin[index]);
                                    },
                                    child: isHadir
                                        ? Image.asset(
                                            'assets/icons/map-pin.png',
                                            width: 16,
                                          )
                                        : Text(s.izin[index]?["ijin"],
                                            maxLines: 1,
                                            softWrap: true,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        isHadir
                                            ? Get.toNamed(
                                                RouteName.absenViewMode,
                                                arguments: {
                                                    "dataAbsen": s.absen[index]
                                                  })
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
                                            : Get.toNamed(
                                                RouteName.absenIzinDownloaded,
                                                arguments: s.izin[index]);
                                      },
                                      child: Text(
                                          isHadir
                                              ? s?.absen[index]['alamatPulang'].toString()
                                                              as String ==
                                                          "null" &&
                                                      s?.absen[index]['alamatLoc']
                                                                  .toString()
                                                              as String ==
                                                          "null"
                                                  ? ""
                                                  : s?.absen[index]['alamatPulang']
                                                                  .toString()
                                                              as String !=
                                                          "null"
                                                      ? s?.absen[index]
                                                              ['alamatPulang']
                                                          .toString() as String
                                                      : s?.absen[index]['alamatLoc']
                                                          .toString() as String
                                              : "",
                                          maxLines: 1,
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.black)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  isHadir
                                      ? s.absen[index]["waktuCheckOut"] == null
                                          ? const Icon(
                                              Icons.circle,
                                              color: colorGreenPrimary2,
                                              size: 10,
                                            )
                                          : const Text("")
                                      : Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
