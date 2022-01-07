import 'package:amazon_flutter/services/authentication_service.dart';
import 'package:amazon_flutter/util/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class UserViewModel with ChangeNotifier {
  UserViewModel() {
    init();
  }

  void init() {

  }

  var _currentUser;
  get currentUser => _currentUser;

  final _firebaseAuth = getIt<AuthenticationService>();



}
