// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:project_hmc/screens/Login.dart';

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
            Padding(padding: EdgeInsets.fromLTRB(0, 270, 0, 0)),
            Text(
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 38
                ),
                'MessageAir'
            ),
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
            ),
           Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 20
           ),
                'Next')
        )
        ],
      ),
    ),
    );
  }
}
