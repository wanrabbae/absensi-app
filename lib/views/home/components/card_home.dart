import 'package:app/global_resource.dart';

Widget dataHome(BuildContext context, s, isHadir) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 0),
      itemCount: isHadir ? s.absen?.length : s.izin?.length,
      itemBuilder: (ctx, index) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          // splashColor: colorBlueOpacity3,
          radius: 5,
          onTap: () {
            isHadir
                ? print("hadir")
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
                        ? showDialog(
                            context: context,
                            builder: (ctx) => dialogViewImage(
                                ctx,
                                s.gambarAbsen(
                                    isHadir ? s.absen[index] : s.izin[index],
                                    1),
                                s.gambarAbsen(
                                    isHadir ? s.absen[index] : s.izin[index],
                                    2)))
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
                              Text(
                                  "${DataHelper.absences()[0].lastAbsenceRemark}",
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
                                        ? showDialog(
                                            context: context,
                                            builder: (ctx) => dialogGoogleMap(
                                                ctx,
                                                latLng: LatLng(
                                                    DataHelper.absences()[0]
                                                        .locationLat!,
                                                    DataHelper.absences()[0]
                                                        .locationLng!),
                                                updateLocation: false))
                                        : Get.toNamed(
                                            RouteName.absenIzinDownloaded,
                                            arguments: s.izin[index]);
                                  },
                                  child: const Icon(
                                    FeatherIcons.mapPin,
                                    // color: Color(0xFF18E22C),
                                    color: colorBlueOpacity3,
                                    size: 16,
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
                                          ? showDialog(
                                              context: context,
                                              builder: (ctx) => dialogGoogleMap(
                                                  ctx,
                                                  latLng: LatLng(
                                                      DataHelper.absences()[0]
                                                          .locationLat!,
                                                      DataHelper.absences()[0]
                                                          .locationLng!),
                                                  updateLocation: false))
                                          : Get.toNamed(
                                              RouteName.absenIzinDownloaded,
                                              arguments: s.izin[index]);
                                    },
                                    child: Text(
                                        "${DataHelper.absences()[0].locationName}",
                                        maxLines: 1,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            color: Color.fromRGBO(
                                                51, 51, 51, 0.5))),
                                  ),
                                ),
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
