import 'package:amazon_flutter/firebase_options.dart';
import 'package:amazon_flutter/services/authentication_service.dart';
import 'package:amazon_flutter/services/firebase_service.dart';
import 'package:amazon_flutter/util/routes.dart';
import 'package:amazon_flutter/util/theme.dart';
import 'package:amazon_flutter/view/login_view/loginOtpPage.dart';
import 'package:amazon_flutter/view/login_view/loginPasswordPage.dart';
import 'package:amazon_flutter/view/login_view/login_option_page.dart';
import 'package:amazon_flutter/view/login_view/main_login_page.dart';
import 'package:amazon_flutter/view/master.dart';
import 'package:amazon_flutter/view/product/product_detail_view.dart';
import 'package:amazon_flutter/view/search/searchView.dart';
import 'package:amazon_flutter/viewmodel/bottom_navigation_notifier.dart';
import 'package:amazon_flutter/viewmodel/product_notifier.dart';
import 'package:amazon_flutter/viewmodel/user_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

final GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  getIt.registerSingleton<AuthenticationService>(AuthenticationService(),signalsReady: true);
  getIt.registerSingleton<FirebaseService>(FirebaseService(),signalsReady: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModel>(
            create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider.value(value: BottomNavViewModel())
      ],
      child: MaterialApp(
        title: "Amazon in Flutter",
        themeMode: ThemeMode.light,
        theme: MyTheme.lightTheme(context),
        initialRoute: "/",
        routes: {
          "/": (context) => const MasterPage(),
          MyRoutes.masterRoute: (context) => const MasterPage(),
          MyRoutes.loginOptionRoute: (context) => const LoginOptionPage(),
          MyRoutes.loginRoute: (context) => const MainLoginPage(
                panel: loginRadio.signIn,
              ),
          MyRoutes.signUpRoute: (context) => const MainLoginPage(
                panel: loginRadio.signUp,
              ),
          MyRoutes.passLoginRoute: (context) => const PasswordLoginPage(),
          MyRoutes.otpLoginRoute: (context) => const OtpLoginPage(),
          MyRoutes.searchRoute: (context) => const SearchPage(),
          MyRoutes.productDetails: (context) => const ProductDetails(),
        },
      ),
    ); // );
  }
}
