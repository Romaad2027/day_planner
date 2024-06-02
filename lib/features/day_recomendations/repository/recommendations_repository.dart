import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_planner/features/day_planner/models/day_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

const _schedulesCollection = 'schedules';

abstract class RecommendationsRepository {
  Future<List<DayEvent>> rangeHealthData(DateTime from, DateTime to);
}

class RecommendationsRepositoryImpl implements RecommendationsRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<DayEvent>> rangeHealthData(DateTime from, DateTime to) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      List<int> dateKeysInRange = [];
      for (int dateMillis = from.millisecondsSinceEpoch;
          dateMillis <= to.millisecondsSinceEpoch;
          dateMillis += const Duration(days: 1).inMilliseconds) {
        dateKeysInRange.add(dateMillis);
      }

      List<QueryDocumentSnapshot<DayEvent?>> allDayEvents = [];

      for (int dateKey in dateKeysInRange) {
        final querySnapshot = await _firebaseFirestore
            .collection(_schedulesCollection)
            .doc(uid)
            .collection(dateKey.toString())
            .withConverter<DayEvent?>(
              fromFirestore: (snapshot, _) {
                if (snapshot.data() == null) {
                  return null;
                }
                final dayEvent = DayEvent.fromJson(snapshot.data()!, snapshot.id);
                return dayEvent;
              },
              toFirestore: (_, __) => {},
            )
            .get();
        allDayEvents.addAll(querySnapshot.docs);
      }
      allDayEvents.removeWhere(
        (e) => e.data() == null,
      );
      return allDayEvents.map((e) => e.data()!).toList();
    } catch (e) {
      rethrow;
    }
  }
}
