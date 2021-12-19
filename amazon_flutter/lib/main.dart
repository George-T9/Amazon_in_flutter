
import 'package:amazon_flutter/firebase_options.dart';
import 'package:amazon_flutter/util/applicationState.dart';
import 'package:amazon_flutter/page/loginPages/loginOtpPage.dart';
import 'package:amazon_flutter/page/loginPages/loginPasswordPage.dart';
import 'package:amazon_flutter/page/loginPages/login_option_page.dart';
import 'package:amazon_flutter/page/loginPages/main_login_page.dart';
import 'package:amazon_flutter/page/master.dart';
import 'package:amazon_flutter/util/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Amazon in Flutter",
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
      },
    );
    // );
  }
}
