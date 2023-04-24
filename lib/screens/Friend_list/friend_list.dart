import 'package:flutter/material.dart';
import 'package:project_hmc/firebase/cloud_database.dart';
import 'package:project_hmc/models/user_model.dart';
import 'package:project_hmc/screens/Friend_list/Widgets/friend_card.dart';

class Chat {
  final String name,uID;

  Chat({
    required this.name,
    required this.uID
  });
}

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  FriendListState createState() => FriendListState();
}

class FriendListState extends State<FriendList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          leadingWidth: 200,
          elevation: 0,
          backgroundColor: Colors.black,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  children: const [
                    Icon(
                      Icons.groups_2_sharp,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        'Buddies',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: StreamBuilder<List<UserModel>>(
          stream: CloudDatabase().retrieveUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 5,
                ),
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
                String uID = users.UID;
                FriendCard friendCard = FriendCard(name: name, uID: uID);
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
