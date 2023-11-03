import 'package:app/global_resource.dart';

class DialogPermission extends HookConsumerWidget {
  const DialogPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: ovalCardIcon(context, FeatherIcons.x,
                            onTaped: () => Get.back()),
                      ),
                    ],
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Perizinan perangkat",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color.fromRGBO(51, 51, 51, 1)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/ic_settings.png",
                    width: 55,
                    height: 55,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Anda diperlukan untuk memberikan izin: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(51, 51, 51, 1)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Icon(
                      FeatherIcons.camera,
                      size: 17,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Kamera",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    Icon(
                      FeatherIcons.mapPin,
                      size: 17,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Lokasi",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    Icon(
                      FeatherIcons.folder,
                      size: 17,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Penyimpanan",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(colorBluePrimary),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))),
                        onPressed: () async {
                          Map<Permission, PermissionStatus> statuses = await [
                            Permission.camera,
                            Permission.location,
                            // Permission.storage,
                          ].request();
                          print(statuses);
                          if (statuses[Permission.camera] ==
                                  PermissionStatus.granted &&
                              statuses[Permission.location] ==
                                  PermissionStatus.granted) {
                            debugPrint("KE THEN DIALOG PERMISSION");
                            Get.back();
                            Get.toNamed(RouteName.absen);
                          } else if (statuses[Permission.camera] ==
                                  PermissionStatus.permanentlyDenied &&
                              statuses[Permission.location] ==
                                  PermissionStatus.permanentlyDenied) {
                            debugPrint("KE ELSE IF DIALOG PERMISSION");
                            Get.back();
                            if (Platform.isIOS) {
                              Get.toNamed(RouteName.absen);
                            }
                            // openAppSettings();
                            // await Permission.location.request();
                          } else if (Platform.isIOS) {
                            Get.back();
                            Get.toNamed(RouteName.absen);
                          }
                        },
                        child: const Text(
                          "Izinkan",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DialogPresensi extends HookConsumerWidget {
  final dynamic dataPresensi, isHadir;

  const DialogPresensi({
    super.key,
    required this.dataPresensi,
    required this.isHadir,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 700,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
            child: Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: ovalCardIcon(context, FeatherIcons.x,
                      onTaped: () => Get.back()),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Riwayat",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color.fromRGBO(51, 51, 51, 1)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              children: [
                const Text(
                  "Tanggal",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: isHadir
                      ? changeFormatDate(5, dataPresensi["tanggalAbsensi"])
                      : changeFormatDate(5, dataPresensi["tanggalCuti"]),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: "Ketikkan disini",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: isHadir
                      ? dataPresensi["waktuCheckOut"] == null
                          ? "Aktif"
                          : "Tidak Aktif"
                      : "Tidak aktif",
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isHadir
                          ? dataPresensi["waktuCheckOut"] == null
                              ? Colors.green
                              : null
                          : null),
                  decoration: const InputDecoration(
                    hintText: "Ketikkan disini",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Hadir",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: isHadir
                      ? dataPresensi["waktuCheckIn"] != null
                          ? getTimeFullFromDatetime(
                              dataPresensi["waktuCheckIn"])
                          : "-"
                      : "-",
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: "Ketikkan disini",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Pulang",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: isHadir
                      ? dataPresensi["waktuCheckOut"] != null
                          ? getTimeFullFromDatetime(
                              dataPresensi["waktuCheckOut"])
                          : "-"
                      : "-",
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: "Ketikkan disini",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Izin",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: isHadir
                      ? "-"
                      : getTimeFullFromDatetime(dataPresensi?["tanggalAkhir"]),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: "Ketikkan disini",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5)),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
