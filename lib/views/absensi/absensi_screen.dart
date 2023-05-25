import 'package:app/global_resource.dart';
import 'components/layout_map.dart';

class AbsensiScreen extends StatelessWidget {
  const AbsensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AbsenController>(
      init: AbsenController(),
      dispose: (state) {
        state.controller!.cancelTimer();
      },
      builder: (s) => Scaffold(
        backgroundColor: const Color.fromRGBO(238, 240, 244, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ovalCardIcon(context, FeatherIcons.arrowLeft, onTaped: () {
                    Get.back();
                  }),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // ovalCardIcon(context, FeatherIcons.mapPin,
                        //     onTaped: () async {
                        //   s.lokasiDetect();
                        //   showDialog(
                        //     context: context,
                        //     builder: (ctx) => dialogGoogleMap(context,
                        //         latLng: s.currentLocation,
                        //         updateLocation: true),
                        //   );
                        // }),
                        // const SizedBox(width: 20),
                        // ovalCardIconAsset(
                        //     context, "assets/icons/ic_screen_shot.png",
                        //     onTaped: () async {
                        // final storagePermission = await [
                        //   Permission.storage,
                        //   Permission.manageExternalStorage
                        // ].request();
                        // Permission.manageExternalStorage.isGranted
                        //     .then((_) async {
                        //   await NativeScreenshot.takeScreenshot().then((value) {
                        //     if (value != null) {
                        //       showDialog(
                        //           context: context,
                        //           builder: (ctx) => customDialog(
                        //               context, "File save in $value", "OK",
                        //               onTap: () => AppRoute.pop()));
                        //     }
                        //   }).catchError((err) {
                        //     showDialog(
                        //         context: context,
                        //         builder: (ctx) => customDialog(
                        //             context, "msg ${err.toString()}", "OK",
                        //             onTap: () => AppRoute.pop()));
                        //   });
                        // });
                        // }),
                        // const SizedBox(width: 10),
                        // ovalCardIcon(
                        //   context,
                        //   FeatherIcons.mail,
                        //   onTaped: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (ctx) => customDialog(
                        //         context,
                        //         "Anda ingin izin hari ini?",
                        //         "Ok",
                        //         onTap: () {
                        //           Get.back();
                        //           Get.toNamed(RouteName.absenIzin);
                        //         },
                        //       ),
                        //     );
                        //   },
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              mapLayout(context, s),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Tekan tombol untuk masuk/pulang",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(51, 51, 51, 0.5)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 3, bottom: 20, left: 20, right: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            s.mulaiSelesaiAbsen(context, Get.arguments);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  // s.klikAbsen
                                  //     ? colorGrayPrimary
                                  //     : colorBluePrimary
                                  colorBlueOpacity2),
                              shape: const MaterialStatePropertyAll(
                                  (RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))))),
                          child: timerCount(context, s)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



// Widget btnTimer(
//     BuildContext context,
    // WidgetRef ref,
    // ValueNotifier<bool> currentDate,
    // ValueNotifier<bool> havePhoto,
    // ValueNotifier<bool> btnEnable,
    // ValueNotifier<String?> pathPhoto
    // s) {
  // var state = ref.read(buttonProvider);
  // ValueNotifier<int> _rangeDate = useState(0);

  // useEffect(() {
  // ref.read(prefProvider).getRangeDate().then((value) {
  //   _rangeDate.value = value;
  // });
  // return null;
  // }, [_rangeDate]);
  // return Container(
  //     child:
  // (state == ButtonState.initial && _rangeDate.value == 0)
  // ?
  // btnInitial(context, s)
  // : btnStarting(context, ref, currentDate.value, _rangeDate.value),
  // );
// }

// Widget btnInitial(BuildContext context, s) {
//   // WidgetRef ref,
//   // bool canClicked,
//   // ValueNotifier<bool> havePhoto,
//   // ValueNotifier<bool> btnEnable,
//   // ValueNotifier<String?> pathPhoto
//   return 
// }

// Widget btnStarting(BuildContext context, s) {
//   // bool canClicked, int rangeDate,
//   // ValueNotifier<int> isBefore = useState(rangeDate);
//   return ElevatedButton(
//       onPressed: () {
//         // if (canClicked) {
//         showDialog(
//             context: context,
//             builder: (ctx) => customDialog(context, "Pulang sekarang ?", "Ya",
//                 onTap: () => null)
//             //         AppRoute.pop(false))).then((value) {
//             //   if (value != null) {
//             //     ref.read(timerProvider.notifier).reset();
//             //     // AppRoute.pop();
//             //   }
//             // }
//             );
//         // } else {
//         //   showDialog(
//         //       context: context,
//         //       builder: (ctx) => customDialog(
//         //           context,
//         //           // isBefore.value < 0
//         //           // ? "Kehadiran tersimpan"
//         //           // :
//         //           "Tidak dapat mengisi kehadiran pada tanggal ini. Anda ingin izin ?",
//         //           "Ya",
//         //           onTap: () => null
//         //           //          AppRoute.pop(isBefore.value))).then((value) {
//         //           //   if (value > 0) {
//         //           //     // AppRoute.push(Routes.CREATE_LEAVE);
//         //           //   }
//         //           // }
//         //           ));
//         // }
//       },
//       style: const ButtonStyle(
//           backgroundColor: MaterialStatePropertyAll(colorGrayPrimary),
//           shape: MaterialStatePropertyAll((RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20)))))),
//       child: timerCount(context, s));
// }
