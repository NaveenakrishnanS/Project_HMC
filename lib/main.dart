import 'package:flutter/material.dart';
import 'package:project_hmc/screens/single_chat.dart';
import 'package:project_hmc/screens/welcome_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingleChat(),
      title: 'MessageAir',
    );
  }
}
