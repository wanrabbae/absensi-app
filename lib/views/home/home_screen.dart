import 'package:app/global_resource.dart';
import 'package:flutter/cupertino.dart';
import 'components/card_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String curentDate = DateTime.now().day.toString().padLeft(2, '0') +
      "/" +
      DateTime.now().month.toString().padLeft(2, '0') +
      "/" +
      DateTime.now().year.toString();

  var hadirHighlight = true;
  var izinHighlight = false;

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      dispose: (state) {
        state.controller!.cancelTimer();
      },
      builder: (s) => Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: customNavbar(0),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin:
                      EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteName.homeSearch);
                            s.dataSearch();
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: 200,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(238, 240, 244, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: colorBlueOpacity2),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 25,
                                  color: colorBlueOpacity3,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Pencarian",
                                  style: TextStyle(
                                      fontSize: 16, color: colorBlueOpacity3),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            Get.toNamed(RouteName.homeUndangan);
                          },
                          icon: Icon(
                            CupertinoIcons.plus,
                            size: 30,
                            color: colorBluePrimary,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              )),
                              builder: (ctx) => modalSelectCompany(context, s));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, top: 10, bottom: 10),
                          child: buildImageSizeIcon(
                              context,
                              changeUrlImage(s.perusahaan?['logoPerusahaan'] ??
                                  'wwwroot/Images/CompanyLogo/logo_hora.png')),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                hadirHighlight
                                    ? colorBlueOpacity
                                    : Colors.white),
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(5))),
                        onPressed: () {
                          setState(() {
                            hadirHighlight = true;
                            izinHighlight = false;
                          });
                        },
                        child: Text(
                          "Hadir",
                          style: TextStyle(
                            color: colorBluePrimary,
                          ),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                izinHighlight
                                    ? colorBlueOpacity
                                    : Colors.white),
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(5))),
                        onPressed: () {
                          setState(() {
                            izinHighlight = true;
                            hadirHighlight = false;
                          });
                        },
                        child: Text(
                          "Izin",
                          style: TextStyle(
                            color: colorBluePrimary,
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      curentDate,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 11),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () async {
                          await showDatePicker(
                                  locale: const Locale("id", "ID"),
                                  context: context,
                                  initialDate: DateFormat("yyyy-MM-dd hh:mm:ss")
                                      .parse(s.currentDate!),
                                  firstDate: DateTime(DateTime.now().year - 10,
                                      DateTime.now().month, DateTime.now().day),
                                  lastDate: DateTime(DateTime.now().year + 10,
                                      DateTime.now().month, DateTime.now().day),
                                  currentDate: DateTime.now(),
                                  initialDatePickerMode: DatePickerMode.day)
                              .then((value) {
                            setState(() {
                              curentDate = DateTime.parse(value.toString())
                                      .day
                                      .toString()
                                      .padLeft(2, "0") +
                                  "/" +
                                  DateTime.parse(value.toString())
                                      .month
                                      .toString()
                                      .padLeft(2, "0") +
                                  "/" +
                                  DateTime.parse(value.toString())
                                      .year
                                      .toString();
                            });
                            s.gantiTanggal(value);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              FeatherIcons.calendar,
                              color: colorBluePrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(child: dataHome(context, s, hadirHighlight))
            ],
          ),
          floatingActionButton: hadirHighlight
              ? FloatingActionButton.extended(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  onPressed: () => s.absensi(context),
                  label: timerCount(context, s),
                  backgroundColor: colorBlueOpacity,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.attachment,
                        color: colorBluePrimary,
                      ),
                      onPressed: () {
                        if (izinAbs()) {
                          SplashController().showOkDialog(
                              'Anda sudah izin hari ini',
                              "tidak bisa melakukan absen lagi hari ini");
                        } else {
                          Get.toNamed(RouteName.absenIzin);
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton(
                      backgroundColor: colorBluePrimary,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (izinAbs()) {
                          SplashController().showOkDialog(
                              'Anda sudah izin hari ini',
                              "tidak bisa melakukan absen lagi hari ini");
                        } else {
                          Get.toNamed(RouteName.absenIzin);
                        }
                      },
                    )
                  ],
                )),
    );
  }
}

// FloatingActionButton fabStar(BuildContext context, s) {
//   return ;
// }

// FloatingActionButton fabReset(BuildContext context, s) {
//   return FloatingActionButton.extended(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//       onPressed: () async {
//         // if (canClicked) {
//         //   showDialog(
//         //       context: context,
//         //       builder: (ctx) => customDialog(
//         //           context,
//         //           "Kehadiran hari ini telah diisi. Apakah anda ingin pulang ?",
//         //           "Ok",
//         //           onTap: () => Get.back())).then((value) {
//         //     if (value) {
//         //       // ref.read(timerProvider.notifier).reset();
//         //       Get.toNamed(RouteName.absen);
//         //     }
//         //   });
//         // } else {
//         // if (await Permission.camera.isGranted &&
//         //     await Permission.location.isGranted) {
//         //   Get.toNamed(RouteName.absen);
//         // } else {
//         // showModalBottomSheet(
//         //     shape: const RoundedRectangleBorder(
//         //         borderRadius: BorderRadius.only(
//         //             topLeft: Radius.circular(20),
//         //             topRight: Radius.circular(20))),
//         //     context: context,
//         //     builder: (ctx) => const DialogPermission()).then((value) {
//         //   if (value != null) {
//         //     Get.toNamed(RouteName.absen);
//         //   }
//         // });
//         // }
//         // }
//       },
//       label: timerCount(context, s),
//       backgroundColor: colorGrayPrimary);
// }
// }
