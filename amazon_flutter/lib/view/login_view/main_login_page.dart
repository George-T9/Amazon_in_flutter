import 'package:amazon_flutter/util/routes.dart';
import 'package:amazon_flutter/viewmodel/user_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum loginRadio { signIn, signUp }

class MainLoginPage extends StatelessWidget {
  const MainLoginPage({Key? key, required this.panel}) : super(key: key);

  final loginRadio panel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              ExpansionList(
                openPanel: panel,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text("Condition of use")),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Privacy Notice")),
                    ElevatedButton(onPressed: () {}, child: const Text("Help"))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("@ 1996-2021,Amazon.com,Inc. or its affiliates"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpansionList extends StatelessWidget {
  final loginRadio openPanel;

  const ExpansionList({Key? key, required this.openPanel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: const EdgeInsets.all(0),
      initialOpenPanelValue: openPanel,
      children: [
        ExpansionPanelRadio(
          canTapOnHeader: true,
          value: loginRadio.signUp,
          headerBuilder: (context, _) {
            return const ListTile(
              title: Text("Create account.New to Amazon?"),
            );
          },
          body: const CreateAccount(),
        ),
        ExpansionPanelRadio(
          canTapOnHeader: true,
          value: loginRadio.signIn,
          headerBuilder: (context, _) {
            return const ListTile(
              title: Text("Sign-in.Already a customer?"),
            );
          },
          body: const SignInEmailForm(),
        )
      ],
    );
  }
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKeySignUp = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController displayNameController = TextEditingController();

    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
            key: _formKeySignUp,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: displayNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Name"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Mobile number"),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email (Optional)"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email or phone number";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Set password"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Consumer<UserViewModel>(
                    builder: (BuildContext context, userState, _) {
                      if (userState.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ElevatedButton(
                            child: const Text("Verify mobile number"),
                            onPressed: () async {
                              if (_formKeySignUp.currentState!.validate()) {
                                userState.registerAccount(
                                    displayNameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    // (e) => showErrorDialog(context, e)
                                );
                                if (userState.currentUser != null) {
                                  Navigator.pop(context);
                                }
                              }
                            });
                      }
                    },
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "By creating an account or logging, you agree to Amazon's Condition of use and Privacy Notice.",
                        style: TextStyle(),
                      ))
                ])));
  }
}

class SignInEmailForm extends StatefulWidget {
  const SignInEmailForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignInEmailFormState createState() => _SignInEmailFormState();
}

class _SignInEmailFormState extends State<SignInEmailForm> {
  @override
  Widget build(BuildContext context) {
    final _formKeySignInEmail = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKeySignInEmail,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email or phone number"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your email or phone number";
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Consumer<UserViewModel>(
                builder: (BuildContext context, userState, _) {
                  if (userState.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ElevatedButton(
                        child: const Text("Continue"),
                        onPressed: () async {
                          if (_formKeySignInEmail.currentState!.validate()) {
                            var verified = await userState.verifyEmail(
                              emailController.text,
                              // (e) {
                              //   showErrorDialog(context, e);
                              // },
                            );
                            if (verified) {
                              Navigator.pushNamed(
                                  context, MyRoutes.passLoginRoute);
                            } else if (!verified) {
                              Navigator.pushReplacementNamed(
                                  context, MyRoutes.signUpRoute);
                            } else {
                              print("error - ${verified.toString()}");
                            }
                          }
                        });
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                    "By continuing,you agree to Amazon's Condition of use and Privacy Notice."),
              )
            ],
          ),
        ));
  }
}

void showErrorDialog(BuildContext context, Exception error) {
  showDialog<void>(
    context: context,
    builder: (context) {
      if(error.runtimeType == FirebaseAuthException){
        FirebaseAuthException e = error as FirebaseAuthException;
        return AlertDialog(
          title: Text(
            e.code.replaceAll("-", ' ').toTitleCase(),
            style: const TextStyle(fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      }
      else if(error.runtimeType == FirebaseException){
        FirebaseException e= error as FirebaseException;
        return AlertDialog(
          title: Text(
            e.code.replaceAll("-", ' ').toTitleCase(),
            style: const TextStyle(fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      }else{
        return SizedBox.shrink();
      }

    },
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
