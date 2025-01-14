// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_platform/features/auth/presentation/components/my_button.dart';
import 'package:social_platform/features/auth/presentation/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({
    super.key,
    required this.togglePages,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: FlutterLogin(
      //   onLogin: (p0) {},
      //   onSignup: (p0) {},
      //   onRecoverPassword: (p0) {},
      // ),

      body: SingleChildScrollView(
        child: SafeArea(
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

                //REGISTER MESSAGE
                Text(
                  "REGISTER",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 20),

                //Name textfield
                MyTextfield(
                  controller: nameController,
                  label: "Name",
                  obscureText: false,
                ),

                SizedBox(height: 5),

                //email textfield
                MyTextfield(
                  controller: emailController,
                  label: "Email",
                  obscureText: false,
                ),

                SizedBox(height: 5),

                //password textfield
                MyTextfield(
                  controller: pwController,
                  label: "Password",
                  obscureText: true,
                ),

                SizedBox(height: 5),

                //Confirm password textfield
                MyTextfield(
                  controller: confirmPwController,
                  label: "Confirm Password",
                  obscureText: true,
                ),

                SizedBox(height: 20),

                // Register button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MyButton(
                    onTap: () {},
                    text: "REGISTER",
                  ),
                ),

                //Already a member, login here
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already a member?"),
                      TextButton(
                        onPressed: widget.togglePages,
                        child: Text(
                          "Login here",
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
      ),
    );
  }
}
