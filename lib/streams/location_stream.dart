import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationStream {
  static StreamSubscription<Position>? _positionStream;

  static set positionStream(StreamSubscription<Position>? value) {
    _positionStream = value;
  }

  static StreamSubscription<Position>? get positionStream => _positionStream;
}
