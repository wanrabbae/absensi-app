import 'package:app/global_resource.dart';

Widget dataHome(BuildContext context, s, isHadir) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 0),
      itemCount: isHadir ? s.absen?.length : s.izin?.length,
      itemBuilder: (ctx, index) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => dialogViewImage(
                          ctx,
                          s.gambarAbsen(
                              isHadir ? s.absen[index] : s.izin[index], 1),
                          s.gambarAbsen(
                              isHadir ? s.absen[index] : s.izin[index], 2)));
                },
                child: buildImageList(
                    context,
                    s.gambarAbsen(isHadir ? s.absen[index] : s.izin[index], 1),
                    s.gambarAbsen(isHadir ? s.absen[index] : s.izin[index], 2)),
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
                              child: Flexible(
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
                            ),
                            Text(
                                "${DataHelper.absences()[0].lastAbsenceRemark}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 7,
                                    color: Color.fromRGBO(51, 51, 51, 0.5))),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => dialogGoogleMap(ctx,
                                          latLng: LatLng(
                                              DataHelper.absences()[0]
                                                  .locationLat!,
                                              DataHelper.absences()[0]
                                                  .locationLng!),
                                          updateLocation: false));
                                },
                                child: const Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xFF18E22C),
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
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => dialogGoogleMap(ctx,
                                            latLng: LatLng(
                                                DataHelper.absences()[0]
                                                    .locationLat!,
                                                DataHelper.absences()[0]
                                                    .locationLng!),
                                            updateLocation: false));
                                  },
                                  child: Text(
                                      "${DataHelper.absences()[0].locationName}",
                                      maxLines: 1,
                                      softWrap: true,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                          color:
                                              Color.fromRGBO(51, 51, 51, 0.5))),
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
  );
}
