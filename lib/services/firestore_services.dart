import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    required String mobile,
    required String upiId,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'mobile': mobile,
      'upiId': upiId,

      'walletBalance': 0,

      'role': 'user',

      'createdAt': Timestamp.now(),
    });
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot documentSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>,

          documentSnapshot.id,
        );
      }

      return null;
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<void> createTransaction({
    required int amount,
    required String type,
    required String description,
  }) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      await _firestore.collection('transactions').add({
        'userId': uid,

        'amount': amount,

        'type': type,

        'status': 'pending',

        'description': description,

        'createdAt': DateTime.now().toString(),
      });
    } catch (e) {
      print(e);
    }
  }
}
