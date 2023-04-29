import 'package:flutter/material.dart';

class InputMessage extends StatefulWidget {
  const InputMessage({Key? key, required this.text, required this.messageTime})
      : super(key: key);
  final String text, messageTime;

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          color: const Color.fromRGBO(24, 41, 82, 10),
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 30, bottom: 20),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 3,
                child: Row(
                  children: [
                    Text(
                      widget.messageTime,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(size: 17, color: Colors.blue, Icons.done_all),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
