import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;

import 'constant.dart';

Future<BitmapDescriptor> getGoogleMapsMarker(String? foto) {
  if (foto != null) {
    final fotoUrl = Uri.tryParse(changeUrlImage(foto));
    if (fotoUrl != null) {
      return http.get(fotoUrl).then((http.Response response) async {
        ui.Codec codec = await ui.instantiateImageCodec(
          response.bodyBytes,
          targetWidth: 128,
        );
        ui.FrameInfo fi = await codec.getNextFrame();
        final byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
        var bytes = byteData!.buffer.asUint8List();
        final img = image.decodeImage(bytes);
        if (img != null) {
          final circleImg = image.copyCropCircle(img);
          bytes = image.encodePng(circleImg);
        }

        return BitmapDescriptor.fromBytes(
          bytes,
          size: const ui.Size(128, 128),
        );
      });
    }
  }

  return BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: ui.Size(64, 64)),
    'assets/icons/logo/hora.png',
  );
}