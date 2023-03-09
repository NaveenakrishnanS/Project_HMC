import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_hmc/screens/chat_screen.dart';
import 'package:project_hmc/screens/welcome_screen.dart';

import '../../firebase/firebase_auth.dart';

class UserStreamScreen extends StatelessWidget {
  const UserStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuthentication.getUserStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const WelcomeScreen();
        },
      ),
    );
  }
}
