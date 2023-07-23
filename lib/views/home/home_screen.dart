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

  File? formFotoIzin;

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
                  margin: EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteName.homeSearch);
                            s.dataSearch();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
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
                                  FeatherIcons.search,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Pencarian",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Rubik'),
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
                            FeatherIcons.userPlus,
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
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                              builder: (ctx) => modalSelectCompany(context, s));
                        },
                        child: buildImageSizeIcon(
                            context,
                            changeUrlImage(s.perusahaan?['logoPerusahaan'] ??
                                'wwwroot/Images/CompanyLogo/logo_hora.png')),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
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
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Rubik'),
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
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    Container(
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
              dataHome(context, s, hadirHighlight)
            ],
          ),
          floatingActionButton: hadirHighlight
              ? Container(
                  // padding: EdgeInsets.only(bottom: 20),
                  child: FloatingActionButton.extended(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () => s.absensi(context),
                    label: timerCount(context, s),
                    backgroundColor: colorBluePrimary2,
                  ),
                )
              : Container(
                  // padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        backgroundColor: Colors.white,
                        child: Icon(
                          FeatherIcons.paperclip,
                          color: colorBluePrimary,
                        ),
                        onPressed: () {
                          if (izinAbs()) {
                            customSnackbar1("Izin hari ini telah terisi");
                          } else {
                            Get.toNamed(RouteName.absenIzin);
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton(
                        backgroundColor: colorBlueOpacity2,
                        child: Icon(
                          FeatherIcons.camera,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          if (izinAbs()) {
                            customSnackbar1("Izin hari ini telah terisi");
                          } else {
                            ImagePicker()
                                .pickImage(
                                    source: ImageSource.camera,
                                    preferredCameraDevice: CameraDevice.front)
                                .then((value) {
                              if (value != null) {
                                formFotoIzin = File(value.path);
                              } else {
                                customSnackbar1(
                                    "Silahkan tangkap foto terlebih dahulu");
                              }
                            });
                            Get.toNamed(RouteName.absenIzin);
                          }
                        },
                      ),
                    ],
                  ),
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
