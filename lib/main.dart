import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_hmc/firebase/firebase_auth.dart';
import 'package:project_hmc/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuthentication.initFirebaseAuth();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
      title: 'MessageAir',
    );
  }
}
