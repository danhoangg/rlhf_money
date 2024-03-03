import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RewardsService extends ChangeNotifier {
  // auth isntance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // finish survey and collect rewards
  Future<void> finishSurvey(String model_id) async {
    _firestore.collection('models').doc(model_id).snapshots();
    _firestore.collection('models').doc(model_id).get().then((doc) {
      if (doc.exists) {
        var questionCount = doc.data()!['question_count'];
        var currentUserId = _auth.currentUser!.uid;

        _firestore
            .collection('users')
            .doc(currentUserId)
            .update({'balance': FieldValue.increment(questionCount)});

        _firestore.collection('models').doc(model_id).update({
          'completed': FieldValue.arrayUnion([currentUserId])
        });
      }
    });
  }
}
