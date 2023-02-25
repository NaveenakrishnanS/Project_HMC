// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:project_hmc/screens/login_screen.dart';
import 'package:project_hmc/screens/sign_up_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            Text(
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 38
                ),
                'MessageAir'
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 80, 100, 0),
              child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen())
                  );
                },
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder()
                  ),
                  child: Text('Login',
                  style: TextStyle(
                    fontSize: 20
                  ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 30, 100, 0),
              child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen())
                  );
                },
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder()
                  ),
                    child: Text('Signup',
                    style: TextStyle(
                      fontSize: 20
                    ),
                    ),
                ),
              ),
            ),
        ],
      ),
    ),
    );
  }
}
