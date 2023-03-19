import 'package:flutter/material.dart';
class WidgetHandler{

  void showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        message,
        style: const TextStyle(fontSize: 14),),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
          textColor: Colors.white,
        ),
      ),
    );
  }

}
