import 'package:app/components/empty_view.dart';
import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/controllers/home/home_cubit.dart';
import 'package:app/controllers/izin_controller.dart';
import 'package:app/core/enums.dart';
import 'package:app/global_resource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/card_home.dart';
import 'components/home_tab_view.dart';
import 'components/home_toolbar.dart';
import 'klaim/klaim_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.activeAttendanceDate});

  final String? activeAttendanceDate;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final _imagePicker = ImagePicker();
  String curentDate = () {
    final now = DateTime.now();
    final d = now.day.toString().padLeft(2, '0');
    final m = now.month.toString().padLeft(2, '0');
    final y = now.year;
    return "$d/$m/$y";
  }();

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
      final app = context.read<AppCubit>()
        ..getProfile()
        ..getCompany();

      final idPerusahaan = app.state.company.id;
      context.read<HomeCubit>().getDataKlaim(idPerusahaan);
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
            HomeToolbar(s),
            _buildTabBar(),
            _buildDateTile(context, s),
            Expanded(child: _buildContent(s, context)),
          ],
        ),
        floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => previous.tab != current.tab,
          builder: (context, state) {
            switch (state.tab) {
              case HomeTab.hadir:
                return _buildHadirFAB(s, context);
              case HomeTab.izin:
                return _buildIzinFAB(s);
              case HomeTab.klaim:
                return _buildKlaimFAB();
            }
          },
        ),
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
          customSnackbar1(tr('snackbar_already_permit'));
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
              customSnackbar1(tr('snackbar_photo_required'));
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
                customSnackbar1(tr('snackbar_already_present'));
              } else {
                s.absensi(context);
              }
            },
            backgroundColor:
                s.isPresentHadir ? colorDisabled : colorBluePrimary2,
            elevation: 0,
            isExtended: true,
            child: timerCount(context, s),
          ),
        ),
      ],
    );
  }

  Widget _buildKlaimFAB() {
    return FloatingActionButton(
      heroTag: "fab-klaim",
      backgroundColor: colorBlackPrimary,
      onPressed: _handleFabKlaim,
      child: const Icon(
        FeatherIcons.camera,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  _handleFabKlaim() async {
    final cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      Permission.camera.request();
      return;
    }

    if (cameraStatus.isGranted) {
      try {
        final photo = await _imagePicker.pickImage(
          source: kDebugMode && Platform.isIOS
              ? ImageSource.gallery
              : ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear,
          imageQuality: 60,
        );

        if (photo != null) {
          Get.toNamed(RouteName.klaimForm, arguments: photo)?.then((succeed) {
            if (succeed == true) {
              final cubit = context.read<HomeCubit>();
              final idPerusahaan = cubit.state.idPerusahaan!;
              cubit.getDataKlaim(idPerusahaan);
            }
          });
        } else {
          customSnackbar1(tr('snackbar_taking_photo_canceled'));
        }
      } catch (e) {
        customSnackbar1(tr('snackbar_taking_photo_failed'));
      }
      return;
    }

    customSnackbar1(tr('snackbar_photo_required'));
  }

  Widget _buildContent(HomeController s, BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.tab != current.tab,
      builder: (context, state) {
        switch (state.tab) {
          case HomeTab.hadir:
            if (s.absen!.isEmpty) {
              return Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
                child: EmptyView(
                  image: 'assets/icons/absen-ilus.webp',
                  title: tr('present'),
                  subtitle: tr('present_empty'),
                ),
              );
            }
            return dataHome(context, s, true);
          case HomeTab.izin:
            if (s.izin!.isEmpty) {
              return Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
                child: EmptyView(
                  image: 'assets/icons/aizin-ilus.webp',
                  title: tr('permit'),
                  subtitle: tr('permit_empty'),
                ),
              );
            }
            return dataHome(context, s, false);
          case HomeTab.klaim:
            return const KlaimView();
        }
      },
    );
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
              final home = context.read<HomeCubit>();
              final now = DateTime.now();
              showDatePicker(
                locale: context.locale,
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
                if (!home.isClosed) {
                  home.setDateTime(value);
                }
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
        left: 17,
        right: 20,
        top: 0,
        bottom: 8,
      ),
      child: Row(
        children: [
          for (int i = 0; i < HomeTab.values.length; i++) ...{
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => previous.tab != current.tab,
              builder: (context, state) {
                final tab = HomeTab.values[i];
                return HomeTabView(
                  tab: tr(tab.tab),
                  onChanged: (value) {
                    context.read<HomeCubit>().setHomeTab(value);
                  },
                  value: tab,
                  selected: state.tab == tab,
                );
              },
            ),
          },
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
