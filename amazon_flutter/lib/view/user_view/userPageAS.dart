import 'package:amazon_flutter/view/user_view/userPageBS.dart';
import 'package:amazon_flutter/view/search/searchView.dart';
import 'package:amazon_flutter/viewmodel/bottom_navigation_notifier.dart';
import 'package:amazon_flutter/viewmodel/user_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userVm = Provider.of<UserViewModel>(context);
    return userVm.currentUser != null ? const UserPageAS() : const UserPageBS();
  }
}


class UserPageAS extends StatelessWidget {
  const UserPageAS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _applicationState = Provider.of<UserViewModel>(context);
    User? _user = _applicationState.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amazon.in"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined)),
          IconButton(
              onPressed: () {
                const SearchPage();
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(children: [
                Text(
                  "Hello, ${_user?.displayName}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle1,
                ),
                const Spacer(),
                const CircleAvatar(
                  child: Icon(Icons.person),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Your Orders")),
                      )),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Buy Again")),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Your Account")),
                      )),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Buy Wish List")),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Your Order",
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
              child: Text("Hi! you have no recent orders"),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                  onPressed: () {
                    var provider = Provider.of<BottomNavViewModel>(
                        context,
                        listen: false);
                    provider.currentIndex = 0;
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text("Return to Homepage"),
                  )),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Keep shopping for"),
                        const Spacer(),
                        TextButton(onPressed: () {}, child: const Text("Edit")),
                        Container(
                          width: 1,
                          height: 18,
                          color: Colors.black,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Browsing history")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

