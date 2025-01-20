// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_platform/features/auth/presentation/components/my_button.dart';
import 'package:social_platform/features/auth/presentation/components/my_textfield.dart';
import 'package:social_platform/features/auth/presentation/cubits/auth_cubit.dart';

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

  //register function
  void register() {
    //prepare info
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;

    //auth Cubit
    final authCubit = context.read<AuthCubit>();

    //ensure the fileds are not empty
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      //ensure that the passwords match
      if (pw == confirmPw) {
        authCubit.register(name, email, pw);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Passwords don't match"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all the fields"),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    super.dispose();
  }

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
                  hintText: "",
                ),

                SizedBox(height: 5),

                //email textfield
                MyTextfield(
                  controller: emailController,
                  label: "Email",
                  obscureText: false,
                  hintText: "",
                ),

                SizedBox(height: 5),

                //password textfield
                MyTextfield(
                  controller: pwController,
                  label: "Password",
                  obscureText: true,
                  hintText: "",
                ),

                SizedBox(height: 5),

                //Confirm password textfield
                MyTextfield(
                  controller: confirmPwController,
                  label: "Confirm Password",
                  obscureText: true,
                  hintText: "",
                ),

                SizedBox(height: 20),

                // Register button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MyButton(
                    onTap: register,
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
