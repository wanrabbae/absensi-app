import 'package:after_layout/after_layout.dart';
import 'package:app/cubits/live_location_cubit/live_location_cubit.dart';
import 'package:app/firebase_models/user_fm.dart';
import 'package:app/global_resource.dart';
import 'package:app/models/live_location_action_model/live_location_action_model.dart';
import 'package:app/models/user_model/user_model.dart';
import 'package:app/ui/widgets/custom_ellipsis_button.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class LiveLocationPage extends StatefulWidget {
  final UserModel? userModel;
  final UserFm? userFm;
  final Function()? onDetailPressed;

  const LiveLocationPage({
    super.key,
    this.userModel,
    this.userFm,
    this.onDetailPressed,
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
  final items = <LiveLocationActionModel>[].obs;
  final mapType = MapType.normal.obs;
  final trafficEnabled = false.obs;

  @override
  void initState() {
    super.initState();

    items.value = <LiveLocationActionModel>[
      LiveLocationActionModel(
        id: 1,
        title: 'Tampilan peta',
        isActive: true,
        onPressed: () {
          mapType.value = MapType.normal;
          items.value[0] = items.value[0].copyWith(isActive: true);
          items.value[1] = items.value[1].copyWith(isActive: false);

          // items[0] = items[0].copyWith(isActive: true);
          // items.where((element) => element.id != 1 && !element.isBreak).forEach((element) {
          //   items[items.indexOf(element)] = items[items.indexOf(element)].copyWith(isActive: false);
          // });
        },
      ),
      LiveLocationActionModel(
        id: 2,
        title: 'Tampilan satelit',
        onPressed: () {
          mapType.value = MapType.satellite;
          items.value[0] = items.value[0].copyWith(isActive: false);
          items.value[1] = items.value[1].copyWith(isActive: true);
          // items[1] = items[1].copyWith(isActive: true);
          // items.where((element) => element.id != 2 && !element.isBreak).forEach((element) {
          //   items[items.indexOf(element)] = items[items.indexOf(element)].copyWith(isActive: false);
          // });
        },
      ),
      LiveLocationActionModel(
          id: 3,
          title: 'Tampilan medan',
          isBreak: true,
          onPressed: () async {
            final lat = userFm.value?.location?.latitude;
            final lng = userFm.value?.location?.longitude;
            final url = 'http://maps.google.com/maps?q=&layer=c&cbll=$lat,$lng';
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            }
          }),
      LiveLocationActionModel(
          id: 4,
          title: 'Tampilan trafik',
          isActive: true,
          onPressed: () {
            trafficEnabled.value = trafficEnabled.value ? false : true;
            items.value[3] = items.value[3].copyWith(isActive: true);
          }),
    ].obs;
  }

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
        extendBody: true,
        appBar: AppBar(
          title: GestureDetector(
            onTap: widget.onDetailPressed ?? () {},
            child: Row(
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
          ),
          centerTitle: true,
          actions: [
            Obx(() {
              if (userFm.value == null) {
                return const SizedBox();
              }
              return EllipsisButton(
                items: items,
              );
            }),
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
                      trafficEnabled: trafficEnabled.value,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: mapType.value,
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
                    onTap: widget.onDetailPressed ??
                        () {
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
