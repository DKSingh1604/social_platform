// LOGIN PAGE

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_platform/features/auth/presentation/components/my_button.dart';
import 'package:social_platform/features/auth/presentation/components/my_textfield.dart';
import 'package:social_platform/features/auth/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({
    super.key,
    required this.togglePages,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  //login button pressed
  void login() {
    //prepare email and pw
    final String email = emailController.text.trim();
    final String pw = pwController.text.trim();

    //auth Cubit
    final authCubit = context.read<AuthCubit>();

    //ensure that email and pass are not empty
    if (email.isNotEmpty && pw.isNotEmpty) {
      //login!!

      authCubit.login(email, pw);
    }
    //display error if some fields are empty
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //LOGO
              Icon(
                Icons.lock_open_rounded,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),

              SizedBox(height: 20),

              //LOGIN MESSAGE
              Text(
                "LOGIN",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 20),

              //email textfield
              MyTextfield(
                controller: emailController,
                label: "Email",
                obscureText: false,
                hintText: "",
              ),

              SizedBox(height: 15),

              //password textfield
              MyTextfield(
                controller: pwController,
                label: "Password",
                obscureText: true,
                hintText: "",
              ),

              SizedBox(height: 20),

              // login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: MyButton(
                  onTap: login,
                  text: "LOGIN",
                ),
              ),
              //not a memmber, register here

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Not a member?"),
                    TextButton(
                      onPressed: widget.togglePages,
                      child: Text(
                        "Register here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
