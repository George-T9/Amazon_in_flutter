import 'package:amazon_flutter/viewmodel/user_notifier.dart';
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
                    Consumer<UserViewModel>(builder: (BuildContext context, userState, Widget? child) => Text("${userState.email}"),),
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
              Consumer<UserViewModel>(builder:(context,userState,_){
                if(userState.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }else{
                  if(userState.currentUser == null){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(onPressed: () {
                        userState.signIn("${userState.email}", passwordController.text,
                                // (e) => showErrorDialog(context, e)
                        );
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
