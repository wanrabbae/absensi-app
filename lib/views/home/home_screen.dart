import 'package:app/components/empty_view.dart';
import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/controllers/izin_controller.dart';
import 'package:app/global_resource.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/card_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.activeAttendanceDate});

  final String? activeAttendanceDate;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  String curentDate = () {
    final now = DateTime.now();
    final d = now.day.toString().padLeft(2, '0');
    final m = now.month.toString().padLeft(2, '0');
    final y = now.year;
    return "$d/$m/$y";
  }();

  var hadirHighlight = true;
  var izinHighlight = false;

  File? formFotoIzin;

  @override
  void initState() {
    FlutterAppBadger.updateBadgeCount(0);

    final activeAttendanceDate = widget.activeAttendanceDate;
    if (activeAttendanceDate != null) {
      final now = DateTime.tryParse(activeAttendanceDate);
      if (now != null) {
        final d = now.day.toString().padLeft(2, '0');
        final m = now.month.toString().padLeft(2, '0');
        final y = now.year;
        curentDate = "$d/$m/$y";
      }
    }

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AppCubit>()
        ..getProfile()
        ..getCompany();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      init: HomeController(),
      dispose: (state) {
        state.controller!.onInit();
        state.controller!.checkAnyAbsen();
      },
      builder: (HomeController s) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _Toolbar(s),
            _buildTabBar(),
            _buildDateTile(context, s),
            _buildContent(s, context),
          ],
        ),
        floatingActionButton:
            hadirHighlight ? _buildHadirFAB(s, context) : _buildIzinFAB(s),
      ),
    );
  }

  Widget _buildIzinFAB(HomeController s) {
    return FloatingActionButton(
      heroTag: "btn3",
      backgroundColor:
          s.isPresentIzin ? Colors.grey.shade400 : colorBlackPrimary,
      child: Icon(
        FeatherIcons.edit2,
        color: s.isPresentIzin ? Colors.black : Colors.white,
        size: 24,
      ),
      onPressed: () {
        if (s.isPresentIzin) {
          debugPrint("test");
          customSnackbar1("Kehadiran hari ini telah terisi.");
        } else {
          ImagePicker()
              .pickImage(
            source: ImageSource.camera,
            preferredCameraDevice: CameraDevice.front,
            imageQuality: 50,
          )
              .then((value) {
            if (value != null) {
              final izinCtrl = Get.put(IzinController());
              izinCtrl.updateFileFromFoto(PlatformFile(
                name: value.name,
                path: value.path,
                size: 0,
              ));
              Get.toNamed(RouteName.absenIzin, arguments: {
                "isFoto": true,
              });
            } else {
              customSnackbar1(
                "Tidak bisa melanjutkan tanpa foto",
              );
            }
          });
        }
      },
    );
  }

  Widget _buildHadirFAB(HomeController s, BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 32),
        Expanded(
          child: FloatingActionButton(
            heroTag: "btn1",
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            onPressed: () async {
              if (s.isPresentHadir) {
                debugPrint("test");
                customSnackbar1("Kehadiran hari ini telah terisi.");
              } else {
                s.absensi(context);
              }
            },
            backgroundColor: s.isPresentHadir
                ? colorDisabled
                : colorBluePrimary2,
            elevation: 0,
            isExtended: true,
            child: timerCount(context, s),
          ),
        ),
      ],
    );
  }

  Expanded _buildContent(HomeController s, BuildContext context) {
    return Expanded(
        child: s.absen!.isEmpty && hadirHighlight
            ? Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
                child: const EmptyView(
                  image: 'assets/icons/absen-ilus.png',
                  title: 'Hadir',
                  subtitle:
                      'Fitur ini akan mencatat, menyimpan dan menampilkan detail presensi anda secara berkala.',
                ),
              )
            : s.izin!.isEmpty && izinHighlight
                ? Container(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
                    child: const EmptyView(
                      image: 'assets/icons/aizin-ilus.png',
                      title: 'Izin',
                      subtitle:
                          'Fitur ini akan mencatat, menyimpan dan menampilkan detail izin anda secara berkala.',
                    ),
                  )
                : dataHome(context, s, hadirHighlight));
  }

  Padding _buildDateTile(BuildContext context, HomeController s) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            curentDate,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              final now = DateTime.now();
              showDatePicker(
                locale: const Locale("id", "ID"),
                context: context,
                initialDate: s.currentDate,
                firstDate: DateTime(now.year - 10, now.month, now.day),
                lastDate: DateTime(now.year + 10, now.month, now.day),
                currentDate: now,
                initialDatePickerMode: DatePickerMode.day,
              ).then((value) {
                if (value == null || !mounted) return;

                setState(() {
                  curentDate =
                      "${value.day.toString().padLeft(2, "0")}/${value.month.toString().padLeft(2, "0")}/${value.year}";
                });
                s.gantiTanggal(value);
              });
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage('assets/icons/calendar.webp'),
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 0,
        bottom: 8,
      ),
      child: Row(
        children: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                hadirHighlight ? colorBlueOpacity : Colors.white,
              ),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(5)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  side: hadirHighlight
                      ? BorderSide.none
                      : const BorderSide(
                          color: colorBlueOpacity,
                          width: 2,
                        ),
                ),
              ),
            ),
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
                fontWeight: hadirHighlight ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 5),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                izinHighlight ? colorBlueOpacity : Colors.white,
              ),
              padding: const MaterialStatePropertyAll(EdgeInsets.all(5)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  side: izinHighlight
                      ? BorderSide.none
                      : const BorderSide(
                          color: colorBlueOpacity,
                          width: 2,
                        ),
                ),
              ),
            ),
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
                fontWeight: izinHighlight ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Toolbar extends StatelessWidget {
  const _Toolbar(this.s);

  final HomeController s;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      margin: EdgeInsets.only(top: top, left: 20, right: 16),
      height: kToolbarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Image.asset('assets/icons/logo/hora.png', height: 24),
                const SizedBox(width: 5),
                const Text(
                  "HORA",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Get.toNamed(RouteName.homeSearch);
              s.dataSearch();
            },
            icon: const Icon(
              FeatherIcons.search,
              size: 24,
              color: colorBluePrimary,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(RouteName.homeUndangan);
            },
            icon: const Icon(
              FeatherIcons.userPlus,
              size: 24,
              color: colorBluePrimary,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteName.companyScreen);
            },
            child: buildImageSizeIcon(
              context,
              changeUrlImage(s.perusahaan.logo),
            ),
          ),
        ],
      ),
    );
  }
}
