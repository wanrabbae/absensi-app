import 'package:app/data/models/livetracking/log/live_location_log.dart';
import 'package:app/data/source/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_location_log_cubit.freezed.dart';

part 'live_location_log_state.dart';

class LiveLocationLogCubit extends Cubit<LiveLocationLogState> {
  LiveLocationLogCubit(this.api, this.userId)
      : super(const LiveLocationLogState());

  final FirebaseService api;
  final String userId;

  Future<void> fetch({int limit = 10}) async {
    try {
      final data = await api.getLiveTrackingLogList(userId: userId);
      emit(state.copyWith(data: data, error: null));
    } on FirebaseException catch (e) {
      emit(state.copyWith(data: null, error: e.message ?? e.code));
    }
  }
}
