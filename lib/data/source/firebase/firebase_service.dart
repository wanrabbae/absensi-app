import 'package:app/data/models/livetracking/live_tracking.dart';
import 'package:app/data/models/token/fcm_token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseService({bool enableLogging = false})
      : _firestore = FirebaseFirestore.instance {
    _firestore.settings = const Settings();
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
    assert(
      broadcastId != null || listenerId != null,
      'Select one of either broadcastId or listenerId',
    );

    final query = _collectionLiveLocation
        .where(
          broadcastId != null ? 'broadcaster_id' : 'listener_id',
          // ignore: prefer_if_null_operators
          isEqualTo: broadcastId != null ? broadcastId : listenerId,
        )
        .where('request_approved', isEqualTo: true);
    final snapshot = await query.get();

    final docs = snapshot.docs;
    return docs.map((doc) {
      final json = doc.data();
      return LiveTracking.fromJson(json).copyWith(uid: doc.id);
    }).toList();
  }

  Future<LiveTracking> setLiveTracking({
    required String broadcasterId,
    required String listenerId,
    bool requestApproved = false,
    double? latitude,
    double? longitude,
  }) async {
    final data = LiveTracking(
      broadcasterId: broadcasterId,
      listenerId: listenerId,
      requestApproved: requestApproved,
      latitude: latitude,
      longitude: longitude,
    );

    final snapshot = await _collectionLiveLocation
        .where('broadcaster_id', isEqualTo: broadcasterId)
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

    final batch = _firestore.batch();
    for (var tracking in list) {
      if (tracking.requestApproved && tracking.uid != null) {
        final document = _collectionLiveLocation.doc(tracking.uid!);
        batch.set(document, data, SetOptions(merge: true));
      }
    }

    return batch.commit();
  }

  Future<List<String>> clearAllLiveTracking(String broadcasterId) {
    final listenerIds = <String>[];
    return _collectionLiveLocation
        .where('broadcaster_id', isEqualTo: broadcasterId)
        .get()
        .then((snapshot) {
      final futures = <Future<void>>[];
      for (var doc in snapshot.docs) {
        listenerIds.add(doc.data()['listener_id'].toString());
        final remove = _collectionLiveLocation.doc(doc.id).delete();
        futures.add(remove);
      }

      return Future.wait(futures).then((value) {
        return Future.value(listenerIds);
      });
    });
  }

  Future<void> setToken({
    required String userId,
    String? fcmToken,
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
