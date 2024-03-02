import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // firebase firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login method
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // attempt sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
