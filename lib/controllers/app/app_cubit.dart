import 'dart:async';
import 'dart:convert';

import 'package:app/data/models/absence.dart';
import 'package:app/data/models/company.dart';
import 'package:app/data/models/livetracking/live_tracking.dart';
import 'package:app/data/models/notification/push_notification.dart';
import 'package:app/data/models/profile.dart';
import 'package:app/data/source/firebase/firebase_service.dart';
import 'package:app/data/source/notification/push_notif_api_service.dart';
import 'package:app/data/source/remote/api_service.dart';
import 'package:app/helpers/base.dart';
import 'package:app/helpers/constant.dart';
import 'package:app/helpers/debouncer.dart';
import 'package:app/helpers/notification_local.dart';
import 'package:app/services/push_notification_service.dart';
import 'package:background_location/background_location.dart' as bg;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'app_cubit.freezed.dart';

part 'app_cubit.g.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit(
    this.api,
    this.pushNotificationApiService,
    this.box,
    this.firebaseService,
    this.pushNotificationService,
  ) : super(const AppState());

  final ApiService api;
  final PushNotificationApiService pushNotificationApiService;
  final GetStorage box;
  final FirebaseService firebaseService;
  final PushNotificationService pushNotificationService;
  final _deBouncer = DeBouncer(delay: const Duration(milliseconds: 1000));
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
          getTodayAttendance();
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

  clearToken() {
    AwesomeNotificationService().removeNotification();
    emit(const AppState());
    final userId = state.currentUser?.idkaryawan;
    if (userId == null) return;
    firebaseService.setToken(userId: userId).then((value) {});
  }

  requestLiveTracking(String broadcasterId) {
    if (state.currentUser!.idkaryawan != null) {
      final listenerId = state.currentUser!.idkaryawan!;
      final name = state.currentUser!.name ?? 'Karyawan-$listenerId';

      firebaseService
          .setLiveTracking(
        broadcasterId: broadcasterId,
        listenerId: listenerId,
      )
          .then((tracking) {
        _sendPushNotification(
          title: '$name mengirimkan permintaan lokasi',
          body: 'Sentuh untuk memperbarui lokasi Anda',
          data: {
            'listener_id': listenerId,
            'broadcaster_id': broadcasterId,
            'tag': 'REQUEST_LIVE_TRACKING#$listenerId',
          },
          idKaryawan: broadcasterId,
        );
        debugPrint('Tracking data set: ${jsonEncode(tracking.toJson())}');
      }, onError: (e, s) {
        debugPrint('Tracking data failed to set: ${e.toString()}');
        debugPrintStack(stackTrace: s);
      });
    }
  }

  _sendPushNotification({
    required String title,
    required String body,
    required Map<String, String> data,
    required String idKaryawan,
  }) {
    return pushNotificationApiService.sendPushNotification(
      PushNotification(
        notification: Notification(title: title, body: body),
        data: data,
        android: const Android(notification: AndroidNotification()),
        karyawanIds: [idKaryawan],
      ),
    );
  }

  setLiveTracking(
    String broadcasterId,
    String listenerId,
    bool approve, [
    double? latitude,
    double? longitude,
  ]) {
    if (state.currentUser!.idkaryawan != null) {
      final name = state.currentUser!.name ?? 'Karyawan-$listenerId';

      firebaseService
          .setLiveTracking(
        broadcasterId: broadcasterId,
        listenerId: listenerId,
        requestApproved: approve,
        latitude: latitude,
        longitude: longitude,
      )
          .then((tracking) {
        _sendPushNotification(
          title: '$name ${approve ? 'menerima' : 'menolak'} permintaan lokasi',
          body: approve
              ? 'Sentuh untuk membuka'
              : 'Sentuh untuk mengirimkan ulang',
          data: {
            'listener_id': listenerId,
            'broadcaster_id': broadcasterId,
            'tag':
                '${approve ? 'APPROVE' : 'REJECT'}_REQUEST_LIVE_TRACKING#$listenerId',
          },
          idKaryawan: listenerId,
        );
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
      debugPrint('$listenerId listen to tracking ${list.length} data');
    } catch (_) {}
  }

  updateLiveTrackingList(double latitude, double longitude) async {
    if (state.currentUser?.idkaryawan == null) return;

    try {
      final broadcasterId = state.currentUser!.idkaryawan!;
      final list = await firebaseService.getLiveTrackingList(
        broadcastId: broadcasterId,
      );
      debugPrint('$broadcasterId broadcast tracking ${list.length} to update');
      if (list.isNotEmpty) {
        await firebaseService.updateLiveTrackingList(
          list: list,
          latitude: latitude,
          longitude: longitude,
        );
      }
    } catch (_) {}
  }

  Future<void> getTodayAttendance() async {
    final user = state.currentUser;
    if (user == null) return;
    final idkaryawan = user.idkaryawan;
    if (idkaryawan == null) return;
    final now = DateTime.now();
    final tanggal = kMysqlDateFormat.format(now);
    return api.getAttendance(idkaryawan: idkaryawan, tanggal: tanggal).then(
        (attendances) {
      if (attendances.isNotEmpty) {
        emit(state.copyWith(todayAttendance: attendances.first));
      }
    }, onError: (_, __) {});
  }

  void getAllowLocationAlwaysPermission() {
    Permission.locationWhenInUse.status.then((status) {
      final granted = status == PermissionStatus.granted;
      if (granted) {
        Permission.locationAlways.status.then((status) {
          if (state.allowLocationAlwaysPermission) {
            if (status == PermissionStatus.granted) {
              runRealtimeServices();
            } else {
              emit(state.copyWith(allowLocationAlwaysPermission: false));
            }
          }
        });
      } else {
        if (state.allowLocationAlwaysPermission) {
          emit(state.copyWith(allowLocationAlwaysPermission: false));
        }
      }
    });
  }

  void setAllowLocationAlwaysPermission(bool allowLocationAlwaysPermission) {
    emit(state.copyWith(
      allowLocationAlwaysPermission: allowLocationAlwaysPermission,
    ));
  }

  runRealtimeServices() async {
    final fgLocGranted = await Permission.locationWhenInUse.isGranted;
    if (!fgLocGranted) {
      return;
    }
    final bgLocGranted = await Permission.locationAlways.isGranted;
    if (!bgLocGranted) {
      final status = await Permission.locationAlways.request();
      if (!status.isGranted) {
        return;
      }
    }
    await bg.BackgroundLocation.setAndroidNotification(
      title: "Sedang mendeteksi lokasi di latar belakang",
      message: "Diharapkan untuk tetap membuka aplikasi Hora",
      icon: "@mipmap/ic_launcher",
    );
    await bg.BackgroundLocation.setAndroidConfiguration(
      kDebugMode ? (5 * 1000) : (5 * 60 * 1000),
    );
    await bg.BackgroundLocation.startLocationService(
      distanceFilter: kDebugMode ? 0 : 5,
    );
    bg.BackgroundLocation.getLocationUpdates((bg.Location location) {
      _deBouncer.call(() {
        if (!isClosed &&
            location.latitude != null &&
            location.longitude != null) {
          updateLiveTrackingList(location.latitude!, location.longitude!);
        }
      });
    });
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
    bg.BackgroundLocation.stopLocationService();

    return super.close();
  }
}
