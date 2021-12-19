import 'package:amazon_flutter/util/routes.dart';
import 'package:flutter/material.dart';

class LoginOptionPage extends StatelessWidget {

  const LoginOptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const LoginOption(),
    );
  }
}

class LoginOption extends StatelessWidget {

  const LoginOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 70,
              child: Image.asset("assets/images/amazon_logo.png",
                  fit: BoxFit.contain),
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Sign in to your account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('View your wish list',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text('Find & order past purchases',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text('Track your purchases',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.loginRoute);
                },
                child: const Text('Already a customer? Sign in')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.signUpRoute);
                },
                child: const Text('New to Amazon.in? Create a new account')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Skip Sign in'))
          ],
        ),
      ),
    );
  }
}
