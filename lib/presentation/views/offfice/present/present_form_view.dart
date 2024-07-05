import 'dart:async';

import 'package:app/components/component_constant.dart';
import 'package:app/components/dialog_permission.dart';
import 'package:app/data/models/absence.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/presentation/blocs/office/present/form/present_form_cubit.dart';
import 'package:app/presentation/widgets/appbar.dart';
import 'package:app/presentation/widgets/bottomsheet.dart';
import 'package:app/presentation/widgets/buttons.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
