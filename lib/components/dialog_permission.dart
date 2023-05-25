import 'package:app/global_resource.dart';
import 'package:flutter/cupertino.dart';
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
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Perizinan perangkat",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
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
                  height: 40,
                ),
                Text(
                  "Anda diperlukan untuk memberikan izin: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(51, 51, 51, 1)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.camera,
                      size: 16,
                    ),
                    const Text(" Kamera",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.map_pin_ellipse,
                      size: 16,
                    ),
                    const Text(" Lokasi",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.folder,
                      size: 16,
                    ),
                    const Text(" Penyimpanan",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
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
