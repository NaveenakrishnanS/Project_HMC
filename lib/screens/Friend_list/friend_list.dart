import 'package:flutter/material.dart';
import 'package:project_hmc/firebase/auth/firebase_authentication.dart';
import 'package:project_hmc/screens/Friend_list/Widgets/friend_card.dart';
import 'package:project_hmc/firebase/cloud_database.dart';
import 'package:project_hmc/models/user_model.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Colors.black,
          title: const Padding(
            padding: EdgeInsets.only(top: 15,left: 10),
            child: Text('friend List'),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child:StreamBuilder<List<UserModel>>(
              stream: CloudDatabase().retrieveUsers(),
              builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),strokeWidth: 5,),
                );
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No data available'));
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error in retrieving Users'),
                );
              }
              List<FriendCard> friendCards = [];
              if (snapshot.hasData) {
                for (var users in snapshot.data!) {
                  String name = users.Name;
                    FriendCard friendCard = FriendCard(name: name);
                    friendCards.add(friendCard);
                }
                return ListView(
                  children: friendCards,
                );
              }
              return ListView(
                children: friendCards,
              );
              },
        ),
      ),
    );
  }
}
