import 'package:app/data/models/livetracking/live_tracking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  FirebaseService({bool enableLogging = false})
      : _firestore = FirebaseFirestore.instance {
    _firestore.settings = const Settings(persistenceEnabled: true);
    FirebaseFirestore.setLoggingEnabled(enableLogging);
  }

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collectionLiveTracking =>
      _firestore.collection('live_tracking');

  Future<List<LiveTracking>> getLiveTrackingList(String broadcastId) async {
    final snapshot = await _collectionLiveTracking
        .where('broadcast_id', isEqualTo: broadcastId)
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

    return _collectionLiveTracking
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
          _collectionLiveTracking.doc(tracking.uid!).set(data, SetOptions(merge: true)),
        );
      }
    }

    return Future.wait(futures);
  }
}
