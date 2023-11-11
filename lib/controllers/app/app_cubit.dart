import 'dart:async';
import 'dart:convert';

import 'package:app/data/models/company.dart';
import 'package:app/data/models/livetracking/live_tracking.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/source/firebase/firebase_service.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/helpers/base.dart';
import 'package:app/services/push_notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_cubit.freezed.dart';

part 'app_cubit.g.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit(
    this.api,
    this.box,
    this.firebaseService,
    this.pushNotificationService,
  ) : super(const AppState()) ;

  final ApiService api;
  final GetStorage box;
  final FirebaseService firebaseService;
  final PushNotificationService pushNotificationService;
  StreamSubscription<String>? _streamSubscriptionToken;
  Timer? _liveTrackingTimer;

  Future<void> getProfile() async {
    final user = box.read(Base.dataUser);
    final email = user?['alamatEmail'];
    if (email is String) {
      try {
        final profile = await api.getProfile(email: email);
        if (!isClosed) {
          emit(state.copyWith(currentUser: profile));
          initLiveTracking();
        }
      } catch (_) {}
    }
  }

  Future<void> getCompany() async {
    final user = box.read(Base.dataUser);
    final email = user?['alamatEmail'];
    if (email is String) {
      try {
        final companies = await api.getCompany(email: email);
        if (!isClosed && companies.isNotEmpty) {
          emit(state.copyWith(company: companies.first));
        }
      } catch (_) {}
    }
  }

  Future<void> toggleLikeUnlike() async {
    String karyawanId = '', perusahaanId = '';
    if (state.currentUser != null) {
      if (state.currentUser!.idkaryawan != null) {
        karyawanId = state.currentUser!.idkaryawan!;
      }

      if (state.currentUser!.perusahaanId != null) {
        perusahaanId = state.currentUser!.perusahaanId!;
      }
    } else {
      final user = box.read(Base.dataUser);
      if (user?['idkaryawan'] is String) {
        karyawanId = user['idkaryawan'];
      }

      if (user?['idperusahaan'] is String) {
        perusahaanId = user['idperusahaan'];
      }
    }

    try {
      await api.toggleLikeUnlike(
        karyawanId: karyawanId,
        perusahaanId: perusahaanId,
      );
      if (!isClosed) {
        getProfile();
        getCompany();
      }
    } catch (_) {}
  }

  Future<void> stopWorking(Function([String?]) onDone) async {
    final user = box.read(Base.dataUser);
    final email = user?['alamatEmail'];
    if (email is String) {
      try {
        await api.stopWorking(email: email);
        onDone();
      } catch (_) {
        onDone('Pengguna tidak ditemukan');
      }
    }
  }

  updateTokenFcm() {
    pushNotificationService.getToken().then((token) {
      if (state.currentUser!.idkaryawan != null && token != null) {
        final userId = state.currentUser!.idkaryawan!;
        _updateToken(userId, token);
      }
    });

    _streamSubscriptionToken =
        pushNotificationService.onTokenRefresh().listen((token) {
      if (state.currentUser!.idkaryawan != null) {
        final userId = state.currentUser!.idkaryawan!;
        _updateToken(userId, token);
      }
    });
  }

  _updateToken(String userId, String token) {
    firebaseService.setToken(userId: userId, fcmToken: token).then((value) {});
  }

  requestLiveTracking(String broadcasterId) {
    if (state.currentUser!.idkaryawan != null) {
      final listenerId = state.currentUser!.idkaryawan!;

      firebaseService
          .addLiveTracking(
        broadcasterId: broadcasterId,
        listenerId: listenerId,
      )
          .then((tracking) {
        debugPrint('Tracking data set: ${jsonEncode(tracking.toJson())}');
      }, onError: (e, s) {
        debugPrint('Tracking data failed to set: ${e.toString()}');
        debugPrintStack(stackTrace: s);
      });
    }
  }

  initLiveTracking() {
    if (_liveTrackingTimer != null) return;
    _liveTrackingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      getLiveTrackingList(timer);
    });
  }

  getLiveTrackingList([Timer? timer]) async {
    if (state.currentUser?.idkaryawan == null) return;

    try {
      final listenerId = state.currentUser!.idkaryawan!;
      final list = await firebaseService.getLiveTrackingList(
        listenerId: listenerId,
      );
      if (isClosed) {
        timer?.cancel();
        return;
      }
      emit(state.copyWith(liveTrackingList: list));
      debugPrint('Found live tracking ${list.length} data');
    } catch (_) {}
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    try {
      return AppState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    _streamSubscriptionToken?.cancel();
    _liveTrackingTimer?.cancel();

    return super.close();
  }
}
