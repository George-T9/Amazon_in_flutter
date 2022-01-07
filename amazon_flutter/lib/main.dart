import 'package:amazon_flutter/firebase_options.dart';
import 'package:amazon_flutter/page/product_details.dart';
import 'package:amazon_flutter/page/searchPage.dart';
import 'package:amazon_flutter/util/applicationState.dart';
import 'package:amazon_flutter/page/loginPages/loginOtpPage.dart';
import 'package:amazon_flutter/page/loginPages/loginPasswordPage.dart';
import 'package:amazon_flutter/page/loginPages/login_option_page.dart';
import 'package:amazon_flutter/page/loginPages/main_login_page.dart';
import 'package:amazon_flutter/page/master.dart';
import 'package:amazon_flutter/util/routes.dart';
import 'package:amazon_flutter/widget/extraWidget.dart';
import 'package:amazon_flutter/widget/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApplicationState>(
            create: (_) => ApplicationState()),
        ChangeNotifierProvider.value(value: BottomNavigationProvider()),
        ChangeNotifierProvider.value(value: SearchProvider())
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
          MyRoutes.productDetails: (context) => ProductDetails(),

        },
      ),
    ); // );
  }
}
