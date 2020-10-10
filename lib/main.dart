import 'package:flutter/material.dart';
import 'package:smarttourism/states/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smarttourism/states/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      home: LogIn(),
    );
  }
}

