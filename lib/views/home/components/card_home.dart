import 'package:app/global_resource.dart';

Widget dataHome(BuildContext context, s, isHadir) {
  print("IZIN: " + s.izin.length.toString());
  return Container(
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
                              Container(
                                width: 150,
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: StrutStyle(fontSize: 12.0),
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                      text: isHadir
                                          ? s.absen[index]['namaKaryawan']
                                          : s.izin?[index]['namaKaryawan']),
                                ),
                              ),
                              // for
                              Text(
                                  getTimeFromDatetime(isHadir
                                      ? s.absen[index]["waktuCheckOut"] == null
                                          ? s.absen[index]['waktuCheckIn']
                                          : s.absen[index]["waktuCheckOut"]
                                      : s.izin[index]['tanggalStart']),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Color.fromRGBO(51, 51, 51, 0.5))),
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
                                          'assets/icons/map-pin-filled.png',
                                          width: 16,
                                        )
                                      : Container(
                                          child: Text(s.izin[index]?["ijin"],
                                              maxLines: 1,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11,
                                                  color: Color.fromRGBO(
                                                      51, 51, 51, 0.5))),
                                        ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
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
                                            ? s?.absen[index]['alamatLoc']
                                                .toString() as String
                                            : "",
                                        maxLines: 1,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            color: Color.fromRGBO(
                                                51, 51, 51, 0.5))),
                                  ),
                                ),
                                isHadir
                                    ? s.absen[index]["waktuCheckOut"] == null
                                        ? Icon(
                                            Icons.circle,
                                            color: colorGreenPrimary2,
                                            size: 10,
                                          )
                                        : Text("")
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
  );
}
