import 'package:amazon_flutter/enum/enum_states.dart';
import 'package:amazon_flutter/page/loginPages/main_login_page.dart';
import 'package:amazon_flutter/util/applicationState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordLoginPage extends StatelessWidget {
  const PasswordLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Sign-In",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  children: [
                    Consumer<ApplicationState>(builder: (BuildContext context, appState, Widget? child) => Text("${appState.email}"),),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("change"))
                  ],
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Amazon Password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cant be empty";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Checkbox(value: true, onChanged: null),
                    const Text("Show password"),
                    const Spacer(),
                    TextButton(
                        onPressed: () {}, child: const Text("Forgot password?"))
                  ],
                ),
              ),
              Consumer<ApplicationState>(builder:(context,appState,_){
                if(appState.connectionState == ConnectionStates.busy){
                  return const Center(child: CircularProgressIndicator(),);
                }else{
                  if(appState.loginState == ApplicationLoginState.loggedOut){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(onPressed: () {
                        appState.signInWithEmailAndPassword("${appState.email}", passwordController.text, (e) => showErrorDialog(context, e));
                      }, child: const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Text("Sign-In"),
                      )),
                    );
                  }else{
                    return const SizedBox.shrink();
                  }
                }
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  children: const [
                    Expanded(child: Divider()),
                    Text("or"),
                    Expanded(child: Divider()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text("Get an OTP on your phone"),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Message and Data rates may apply"),
              ),
              const SizedBox(
                height: 20,
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
