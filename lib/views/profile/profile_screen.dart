import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/dialogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'components/menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  final _pageViewController = PageController();

  @override
  void initState() {
    Get.put(ProfileController());
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (s) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            tr('profile_hi', args: [s.user?['namaKaryawan']]),
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
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 20, right: 20),
                    //   child: Text(
                    //     "Setelan",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // menuProfile(
                    //   context,
                    //   "Deteksi Lokasi",
                    //   FeatherIcons.mapPin,
                    //   onTap: () => _requestLocationAlways(
                    //     !context
                    //         .read<AppCubit>()
                    //         .state
                    //         .allowLocationAlwaysPermission,
                    //   ),
                    //   trailing: BlocBuilder<AppCubit, AppState>(
                    //     buildWhen: (previous, current) =>
                    //         previous.allowLocationAlwaysPermission !=
                    //         current.allowLocationAlwaysPermission,
                    //     builder: (context, state) {
                    //       final enabled = state.allowLocationAlwaysPermission;
                    //       final child = Switch(
                    //         value: enabled,
                    //         activeTrackColor: colorGreenPrimary,
                    //         activeColor: Colors.white,
                    //         inactiveThumbColor: colorGreenPrimary,
                    //         inactiveTrackColor: Colors.white,
                    //         trackOutlineColor: const MaterialStatePropertyAll(colorGreenPrimary),
                    //         onChanged: _requestLocationAlways,
                    //       );
                    //
                    //       return SizedBox(
                    //         height: 24,
                    //         child: FittedBox(child: child),
                    //       );
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        tr('profile_about'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    menuProfile(
                      context,
                      tr('profile_change_language'),
                      FeatherIcons.airplay,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              children: [
                                SimpleDialogOption(
                                  child: Text(
                                    'Indonesia',
                                    style: context.locale == kLocaleID
                                        ? const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )
                                        : const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, kLocaleID);
                                  },
                                ),
                                SimpleDialogOption(
                                  child: Text('English',
                                      style: context.locale == kLocaleEN
                                          ? const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )
                                          : null),
                                  onPressed: () {
                                    Navigator.pop(context, kLocaleEN);
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((value) {
                          if (value is Locale) {
                            context.setLocale(value);
                            Get.updateLocale(value);
                          }
                        });
                      },
                    ),
                    menuProfile(
                      context,
                      tr('profile_terms'),
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
                      tr('profile_privacy'),
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
                      tr('profile_story'),
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
                      tr('profile_software'),
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
                      tr('profile_faq'),
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
                      'v${$it<PackageInfo>().version}',
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
                      tr('profile_logout'),
                      FeatherIcons.logOut,
                      onTap: () async {
                        final homeCtrl = Get.put(HomeController());

                        if (homeCtrl.timer != null &&
                            homeCtrl.timer?.isActive) {
                          final tanggal = homeCtrl.currentDate;
                          final tglstart =
                              DateTime(tanggal.year, tanggal.month, tanggal.day)
                                  .toUtc();
                          final tglend = DateTime(tanggal.year, tanggal.month,
                                  tanggal.day, 23, 59, 59)
                              .toUtc();
                          final request = {
                            "idkaryawan": homeCtrl.userProfile!.idkaryawan!,
                            "tglstart": kQueryRangeDateFormat.format(tglstart),
                            "tglend": kQueryRangeDateFormat.format(tglend),
                          };
                          var findData =
                              await AbsensiServices().findIndiv(request);

                          if (context.mounted) {
                            showConfirmationDialog(
                              context,
                              tr('dialog_presence_title'),
                              tr('dialog_presence_message'),
                              buttonOk: tr('dialog_button_yes'),
                              buttonCancel: tr('dialog_button_no'),
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
                            tr('dialog_logout_title'),
                            tr('dialog_logout_message'),
                            buttonOk: tr('dialog_button_yes'),
                            buttonCancel: tr('dialog_button_no'),
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

  // _requestLocationAlways(bool value) {
  //   if (value) {
  //     showConfirmationDialog(
  //       context,
  //       'Deteksi Lokasi',
  //       'Anda mengizinkan Hora untuk selalu mendeteksi lokasi?',
  //     ).then((confirmed) {
  //       if (confirmed == true) {
  //         Permission.locationWhenInUse.request().then((status) {
  //           final granted = status == PermissionStatus.granted;
  //           if (granted) {
  //             Permission.locationAlways.request().then((status) {
  //               if (status == PermissionStatus.permanentlyDenied) {
  //                 if (Platform.isAndroid) {
  //                   showConfirmationDialog(
  //                     context,
  //                     'Ijin Belum Diberikan',
  //                     'Buka setelah aplikasi dan izinkan Hora untuk selalu mendeteksi lokasi?',
  //                   ).then((confirmed) {
  //                     if (confirmed == true) {
  //                       openAppSettings();
  //                       context
  //                           .read<AppCubit>()
  //                           .setAllowLocationAlwaysPermission(value);
  //                     }
  //                   });
  //                 }
  //               } else if (status == PermissionStatus.granted) {
  //                 customSnackbar1('Deteksi akan dilakukan secara real time');
  //                 context.read<AppCubit>()
  //                   ..setAllowLocationAlwaysPermission(value)
  //                   ..runRealtimeServices();
  //               }
  //             });
  //           }
  //         });
  //       }
  //     });
  //   } else {
  //     customSnackbar1('Deteksi secara real time telah dinonaktifkan');
  //     context.read<AppCubit>().setAllowLocationAlwaysPermission(value);
  //   }
  // }

  @override
  bool get wantKeepAlive => true;
}
