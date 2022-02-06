import 'package:amazon_flutter/main.dart';
import 'package:amazon_flutter/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum LoginState{
  loggedIn,
  loggedOut,
}

class UserViewModel with ChangeNotifier {
  final _firebaseAuth = getIt<AuthenticationService>();

  User? _currentUser;
  User? get currentUser => _currentUser;

  set currentUser(User? user){
   _currentUser = user;
   connectionState = ConnectionState.done;
    notifyListeners();
  }

  ConnectionState _connectionState = ConnectionState.none;
  ConnectionState get connectionState => _connectionState;

  set connectionState(ConnectionState state){
    _connectionState = state;
    notifyListeners();
  }

  String? _email;
  String? get email => _email;

  Future<bool> verifyEmail(String email) async{
    connectionState = ConnectionState.waiting;
    _email = email;
    var verified = await _firebaseAuth.verifyEmail(email);
    if(verified){
      connectionState = ConnectionState.done;
      return true;
    }else{
      connectionState = ConnectionState.done;
      return false;
    }
  }

  Future<void> signIn(String email,String password) async {
    connectionState = ConnectionState.waiting;
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(email, password);
    if(userCredential is UserCredential){
      currentUser = userCredential.user;
    }else{
      currentUser = null;
    }
    connectionState = ConnectionState.done;
  }

  Future<void> signOut() async{
    connectionState = ConnectionState.waiting;
    notifyListeners();
    await _firebaseAuth.signOut();
    currentUser = null;
  }

  Future<void> registerAccount(String displayName,String email,String password,) async{
    connectionState = ConnectionState.waiting;
    var userCredential = await _firebaseAuth.registerAccount(displayName, email, password);
    if(userCredential is UserCredential){
      currentUser = userCredential.user;
    }else{
      currentUser = null;
    }
  }
}
