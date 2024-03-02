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

  // register user
  Future<UserCredential> registerWithEmailAndPassword(String email,
      String password, String firstName, String lastName, bool dev) async {
    try {
      // attempt to register user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create new document in firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'dev': dev,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
