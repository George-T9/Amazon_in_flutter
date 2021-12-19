import 'package:amazon_flutter/page/loginPages/main_login_page.dart';
import 'package:amazon_flutter/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum ApplicationLoginState {
  loggedOut,
  loggedIn,
}

enum ConnectionStates {
  busy,
  ideal,
}
