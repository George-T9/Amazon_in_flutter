import 'package:amazon_flutter/util/theme.dart';
import 'package:amazon_flutter/view/cart_view/cartPageAS.dart';
import 'package:amazon_flutter/view/home_view/home_view.dart';
import 'package:amazon_flutter/view/menu_view/MenuView.dart';
import 'package:amazon_flutter/view/user_view/userPageAS.dart';
import 'package:amazon_flutter/viewmodel/bottom_navigation_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  List widgetOption = const [
    HomeView(),
    UserPage(),
    CartPage(),
    MenuPage(),

  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavViewModel>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.deepPurple),
      child: Scaffold(
        body: widgetOption.elementAt(provider.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: (index) {
            provider.currentIndex = index;
          },
          selectedItemColor: MyTheme.lightTheme(context).backgroundColor,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: "User"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_outlined), label: "Menu"),
          ],
        ),
      ),
    );
  }
}
//
// class UserPage extends StatelessWidget {
//   const UserPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final _applicationState = Provider.of<ApplicationState>(context);
//     return FutureBuilder<User?>(
//       future: _applicationState.getCurrent(),
//       builder: (_, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           final User? user = snapshot.data;
//           return user == null ? const UserPageBS() : const UserPageAS();
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }
//
// class CartPage extends StatelessWidget {
//   const CartPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final _applicationState = Provider.of<ApplicationState>(context);
//     return FutureBuilder<User?>(
//       future: _applicationState.getCurrent(),
//       builder: (_, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           final User? user = snapshot.data;
//           return user == null ? const CartPageBS() : const CartPageAS();
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }
