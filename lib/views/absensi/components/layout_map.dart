import 'package:app/global_resource.dart';

Widget mapLayout(BuildContext context, s) {
  return GoogleMap(
    initialCameraPosition: CameraPosition(target: s.currentLocation, zoom: 15),
    mapType: MapType.normal,
    scrollGesturesEnabled: false,
    mapToolbarEnabled: false,
    zoomGesturesEnabled: false,
    zoomControlsEnabled: false,
    myLocationButtonEnabled: false,
    myLocationEnabled: true,
    onMapCreated: (controller) async {
      s.googleMapController.complete(controller);
      s.lokasiDetect();
    },
    markers: {
      Marker(
        markerId: const MarkerId("value1"),
        position: s.currentLocation,
        icon: s.customMarker,
      )
    },
  );
}
