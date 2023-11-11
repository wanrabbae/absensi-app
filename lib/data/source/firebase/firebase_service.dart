import 'package:app/data/models/livetracking/live_tracking.dart';
import 'package:app/data/models/token/fcm_token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseService({bool enableLogging = false})
      : _firestore = FirebaseFirestore.instance {
    _firestore.settings = const Settings(persistenceEnabled: true);
    FirebaseFirestore.setLoggingEnabled(enableLogging);
  }

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collectionLiveLocation =>
      _firestore.collection('live_location');

  CollectionReference<Map<String, dynamic>> get _collectionToken =>
      _firestore.collection('tokens');

  Future<List<LiveTracking>> getLiveTrackingList({
    String? broadcastId,
    String? listenerId,
  }) async {
    var q = _collectionLiveLocation;
    if (broadcastId != null) {
      q.where('broadcast_id', isEqualTo: broadcastId);
    } else if (listenerId != null) {
      q.where('listener_id', isEqualTo: listenerId);
    }

    final snapshot = await q
        .where('request_approved', isEqualTo: true)
        .orderBy('last_update')
        .get();

    return snapshot.docChanges.where((dc) => dc.doc.data() != null).map((dc) {
      final doc = dc.doc;
      final json = doc.data()!;

      return LiveTracking.fromJson(json).copyWith(uid: doc.id);
    }).toList();
  }

  Future<LiveTracking> addLiveTracking({
    required String broadcasterId,
    required String listenerId,
    bool requestApproved = false,
  }) async {
    final data = LiveTracking(
      broadcasterId: broadcasterId,
      listenerId: listenerId,
      requestApproved: requestApproved,
    );

    final snapshot = await _collectionLiveLocation
        .where('broadcast_id', isEqualTo: broadcasterId)
        .where('listener_id', isEqualTo: listenerId)
        .limit(1)
        .get();

    if (snapshot.size > 0) {
      final doc = snapshot.docs.first;
      return _collectionLiveLocation
          .doc(doc.id)
          .update(data.toJson())
          .then((value) => data.copyWith(uid: doc.id));
    }

    return _collectionLiveLocation
        .add(data.toJson())
        .then((ref) => ref.get())
        .then((doc) {
      return LiveTracking.fromJson(doc.data()!).copyWith(
        uid: doc.id,
      );
    });
  }

  Future<dynamic> updateLiveTrackingList({
    required List<LiveTracking> list,
    required double latitude,
    required double longitude,
  }) {
    final data = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'last_update': DateTime.now().toUtc().toIso8601String(),
    };

    final futures = <Future<void>>[];
    for (var tracking in list) {
      if (tracking.requestApproved && tracking.uid != null) {
        futures.add(
          _collectionLiveLocation
              .doc(tracking.uid!)
              .set(data, SetOptions(merge: true)),
        );
      }
    }

    return Future.wait(futures);
  }

  Future<void> setToken({
    required String userId,
    required String fcmToken,
  }) {
    final data = <String, dynamic>{
      'fcmToken': fcmToken,
    };
    return _collectionToken.doc(userId).set(data, SetOptions(merge: true));
  }

  Future<String> getToken(String userId) {
    return _collectionToken.doc(userId).get().then((snapshot) {
      final data = snapshot.data() ?? {};
      return FcmToken.fromJson(data).token;
    });
  }
}
