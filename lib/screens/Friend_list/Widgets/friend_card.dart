import 'package:flutter/material.dart';

class FriendCard extends StatelessWidget {
  final String name;

  const FriendCard({
    super.key,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      shadowColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Container(
        height: 116,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: /*Container(
            padding: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
            child: Image.asset(
              'assets/user.jpg',
            ),
          ),
          */
          CircleAvatar(
            radius: 40, // Adjust this to change the size of the CircleAvatar
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.only(left: 1),
              child: Image.asset(
                'assets/user.jpg',
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
