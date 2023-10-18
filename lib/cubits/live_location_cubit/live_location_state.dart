part of 'live_location_cubit.dart';

@immutable
abstract class LiveLocationState {}

class LiveLocationInitial extends LiveLocationState {}

class LiveLocationLoading extends LiveLocationState {}

class LiveLocationOk extends LiveLocationState {
  final feature;
  final data;
  final Map<String, dynamic>? extra;

  LiveLocationOk({
    this.feature,
    this.data,
    this.extra,
  });
}
