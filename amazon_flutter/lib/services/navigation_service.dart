import 'package:amazon_flutter/view/login_view/loginOtpPage.dart';
import 'package:amazon_flutter/view/login_view/loginPasswordPage.dart';
import 'package:amazon_flutter/view/login_view/main_login_page.dart';
import 'package:amazon_flutter/view/master.dart';
import 'package:amazon_flutter/view/product/product_detail_view.dart';
import 'package:amazon_flutter/view/search/searchView.dart';
import 'package:flutter/material.dart';

const String masterRoute = '/master';
const String loginRoute = "/login";
const String signUpRoute = "/signIn";
const String passLoginRoute = "/signInPass";
const String otpLoginRoute = "/signInOtp";
const String searchRoute = "/searchPage";
const String productDetails = "/productDetailPage";

Route<dynamic> controller(var routeName) {
  switch (routeName) {
    case loginRoute:
      return pageRouteBuilder(const MainLoginPage(panel: loginRadio.signIn));
    case masterRoute:
      return pageRouteBuilder(const MasterPage());
    case signUpRoute:
      return pageRouteBuilder(const MainLoginPage(panel: loginRadio.signUp));
    case passLoginRoute:
      return pageRouteBuilder(const PasswordLoginPage());
    case otpLoginRoute:
      return pageRouteBuilder(const OtpLoginPage());
    case searchRoute:
      return pageRouteBuilder(const SearchPage());
    case productDetails:
      return pageRouteBuilder(const ProductDetails());
    default:
      throw ("this route name doesn't exist");
  }
}

PageRouteBuilder<dynamic> pageRouteBuilder(var mainPage) {
  return PageRouteBuilder(
    pageBuilder: (c, a1, a2) => mainPage,
    transitionsBuilder: (c, anim, c2, child) => FadeTransition(
      opacity: anim,
      child: child,
    ),
    transitionDuration: const Duration(milliseconds: 00),
  );
}
