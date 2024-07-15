import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/global_resource.dart';
import 'package:app/helpers/dialogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'menu.dart';
import 'profile_handlers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: BlocBuilder<AppCubit, AppState>(
                buildWhen: (previous, current) =>
                    previous.currentUser != current.currentUser,
                builder: (context, state) {
                  bool local = true;
                  String image = 'assets/icons/logo/hora.png';

                  final user = state.currentUser;
                  if (user != null && user.photo != null) {
                    image = changeUrlImage(user.photo!);
                    local = false;
                  }

                  return buildImageProfilePage(context, image, local);
                },
              ),
            ),
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
                style: const TextStyle(fontSize: 16),
              ),
            ),
            menuProfile(
              context,
              tr('profile_change_language'),
              Boxicons.bx_world,
              onTap: () => handleChangeLanguage(context),
            ),
            menuProfile(
              context,
              tr('profile_terms'),
              Boxicons.bx_book_alt,
              onTap: () => handleShowTerms(context),
            ),
            menuProfile(
              context,
              tr('profile_privacy'),
              Boxicons.bx_lock_alt,
              onTap: () => handleShowPrivacy(context),
            ),
            menuProfile(
              context,
              tr('profile_story'),
              Boxicons.bx_command,
              onTap: () => handleShowStory(context),
            ),
            menuProfile(
              context,
              tr('profile_software'),
              Boxicons.bx_terminal,
              onTap: () => handleShowSoftware(context),
            ),
            menuProfile(
              context,
              tr('profile_faq'),
              Boxicons.bx_question_mark,
              onTap: () => handleShowFaq(context),
            ),
            menuProfile(
              context,
              'v${context.read<PackageInfo>().version}',
              Boxicons.bx_info_circle,
              onTap: () => handleShowContact(context),
            ),
            menuProfile(
              context,
              tr('profile_logout'),
              Boxicons.bx_log_out_circle,
              onTap: () => handleLogOut(context),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) =>
            previous.currentUser != current.currentUser,
        builder: (context, state) {
          final user = state.currentUser;
          return Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${tr('profile_hi')}\n',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: user?.name ?? '-',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () => Get.toNamed(RouteName.profileForm),
          icon: const Icon(Boxicons.bxs_edit_alt),
        ),
        const SizedBox(width: 8),
      ],
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
