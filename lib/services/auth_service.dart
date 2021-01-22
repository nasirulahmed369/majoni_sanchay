import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:majoni_sanchay/models/user.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth;
  AuthServices(this._firebaseAuth);

  final Query db = FirebaseFirestore.instance.collection('users');

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  UserModel _userFromFirebase(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
