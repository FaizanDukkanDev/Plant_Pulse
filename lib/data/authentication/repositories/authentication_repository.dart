import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantpulse/data/authentication/models/user.dart';
import 'package:plantpulse/ui/devices/repository/devices_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required DevicesRepository devicesRepository,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _devicesRepository = devicesRepository;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final DevicesRepository _devicesRepository;

  Stream<AppUser> appUser() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AppUser.empty
          : AppUser(
              id: firebaseUser.uid,
              email: firebaseUser.email!,
              name: firebaseUser.displayName ?? '',
              photo: firebaseUser.photoURL ?? '',
            );
    });
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;
      _devicesRepository.saveUser(user.uid, name, email);
      await user.updateDisplayName(name);
      /*
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'id': user.uid,
        'email': email,
        'displayName': name,
      });
      await FirebaseFirestore.instance.collection('planting').doc(user.uid).set({
        'id': user.uid,
      });
      await FirebaseFirestore.instance.collection('harvesting').doc(user.uid).set({
        'id': user.uid,
      });
      await FirebaseFirestore.instance
          .collection('planting')
          .doc(user.uid)
          .collection("month")
          .doc()
          .set({
        'month': -99,
      });
      await FirebaseFirestore.instance
          .collection('harvesting')
          .doc(user.uid)
          .collection("month")
          .doc()
          .set({
        'month': -99,
      }); */

    } on Exception catch (_) {
      debugPrint('LOG : EXCEPTION $_');
      throw SignUpFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final name = FirebaseAuth.instance.currentUser?.displayName;
      final email = FirebaseAuth.instance.currentUser?.email;
      if (token != null) {
        final user = await _devicesRepository.saveUser(token, name, email);
      }
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      print('done');
    } on Exception {
      print('bye');

      throw LogOutFailure();
    }
  }
}
