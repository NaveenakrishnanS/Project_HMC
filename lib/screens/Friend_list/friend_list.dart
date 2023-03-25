import 'package:flutter/material.dart';
//import 'package:hygiene_app/firebase/database/cloud_database.dart';
import 'package:project_hmc/screens/Friend_list/Widgets/friend_card.dart';
import 'package:project_hmc/screens/chat_screen.dart';

class Friend {
  final String name;

  Friend({
    required this.name,
  });
}

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  FriendListState createState() => FriendListState();
}

class FriendListState extends State<FriendList> {
  final List<Friend> friendList = [
    Friend(
      name: 'friend 1'
    ),
    Friend(
      name: 'friend 2'
    ),
    Friend(
      name: 'friend 3'
    ),
    Friend(
      name: 'friend 4'
    ),
    Friend(
      name: 'friend 5'
    ),
    Friend(
      name: 'friend 6'
    ),
    Friend(
      name: 'friend 7'
    ),
    Friend(
      name: 'friend 8'
    ),
    Friend(
      name: 'friend 9'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('friend List'),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: friendList.length,
          itemBuilder: (context, index) {
            return FriendCard(
              name: friendList[index].name);
          },
        ),
      ),
    );
  }
}
