import 'package:flutter/material.dart';
//import 'package:hygiene_app/firebase/database/cloud_database.dart';
import 'package:project_hmc/screens/Friend_list/Widgets/friend_card.dart';

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
  final List<Friend> vendorList = [
    Friend(
      name: 'Vendor 1'
    ),
    Friend(
      name: 'Vendor 2'
    ),
    Friend(
      name: 'Vendor 3'
    ),
    Friend(
      name: 'Vendor 4'
    ),
    Friend(
      name: 'Vendor 5'
    ),
    Friend(
      name: 'Vendor 6'
    ),
    Friend(
      name: 'Vendor 7'
    ),
    Friend(
      name: 'Vendor 8'
    ),
    Friend(
      name: 'Vendor 9'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor List'),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: vendorList.length,
          itemBuilder: (context, index) {
            return FriendCard(
                name: vendorList[index].name);
          },
        ),
      ),
    );
  }
}
