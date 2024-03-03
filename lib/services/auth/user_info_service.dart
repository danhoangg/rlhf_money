import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoService extends ChangeNotifier {
  // Firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user info
  Stream<DocumentSnapshot> getUserInfo() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .snapshots();
  }

  // is user a dev
  Future<bool> isDev() async {
    final DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    return userDoc['dev'];
  }

  // Change password
  Future<void> changePassword(String newPassword) async {
    await _auth.currentUser!.updatePassword(newPassword);
  }

  // Change email
  Future<void> changeEmail(String newEmail) async {
    await _auth.currentUser!.verifyBeforeUpdateEmail(newEmail);
  }

  // Change name
  Future<void> changeName(String firstName, String lastName) async {
    if (firstName.isEmpty && lastName.isEmpty) {
      return;
    } else if (firstName.isEmpty) {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'lastName': lastName,
      });
    } else if (lastName.isEmpty) {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'firstName': firstName,
      });
    } else {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'firstName': firstName,
        'lastName': lastName,
      });
    }
  }

  // add model to user
}
