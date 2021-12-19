import 'package:amazon_flutter/util/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Amazon.in"),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                "Sign in for best experience",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Sign in"),
              ),
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.loginOptionRoute);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Create account"),
              ),
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.signUpRoute);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Image.asset(
                    "assets/images/delivery-box.png",
                    fit: BoxFit.cover,
                    width: 80,
                  ),
                ),
                Flexible(
                    child: Text(
                  "Check order status and track, change or return items",
                  style: Theme.of(context).textTheme.headline6,
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Image.asset(
                    "assets/images/sale.png",
                    fit: BoxFit.cover,
                    width: 80,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Shop past purchases and everyday essentials",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Image.asset(
                    "assets/images/invoice.png",
                    fit: BoxFit.cover,
                    width: 80,
                  ),
                ),
                Flexible(
                    child: Text(
                  "Create lists with items you want, now or later",
                  style: Theme.of(context).textTheme.headline6,
                ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
