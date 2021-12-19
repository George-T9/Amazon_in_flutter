
import 'package:amazon_flutter/page/botNavPages/cartPage.dart';
import 'package:amazon_flutter/page/botNavPages/homePage.dart';
import 'package:amazon_flutter/page/botNavPages/userPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'botNavPages/menuPage.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int _selectedIndex = 0;

  List widgetOption = const [
    HomePage(),
    UserPage(),
    CartPage(),
    MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black,
      ),
    );
  }

  void _onItemTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
