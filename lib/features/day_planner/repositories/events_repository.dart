import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_planner/features/day_planner/models/add_event.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:day_planner/features/health/models/health_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

const _schedulesCollection = 'schedules';

abstract class EventsRepository {
  Future<String> addEvent(AddEventModel addEvent);

  Future<void> updateEvent(DayEvent eventToUpdate);

  Stream<QuerySnapshot<DayEvent?>> dayEventStream(String dayMilliseconds);

  Future<void> deleteEvent(String dateMilliseconds, String docId);

  Future<void> addHealthData({
    required String docId,
    required String dateMilliSeconds,
    required HealthModel healthModel,
  });
}

class EventsRepositoryImpl implements EventsRepository {
  final FirebaseFirestore _firebaseFirestore;

  const EventsRepositoryImpl(this._firebaseFirestore);

  @override
  Future<String> addEvent(AddEventModel addEvent) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final day = DateTime(addEvent.from.year, addEvent.from.month, addEvent.from.day);

      final userEventsDocRef = _firebaseFirestore.collection(_schedulesCollection).doc(uid);

      final dayCollection = day.millisecondsSinceEpoch.toString();
      final docRef = await userEventsDocRef.collection(dayCollection).add(addEvent.toJson());
      return docRef.id;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateEvent(DayEvent eventToUpdate) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final day = DateTime(eventToUpdate.from.year, eventToUpdate.from.month, eventToUpdate.from.day);

      final userEventsDocRef = _firebaseFirestore.collection(_schedulesCollection).doc(uid);

      final dayCollection = day.millisecondsSinceEpoch.toString();
      await userEventsDocRef.collection(dayCollection).doc(eventToUpdate.docId).update(eventToUpdate.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot<DayEvent?>> dayEventStream(String dayMilliseconds) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _firebaseFirestore
        .collection(_schedulesCollection)
        .doc(uid)
        .collection(dayMilliseconds)
        .withConverter<DayEvent?>(
          fromFirestore: (snapshot, _) {
            if (snapshot.data() != null) {
              final dayEvent = DayEvent.fromJson(snapshot.data()!, snapshot.id);
              return dayEvent;
            }
            return null;
          },
          toFirestore: (_, __) => {},
        )
        .snapshots();
  }

  @override
  Future<void> deleteEvent(String dateMilliseconds, String docId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _firebaseFirestore.collection(_schedulesCollection).doc(uid).collection(dateMilliseconds).doc(docId).delete();
  }

  @override
  Future<void> addHealthData({
    required String docId,
    required String dateMilliSeconds,
    required HealthModel healthModel,
  }) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await _firebaseFirestore
          .collection(_schedulesCollection)
          .doc(uid)
          .collection(dateMilliSeconds)
          .doc(docId)
          .update({'health_model': healthModel.toJson()});
    } catch (e) {
      rethrow;
    }
  }
}
