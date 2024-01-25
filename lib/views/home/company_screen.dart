import 'dart:async';

import 'package:app/components/component_constant.dart';
import 'package:app/components/component_custom.dart';
import 'package:app/components/component_modal.dart';
import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/controllers/home_controller.dart';
import 'package:app/helpers/base.dart';
import 'package:app/helpers/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'components/appbar.dart';

const CameraPosition _kDefaultCenter = CameraPosition(
  target: LatLng(3.5729021, 98.6292165),
  zoom: 17,
);

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completer = Completer<GoogleMapController>();
    final rxMarkers = ValueNotifier<List<Marker>>([]);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 64,
            leading: Container(
              margin: const EdgeInsets.only(left: 20),
              decoration: kCircleButtonDecoration,
              child: const HoraBackButton(),
            ),
            actions: [
              Container(
                decoration: kCircleButtonDecoration,
                child: IconButton(
                  onPressed: () => _handleShowDataManagement(context),
                  icon: const Icon(FeatherIcons.barChart2),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: kCircleButtonDecoration,
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  surfaceTintColor: Colors.white,
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        value: 'favorite',
                        child: BlocBuilder<AppCubit, AppState>(
                          buildWhen: (previous, current) =>
                              previous.currentUser != current.currentUser,
                          builder: (context, state) {
                            final profile = state.currentUser;
                            final liked = profile?.liked == 'yes';

                            return ListTile(
                              contentPadding: const EdgeInsets.only(left: 8),
                              leading: liked
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                              minLeadingWidth: 0,
                              title: liked
                                  ? const Text('Hapus Favorit')
                                  : const Text('Favoritkan'),
                            );
                          },
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'stop-working',
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 8),
                          leading: Icon(FeatherIcons.userX),
                          minLeadingWidth: 0,
                          title: Text('Berhenti'),
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 'favorite') {
                      context.read<AppCubit>().toggleLikeUnlike();
                    } else if (value == 'stop-working') {
                      _handleStopWorking(context);
                    }
                  },
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: GetBuilder<HomeController>(
            builder: (HomeController controller) {
              final perusahaan = controller.perusahaan;
              final id = perusahaan.id;
              final logoPerusahaan = changeUrlImage(perusahaan.logo);
              final namaPerusahaan = perusahaan.name;
              final address = perusahaan.alamat;
              final latitude = double.tryParse(perusahaan.latitude);
              final longitude = double.tryParse(perusahaan.longitude);
              if (latitude != null && longitude != null) {
                final position = LatLng(latitude, longitude);
                rxMarkers.value = [
                  Marker(markerId: MarkerId(id), position: position),
                ];
                completer.future.then((c) {
                  c.animateCamera(CameraUpdate.newLatLng(position));
                });
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () => Get.toNamed(RouteName.companyFullScreen),
                      child: Image.network(
                        logoPerusahaan,
                        fit: BoxFit.cover,
                        height: constraints.maxHeight / 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Text(
                        namaPerusahaan,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: colorBlackPrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: BlocBuilder<AppCubit, AppState>(
                        buildWhen: (previous, current) =>
                            previous.company != current.company ||
                            previous.currentUser != current.currentUser,
                        builder: (context, state) {
                          final profile = state.currentUser;
                          final liked = profile?.liked == 'yes';
                          final like = state.company.like;

                          return Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  child: liked
                                      ? const Icon(Icons.favorite, size: 20)
                                      : const Icon(
                                          Icons.favorite_border,
                                          size: 20,
                                        ),
                                ),
                                TextSpan(text: ' $like orang'),
                              ],
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: colorBlackPrimary,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      color: colorDivider,
                      height: 3,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Text(
                        'Lokasi Kantor',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: colorBlackPrimary,
                        ),
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight / 4,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: AnimatedBuilder(
                          animation: rxMarkers,
                          builder: (context, child) {
                            return GoogleMap(
                              onMapCreated: (GoogleMapController controller) {
                                if (!completer.isCompleted) {
                                  completer.complete(controller);
                                }
                              },
                              mapType: MapType.normal,
                              initialCameraPosition: _kDefaultCenter,
                              zoomControlsEnabled: false,
                              markers: rxMarkers.value.toSet(),
                              onTap: (_) => openMap(
                                perusahaan.latitude,
                                perusahaan.longitude,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: colorBlackPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  _handleShowDataManagement(BuildContext context) {
    Get.toNamed(RouteName.management);
  }

  _handleStopWorking(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(5),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Berhenti',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Anda ingin berhenti bekerja?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: const Text(
                      'Tidak',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text(
                      'Ya',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              )
            ],
          ),
        );
      },
    ).then((confirmed) {
      if (confirmed == true) {
        context.read<AppCubit>().stopWorking(([String? error]) {
          if (error != null) {
            Get.offNamed(RouteName.stopWorking);
          } else {
            customSnackbar1(error);
          }
        });
      }
    });
  }
}
