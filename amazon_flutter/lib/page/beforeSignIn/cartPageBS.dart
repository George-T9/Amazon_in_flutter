import 'package:amazon_flutter/util/routes.dart';
import 'package:flutter/material.dart';

class CartPageBS extends StatelessWidget {
  const CartPageBS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(110.0),
            child: Image.asset(
              'assets/images/empty cart.png',
              fit: BoxFit.scaleDown,
              height: 220,
              width: 220,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Your Amazon Basket is empty",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Shop today's deal"),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.loginRoute);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text("Sign in your account"),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.signUpRoute);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text("Sign up now"),
                  )),
              const Divider(),
              const Divider(),
              ElevatedButton(
                  onPressed: () {}, child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text("Continue shopping"),
                  )),
            ],
          ),
        ),
      ],
    ));
  }
}
