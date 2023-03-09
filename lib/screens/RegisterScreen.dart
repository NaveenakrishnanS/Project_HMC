import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 270, 0, 0)),
            const Text(
              'MessageAir',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 38,
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 0)),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward_rounded),
              iconSize: 50,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                'Next',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onPressed() {}
}
