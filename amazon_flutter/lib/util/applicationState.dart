import 'dart:async';
import 'package:amazon_flutter/enum/enum_states.dart';
import 'package:amazon_flutter/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_options.dart';

abstract class BaseApplicationState {
  Future<dynamic> verifyEmail(
      String email, void Function(FirebaseAuthException) errorCallBack);

  Future<void> signInWithEmailAndPassword(String email, String password,
      void Function(FirebaseAuthException) errorCallBack);

  Future<void> getCurrent();

  Future<void> registerAccount(String displayName, String email,
      String password, void Function(FirebaseAuthException) errorCallBack);

  Future<void> signOut();

  Future<void> getProduct(void Function(FirebaseException) errorCallback);
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

  User? _user;

  User? get user => _user;

  StreamSubscription<QuerySnapshot>? _streamSubscription;

  List<Product> _productList = [];

  List<Product> get productList => _productList;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _firebaseAuth.userChanges().listen((User? user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _user = user;

        notifyListeners();
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _user = user;

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

      _connectionState = ConnectionStates.ideal;
      notifyListeners();
      return e;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      _connectionState = ConnectionStates.busy;
      notifyListeners();

      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      _loginState = ApplicationLoginState.loggedIn;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);

      _connectionState = ConnectionStates.ideal;
      notifyListeners();
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }

  @override
  Future<void> registerAccount(
      String displayName,
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      _connectionState = ConnectionStates.busy;
      notifyListeners();

      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateDisplayName(displayName);

      _connectionState = ConnectionStates.ideal;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      _connectionState = ConnectionStates.ideal;
      notifyListeners();
    }
  }

  @override
  Future<void> getProduct(
      void Function(FirebaseException) errorCallback) async {
    try {
      _streamSubscription = FirebaseFirestore.instance
          .collection("products_details")
          .orderBy("pid")
          .snapshots()
          .listen((snapshot) {
        _productList = [];
        for (final document in snapshot.docs) {
          _productList.add(Product(
              pid: document.id,
              title: document.data()["title"] as String,
              price: document.data()["price"] as String,
              rating: document.data()["rating"] as num,
              deliveryTime: document.data()["deliveryTime"] as num,
              discount: document.data()["discount"] as num,
              freeDelivery: document.data()["freeDelivery"] as bool,
              imageUrl: document.data()["imageUrls"] as List<dynamic>));
        }
        _streamSubscription?.cancel();
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      errorCallback(e);
    }
  }

  @override
  void dispose() {_streamSubscription?.cancel();
    super.dispose();
  }
}
