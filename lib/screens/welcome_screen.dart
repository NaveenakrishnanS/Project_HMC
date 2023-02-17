// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:project_hmc/screens/Login.dart';
=======
import 'package:project_hmc/screens/Login_screen.dart';
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
            Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 0)),
            ElevatedButton(onPressed: (){

            },
                child: Text(
                  'Login',
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10) ),
                )
                ),
=======
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 100, 100, 0),
              child: ElevatedButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen())
                );
              },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)
                        )
                    )
                ),
                  child: Text('Login'),
              ),
>>>>>>> Stashed changes
            ),
        ],
      ),
    ),
    );
  }
}
