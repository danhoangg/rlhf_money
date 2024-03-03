import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModelService extends ChangeNotifier {
  // fetch all models
  Stream<QuerySnapshot> fetchModels() {
    return FirebaseFirestore.instance
        .collection('models')
        .limit(10)
        .snapshots();
  }

  // fetch all questions from model
  Stream<QuerySnapshot> fetchQuestions(String modelId) {
    return FirebaseFirestore.instance
        .collection('models')
        .doc(modelId)
        .collection('questions')
        .snapshots();
  }
}
