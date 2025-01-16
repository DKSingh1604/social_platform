import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_platform/app.dart';
import 'package:social_platform/config/firebase_options.dart';

void main() async {
  //firebas setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //run app
  runApp(MyApp());
}
