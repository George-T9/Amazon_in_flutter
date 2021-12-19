import 'package:amazon_flutter/util/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_options.dart';

abstract class BaseApplicationState {
  Future<dynamic> verifyEmail(String email, void Function(FirebaseAuthException));

  Future<void> signInWithEmailAndPassword(
      String email, String password, void Function(FirebaseAuthException));

  Future<void> getCurrent();

  Future<void> registerAccount(String displayName, String email,
      String password, void Function(FirebaseAuthException));

  Future<void> signOut();
}

class ApplicationState extends ChangeNotifier implements BaseApplicationState {
  ApplicationState() {
    init();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;

  ApplicationLoginState get loginState => _loginState;

  ConnectionStates _connectionState = ConnectionStates.ideal;

  ConnectionStates get connectionState => _connectionState;

  String? _email;

  String? get email => _email;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _firebaseAuth.userChanges().listen((User? user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        print("User is signed in ${user.displayName}");
        notifyListeners();
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        print("User is signed out");
        notifyListeners();
      }
    });
  }

  @override
  Future<User?> getCurrent() async => _firebaseAuth.currentUser;

  @override
  Future<dynamic> verifyEmail(String email,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      _connectionState = ConnectionStates.busy;
      notifyListeners();

      var methods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      print("Method found -- ${methods.toString()}");
      if (methods.contains("password")) {
        _email = email;
        _connectionState = ConnectionStates.ideal;
        notifyListeners();
        return true;
      } else {
        _email = email;
        _connectionState = ConnectionStates.ideal;
        notifyListeners();
        return false;
      }
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      print(e.toString());
      _connectionState = ConnectionStates.ideal;
      notifyListeners();
      return e;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);

    }
  }

  @override
  Future<void> signOut() async {

      await _firebaseAuth.signOut();
      notifyListeners();
  }

  @override
  Future<void> registerAccount(String displayName, String email,
      String password, void Function(FirebaseAuthException e) errorCallback) async {
    try {
      _connectionState = ConnectionStates.busy;
      notifyListeners();

      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateDisplayName(displayName);


      _connectionState = ConnectionStates.ideal;
      notifyListeners();

    } on FirebaseAuthException catch (e) {
      print(e.toString());
      errorCallback(e);
      _connectionState = ConnectionStates.ideal;
      notifyListeners();
    }
  }

}
