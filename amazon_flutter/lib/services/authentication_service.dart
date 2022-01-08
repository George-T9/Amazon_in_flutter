import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? currentUser;

  void getUser() {
    _firebaseAuth.userChanges().listen((User? user) {
      if (user != null) {
        currentUser = user;
      } else {
        currentUser = null;
      }
    });
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future<dynamic> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future<dynamic> verifyEmail(
    String email,
    // void Function(FirebaseAuthException e) errorCallback
  ) async {
    try {
      var methods = await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (methods.contains("password")) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future<dynamic> registerAccount(
      String displayName, String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
      return credential;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }
}
