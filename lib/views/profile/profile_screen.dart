import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/dialogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _pageViewController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (s) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Hai, ${s.user?['namaKaryawan']}",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(RouteName.profileForm),
              icon: const Icon(
                FeatherIcons.edit3,
                color: colorBluePrimary,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: buildImageProfilePage(
                  context,
                  HomeController().gambarSearch(s.user, 1),
                  HomeController().gambarSearch(s.user, 2),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Setelan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    menuProfile(
                      context,
                      "Deteksi Lokasi",
                      FeatherIcons.mapPin,
                      trailing: BlocBuilder<AppCubit, AppState>(
                        buildWhen: (previous, current) =>
                            previous.allowLocationAlwaysPermission !=
                            current.allowLocationAlwaysPermission,
                        builder: (context, state) {
                          final enabled = state.allowLocationAlwaysPermission;
                          return Switch.adaptive(
                            value: enabled,
                            activeColor: colorGreenPrimary,
                            onChanged: _requestLocationAlways,
                          );
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Tentang",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    menuProfile(
                      context,
                      "Kebijakan Hora",
                      FeatherIcons.book,
                      onTap: () {
                        Get.toNamed(
                          RouteName.webview,
                          arguments: "https://docs.horaapp.id/#kebijakan",
                        );
                      },
                    ),
                    menuProfile(
                      context,
                      "Privasi Pengguna",
                      FeatherIcons.lock,
                      onTap: () {
                        Get.toNamed(
                          RouteName.webview,
                          arguments: "https://docs.horaapp.id/#privasi",
                        );
                      },
                    ),
                    menuProfile(
                      context,
                      "Kisah Hora",
                      FeatherIcons.command,
                      onTap: () {
                        Get.toNamed(
                          RouteName.webview,
                          arguments: "https://docs.horaapp.id/#kisah",
                        );
                      },
                    ),
                    menuProfile(
                      context,
                      "Perangkat lunak",
                      FeatherIcons.terminal,
                      onTap: () {
                        Get.toNamed(
                          RouteName.webview,
                          arguments: "https://docs.horaapp.id/#perangkatlunak",
                        );
                      },
                    ),
                    menuProfile(
                      context,
                      "Tanya jawab",
                      FeatherIcons.helpCircle,
                      onTap: () {
                        Get.toNamed(
                          RouteName.webview,
                          arguments: "https://docs.horaapp.id/#faq",
                        );
                      },
                    ),
                    menuProfile(
                      context,
                      "v1.9.1 (Agus)",
                      FeatherIcons.info,
                      onTap: () {
                        Get.toNamed(
                          RouteName.webview,
                          arguments: "https://horaapp.id/#contact",
                        );
                      },
                    ),
                    menuProfile(
                      context,
                      "Keluar",
                      FeatherIcons.logOut,
                      onTap: () async {
                        final homeCtrl = Get.put(HomeController());

                        if (homeCtrl.timer != null &&
                            homeCtrl.timer?.isActive) {
                          var tanggal =
                              homeCtrl.currentDate.toString().split(" ")[0];
                          var findData = await AbsensiServices()
                              .findIndiv(s.user?["idkaryawan"], tanggal);

                          if (context.mounted) {
                            showConfirmationDialog(
                              context,
                              'Presensi',
                              'Anda ingin pulang?',
                            ).then((confirmed) {
                              if (confirmed == true) {
                                Get.toNamed(RouteName.absen, arguments: {
                                  "dataAbsen": findData.data?[0],
                                  "pulang": 1
                                });
                              }
                            });
                          }
                        } else {
                          showConfirmationDialog(
                            context,
                            'Akun',
                            'Anda ingin keluar?',
                          ).then((confirmed) {
                            if (confirmed == true) {
                              s.keluar();
                              context.read<AppCubit>().clearToken();
                            }
                          });
                        }
                      },
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _requestLocationAlways(bool value) {
    if (value) {
      showConfirmationDialog(
        context,
        'Deteksi Lokasi',
        'Anda mengizinkan Hora untuk selalu mendeteksi lokasi?',
      ).then((confirmed) {
        if (confirmed == true) {
          Permission.locationWhenInUse.request().then((status) {
            final granted = status == PermissionStatus.granted;
            if (granted) {
              Permission.locationAlways.request().then((status) {
                if (status == PermissionStatus.permanentlyDenied) {
                  if (Platform.isAndroid) {
                    showConfirmationDialog(
                      context,
                      'Ijin Belum Diberikan',
                      'Buka setelah aplikasi dan izinkan Hora untuk selalu mendeteksi lokasi?',
                    ).then((confirmed) {
                      if (confirmed == true) {
                        openAppSettings();
                        context
                            .read<AppCubit>()
                            .setAllowLocationAlwaysPermission(value);
                      }
                    });
                  }
                } else if (status == PermissionStatus.granted) {
                  customSnackbar1('Deteksi akan dilakukan secara real time');
                  context.read<AppCubit>()
                    ..setAllowLocationAlwaysPermission(value)
                    ..runRealtimeServices();
                }
              });
            }
          });
        }
      });
    } else {
      customSnackbar1('Deteksi secara real time telah dinonaktifkan');
      context.read<AppCubit>().setAllowLocationAlwaysPermission(value);
    }
  }
}
