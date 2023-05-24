import 'package:app/global_resource.dart';
import 'package:permission_handler/permission_handler.dart';

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
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Perizinan perangkat :",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromRGBO(51, 51, 51, 1)),
                  ),
                ),
                const Text("  \u2022   Kamera",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(24, 102, 225, 1))),
                const Text("  \u2022   Lokasi",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(24, 102, 225, 1))),
                const Text("  \u2022   Bluetooth",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(24, 102, 225, 1))),
                const Text("  \u2022   Penyimpanan",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(24, 102, 225, 1))),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("dibutuhkan untuk mengisi profil.",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromRGBO(51, 51, 51, 1))),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Tekan tombol untuk menyimpan",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(51, 51, 51, 0.5)),
                  ),
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
                                        Radius.circular(16))))),
                        onPressed: () async {
                          Get.back();
                          Get.toNamed(RouteName.absen);
                          Map<Permission, PermissionStatus> statuses = await [
                            Permission.camera,
                            Permission.location,
                            Permission.bluetooth,
                            Permission.storage,
                            Permission.bluetoothScan,
                            Permission.bluetoothAdvertise,
                            Permission.bluetoothConnect,
                          ].request();

                          if (statuses[Permission.camera] ==
                              PermissionStatus.granted) {
                            Get.back();
                            Get.toNamed(RouteName.absen);
                          }
                        },
                        child: const Text(
                          "Izinkan",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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
