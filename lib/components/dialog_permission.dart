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
                        child: ovalCardIcon(
                          context,
                          FeatherIcons.x,
                          onTaped: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    tr('dialog_permission_title'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/ic_settings.png",
                    width: 55,
                    height: 55,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  tr('dialog_permission_message'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(FeatherIcons.camera, size: 17),
                    const SizedBox(width: 10),
                    Text(
                      tr('camera'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(FeatherIcons.mapPin, size: 17),
                    const SizedBox(width: 10),
                    Text(
                      tr('location'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(FeatherIcons.folder, size: 17),
                    const SizedBox(width: 10),
                    Text(
                      tr('storage'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      onPressed: _handlePermission,
                      child: Text(
                        tr('next'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _handlePermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
    ].request();

    if (statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.location] == PermissionStatus.granted) {
      Get.back();
      Get.toNamed(RouteName.absen);
      return;
    }

    if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied &&
        statuses[Permission.location] == PermissionStatus.permanentlyDenied) {
      Get.back();
      if (Platform.isIOS) {
        Get.toNamed(RouteName.absen);
      }
      return;
    }

    if (Platform.isIOS) {
      Get.back();
      Get.toNamed(RouteName.absen);
    }
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
