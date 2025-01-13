import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_platform/features/auth/presentation/pages/login_page.dart';
import 'package:social_platform/firebase_options.dart';
import 'package:social_platform/themes/light_mode.dart';

void main() async {
  //firebas setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: const LoginPage(),
    );
  }
}
