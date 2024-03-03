import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RewardsService extends ChangeNotifier {
  // auth isntance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // finish survey and collect rewards
  Future<void> finishSurvey(
      String model_id, List<int> selected_responses) async {
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

    // updating question results

    WriteBatch batch = _firestore.batch();
    CollectionReference questionsRef =
        _firestore.collection('models').doc(model_id).collection('questions');

    var querySnapshot = await questionsRef.get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var questionDoc = querySnapshot.docs[i];

      if (i < selected_responses.length) {
        int selectedResponseIndex = selected_responses[i];

        List<dynamic> currentResults = questionDoc['results'];
        if (selectedResponseIndex < currentResults.length) {
          currentResults[selectedResponseIndex] += 1;

          batch.update(questionDoc.reference, {'results': currentResults});
        }
      }
    }

    await batch.commit().catchError((error) {
      print("Error updating results: $error");
    });
  }
}
