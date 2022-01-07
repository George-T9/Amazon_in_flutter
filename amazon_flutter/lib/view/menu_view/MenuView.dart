import 'package:amazon_flutter/viewmodel/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userVm = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: SafeArea(child: Center(child: ElevatedButton(onPressed: () {
        userVm.signOut();
      }, child: Text("Sign Out"),),),),
    );
  }
}
