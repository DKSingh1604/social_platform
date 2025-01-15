import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_platform/features/auth/presentation/cubits/auth_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              //logout
              context.read<AuthCubit>().logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        //user's name
        child: Text("Welcome ${context.read<AuthCubit>().currentUser!.uid}"),
      ),
    );
  }
}
