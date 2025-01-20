// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_platform/features/auth/data/firebase_auth_repo.dart';
import 'package:social_platform/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_platform/features/auth/presentation/cubits/auth_states.dart';
import 'package:social_platform/features/auth/presentation/pages/auth_page.dart';
import 'package:social_platform/features/home/presentation/pages/home_page.dart';
import 'package:social_platform/features/profile/data/firebase_profile_repo.dart';
import 'package:social_platform/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:social_platform/themes/dark_mode.dart';

/*ROOT LEVEL OF OUR APP

Reposotories: for the database
        - firebase

BLoC Provider: for the state management
        - Auth
        - profile
        - post
        - search
        - theme
      
Check Auth State
        - unauthenticated -> (login/register page)
        - authenticated -> home page

*/

class MyApp extends StatelessWidget {
  //auth repo
  final authRepo = FirebaseAuthRepo();

  //profile repo
  final profileRepo = FirebaseProfileRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //provide cubit to app
    return BlocProvider(
        create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        child: MultiBlocProvider(
          providers: [
            //auth cubit
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
            ),

            //profile cubit
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(profileRepo),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: darkMode,
            home: BlocConsumer<AuthCubit, AuthState>(
              builder: (context, authState) {
                print(authState);

                //unauthenticated -> login/register page (Auth Page)
                if (authState is Unauthenticated) {
                  return const AuthPage();
                }
                //authenticated -> home page
                else if (authState is Authenticated) {
                  return const HomePage();
                }
                //loading...
                else {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
              //listen for errors...
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}
