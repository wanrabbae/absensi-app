import 'dart:async';

import 'package:app/components/component_constant.dart';
import 'package:app/components/dialog_permission.dart';
import 'package:app/presentation/blocs/app/app_cubit.dart';
import 'package:app/core/enums.dart';
import 'package:app/data/models/absence.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:app/presentation/blocs/office/present/form/present_form_cubit.dart';
import 'package:app/presentation/views/_shared/take_camera_picture_view.dart';
import 'package:app/presentation/views/offfice/present/present_form_fab.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class PresentFormView extends StatefulWidget {
  const PresentFormView({super.key});

  static Future<dynamic> show(BuildContext context, Absence? current) async {
    final route = MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => PresentFormCubit(
            api: context.read(),
            currentAttendance: current,
            user: context.read<AppCubit>().state.currentUser!,
          ),
          child: const PresentFormView(),
        );
      },
    );

    if (await Permission.camera.isGranted &&
        await Permission.location.isGranted &&
        context.mounted) {
      return Navigator.push(context, route);
    }

    if (context.mounted) {
      return showHoraCustomBottomSheet(
        context,
        title: tr('dialog_permission_title'),
        content: Column(children: dialogPermissionChildren()),
        button: HoraButton(
          onPressed: () => handlePermission(context),
          child: Text(tr('next')),
        ),
      ).then((granted) {
        if (granted == true && context.mounted) {
          return Navigator.push(context, route);
        }
      });
    }

    return null;
  }

  @override
  State<PresentFormView> createState() => _PresentFormViewState();
}

class _PresentFormViewState extends State<PresentFormView> {
  final rxMarkers = ValueNotifier(<Marker>[]);
  final rxPosition = ValueNotifier(kDefaultCenter.target);
  final rxPositionUpdate = ValueNotifier<DateTime?>(null);
  final completer = Completer<GoogleMapController>();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueAzure,
  );

  bool _showLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setMarker();

      _showLoading = true;
      final cubit = context.read<PresentFormCubit>();
      showHoraLoadingBottomSheet(
        context,
        onCancel: () {
          Navigator.pop(context);
        },
        builder: (context, loading) {
          return FutureBuilder(
            future: cubit.getCurrentLocation(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Image.asset(
                    'images/map-pin-gif.gif',
                    width: 96,
                    height: 96,
                  );
                case ConnectionState.done:
                  return Image.asset(
                    'images/check-gif.gif',
                    width: 96,
                    height: 96,
                  );
              }
            },
          );
        },
      ).then((_) {
        _showLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HoraAppBar(
        context,
        leadingCircleButton: true,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          Container(
            width: 40,
            margin: const EdgeInsets.only(right: 16),
            decoration: kCircleButtonDecoration,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: rxMarkers,
        builder: (context, markers, child) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: kDefaultCenter,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            markers: markers.toSet(),
            onMapCreated: (controller) {
              if (!completer.isCompleted) {
                completer.complete(controller);
              }
            },
          );
        },
      ),
      floatingActionButton: const PresentFormFAB(),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<PresentFormCubit, PresentFormState>(
          listenWhen: (previous, current) =>
              previous.currentLocation != current.currentLocation,
          listener: (context, state) {
            if (rxPosition.value != state.currentLocation) {
              if (_showLoading == true) {
                Future.delayed(const Duration(seconds: 2), () async {
                  if (context.mounted) {
                    Navigator.pop(context);

                    final cubit = context.read<PresentFormCubit>();
                    final attendance = state.currentAttendance;

                    final image = await TakeCameraPictureView.show(context);
                    if (image is! XFile) return;

                    if (attendance == null) {
                      cubit.checkIn(CancelToken(), image);
                    } else {
                      cubit.checkOut(CancelToken(), image);
                    }
                  }
                });
              }

              rxPosition.value = state.currentLocation;
              _setMarker();
            }
          },
        ),
        BlocListener<PresentFormCubit, PresentFormState>(
          listenWhen: (previous, current) =>
              previous.submitAttendanceStatus !=
                  current.submitAttendanceStatus ||
              previous.isCheckingIn != current.isCheckingIn,
          listener: (BuildContext context, PresentFormState state) {
            final cubit = context.read<PresentFormCubit>();
            switch (state.submitAttendanceStatus) {
              case PageStatus.idle:
                break;
              case PageStatus.busy:
                _showLoading = true;
                showHoraLoadingBottomSheet(
                  context,
                  onCancel: () => cubit.cancelRequest(),
                ).then((value) {
                  _showLoading = false;
                });
                break;
              case PageStatus.canceled:
              case PageStatus.succeed:
              case PageStatus.failed:
                if (_showLoading == true && context.mounted) {
                  Navigator.pop(context);
                }
                break;
            }

            if (state.submitAttendanceStatus == PageStatus.succeed) {
              if (state.isCheckingIn) {
                final now = DateTime.now();
                AwesomeNotificationService()
                  ..showNotificationAbsen(now)
                  ..showNotificationAfter12Hours(now);
              } else {
                AwesomeNotificationService().showNotificationAbsenDone();
              }
              Navigator.pop(context, true);
            } else if (state.submitAttendanceStatus == PageStatus.failed) {
              showHoraInfoBottomSheet(
                context,
                title: tr('present'),
                message: tr('snackbar_error_system'),
              );
            }
          },
        ),
      ],
      child: scaffold,
    );
  }

  _setMarker() {
    rxMarkers.value = [
      Marker(
        markerId: const MarkerId('marker-attendance-id'),
        icon: markerIcon,
        position: rxPosition.value,
      ),
    ];
    completer.future.then((controller) {
      controller.animateCamera(CameraUpdate.newLatLng(rxPosition.value));
    });
  }
}
