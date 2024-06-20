import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_planner/features/profile/models/health_thresholds.dart';
import 'package:day_planner/features/profile/models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

const _usersCollection = 'users';

abstract class ProfileRepository {
  Future<void> addProfile(User user);

  Query<UserProfile> fetchUser(String uid);

  Future<void> updateUser(String uid, Map<String, dynamic> data);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  const ProfileRepositoryImpl(this._firebaseFirestore);

  @override
  Future<void> addProfile(User user) async {
    try {
      final healthThresholds = HealthThresholds(
        steps: 65000,
        kcal: 19000.0,
        heartRate: 75,
      );
      final userRec = {
        'uid': user.uid,
        'phone_number': user.phoneNumber,
        'health_thresholds': healthThresholds.toJson(),
      };
      await _firebaseFirestore.collection(_usersCollection).add(userRec);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Query<UserProfile> fetchUser(String uid) {
    return _firebaseFirestore.collection(_usersCollection).where('uid', isEqualTo: uid).withConverter<UserProfile>(
          fromFirestore: (snapshots, _) => UserProfile.fromJson(snapshots.data() ?? {}),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );
  }

  @override
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      final querySnapshot = await _firebaseFirestore.collection(_usersCollection).where('uid', isEqualTo: uid).get();

      if (querySnapshot.docs.isNotEmpty) {
        final docRef = querySnapshot.docs.first.reference;

        await docRef.update(data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
