import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 100, 200, 10),
              child: Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 60, 0),
              child: TextField(
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  //border: InputBorder.none,
                  border: const OutlineInputBorder(),
                  //label: Text('Phone number'),
                  prefixIcon: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [Text('+1')],
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
