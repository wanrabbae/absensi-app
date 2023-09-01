import 'package:app/controllers/izin_controller.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    Permission.location.serviceStatus.isEnabled.then((value) {
      print("LOCATION: " + value.toString());
      if (!value) {
        Permission.location.request();
      }
    });
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      dispose: (state) {
        state.controller!.onInit();
      },
      builder: (s) => Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          // bottomNavigationBar: customNavbar(0),
          extendBodyBehindAppBar: false,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 50, left: 20, right: 20),
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
                                      fontWeight: FontWeight.w700,
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
                              fontWeight: FontWeight.w700,
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
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      curentDate,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
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
              Expanded(
                  child: s.absen!.length == 0 && hadirHighlight
                      ? Container(
                          padding: EdgeInsets.only(bottom: 70),
                          child: Center(
                              child: Image.asset(
                            'assets/icons/absen-ilus.png',
                            width: 321,
                            height: 321,
                          )),
                        )
                      : s.izin!.length == 0 && izinHighlight
                          ? Container(
                              padding: EdgeInsets.only(bottom: 70),
                              child: Center(
                                  child: Image.asset(
                                'assets/icons/aizin-ilus.png',
                                width: 321,
                                height: 321,
                              )),
                            )
                          : dataHome(context, s, hadirHighlight)),
            ],
          ),
          floatingActionButton: hadirHighlight
              ? Container(
                  // padding: EdgeInsets.only(bottom: 20),
                  child: FloatingActionButton.extended(
                    heroTag: "btn1",
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () async {
                      if (s.isPresentHadir!) {
                        print("test");
                        // customSnackbar1("Kehadiran hari ini telah terisi.");
                      } else {
                        s.absensi(context);
                      }
                    },
                    label: timerCount(context, s),
                    backgroundColor: s.isPresentHadir!
                        ? Colors.grey.shade400
                        : colorBluePrimary2,
                  ),
                )
              : Container(
                  // padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: FittedBox(
                          child: FloatingActionButton(
                            heroTag: "btn2",
                            // shape: const RoundedRectangleBorder(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(20))),
                            backgroundColor: s.isPresentIzin!
                                ? Colors.grey.shade400
                                : colorBlueOpacity2,
                            child: Icon(
                              FeatherIcons.paperclip,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () {
                              if (s.isPresentIzin!) {
                                print("test");
                                // customSnackbar1("Izin hari ini telah terisi.");
                              } else {
                                Get.toNamed(RouteName.absenIzin);
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton(
                        heroTag: "btn3",
                        backgroundColor: s.isPresentIzin!
                            ? Colors.grey.shade400
                            : colorBlueOpacity2,
                        child: Icon(
                          FeatherIcons.camera,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          if (s.isPresentIzin!) {
                            print("test");
                            // customSnackbar1("Izin hari ini telah terisi.");
                          } else {
                            ImagePicker()
                                .pickImage(
                                    source: ImageSource.camera,
                                    preferredCameraDevice: CameraDevice.front,
                                    imageQuality: 50)
                                .then((value) {
                              if (value != null) {
                                final izinCtrl = Get.put(IzinController());
                                izinCtrl.updateFileFromFoto(PlatformFile(
                                  name: value.name,
                                  path: value.path,
                                  size: 0,
                                ));
                              } else {
                                customSnackbar1(
                                    "Tidak bisa melanjutkan tanpa foto");
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
