import 'package:after_layout/after_layout.dart';
import 'package:app/cubits/live_location_cubit/live_location_cubit.dart';
import 'package:app/firebase_models/user_fm.dart';
import 'package:app/global_resource.dart';
import 'package:app/models/user_model/user_model.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:supercharged/supercharged.dart';
import 'package:velocity_x/velocity_x.dart';

class LiveLocationPage extends StatefulWidget {
  final UserModel? userModel;
  final UserFm? userFm;

  const LiveLocationPage({
    super.key,
    this.userModel,
    this.userFm,
  });

  @override
  State<LiveLocationPage> createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> with AfterLayoutMixin<LiveLocationPage> {
  GoogleMapController? controller;
  final userFm = Rxn<UserFm>();
  final userModel = Rxn<UserModel>();
  final markers = RxSet<Marker>();
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? subscription;
  StreamSubscription<UserFm?>? userFmSubs;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    userModel.value = widget.userModel;
    userFm.value = widget.userFm;

    context.read<LiveLocationCubit>().fetch(
          userModel: widget.userModel,
        );

    userFmSubs ??= userFm.stream.listen((e) {
      if (e != null) {
        subscription ??= e.reference.snapshots().listen((event) {
          userFm.value = UserFm(snapshot: event);

          final index = markers.toList().indexWhere((element) => element.markerId.value == event.data()?['idkaryawan']);
          if (markers.toList().isNotEmpty) {
            markers.remove(markers.toList()[index]);
          }
          final geoPoint = event.data()?['location'] as GeoPoint?;
          markers.add(Marker(
            markerId: MarkerId(event.data()?['idkaryawan']),
            position: LatLng(geoPoint?.latitude ?? 0, geoPoint?.longitude ?? 0),
            icon: userModel.value?.customMarker ?? BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: userModel.value?.namaKaryawan ?? '-',
              snippet: userModel.value?.namaPerusahaan ?? '-',
            ),
          ));
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    userFmSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<LiveLocationCubit, LiveLocationState>(
          listener: (context, state) {
            if (state is LiveLocationOk && state.feature == 'fetch') {
              userFm.value = state.data;
              userModel.value = state.extra?['userModel'] ?? userModel.value;
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(userModel.value?.namaKaryawan ?? '-', style: GoogleFonts.rubik(fontWeight: FontWeight.w700)),
              5.widthBox,
              Obx(() {
                return Icon(Icons.circle, color: (userFm.value?.isLive ?? true) ? colorGreenPrimary2 : Vx.red500, size: 15);
              }),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.snackbar('MAINTENANCE', 'Fitur ini sedang dalam pengembangan');
                },
                icon: Icon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: '#1865E2'.toColor(),
                )),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: size.height * 0.8,
                  child: Obx(() {
                    if (userFm.value == null) {
                      return GFShimmer(
                          child: SizedBox(
                        height: size.height * 0.8,
                        width: size.width,
                      ));
                    }

                    return GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(userFm.value?.location?.latitude ?? 0, userFm.value?.location?.longitude ?? 0),
                        zoom: 14.4746,
                      ),
                      onMapCreated: (GoogleMapController c) {
                        controller = c;
                      },
                      markers: markers.value,
                    );
                  }),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: size.height * 0.07,
                  child: GestureDetector(
                    onTap: () {
                      Get.snackbar('MAINTENANCE', 'Fitur ini sedang dalam pengembangan');
                    },
                    child: Obx(() {
                      return Text(
                        'Diperbarui ${userFm.value?.getFormattedDate ?? '-'}',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
