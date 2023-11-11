import 'dart:async';

import 'package:app/data/models/company.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/source/firebase/firebase_service.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/helpers/base.dart';
import 'package:app/services/push_notification_service.dart';
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
  ) : super(const AppState());

  final ApiService api;
  final GetStorage box;
  final FirebaseService firebaseService;
  final PushNotificationService pushNotificationService;
  StreamSubscription<String>? _streamSubscriptionToken;

  Future<void> getProfile() async {
    final user = box.read(Base.dataUser);
    final email = user?['alamatEmail'];
    if (email is String) {
      try {
        final profile = await api.getProfile(email: email);
        if (!isClosed) {
          emit(state.copyWith(currentUser: profile));
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
      if (state.currentUser!.id != null && token != null) {
        final userId = state.currentUser!.id!.toString();
        _updateToken(userId, token);
      }
    });

    _streamSubscriptionToken =
        pushNotificationService.onTokenRefresh().listen((token) {
      if (state.currentUser!.id != null) {
        final userId = state.currentUser!.id!.toString();
        _updateToken(userId, token);
      }
    });
  }

  _updateToken(String userId, String token) {
    firebaseService
        .setToken(userId: userId, fcmToken: token)
        .then((value) {});
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
}
