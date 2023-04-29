import 'package:flutter/material.dart';
import 'package:project_hmc/firebase/cloud_database.dart';
import 'package:project_hmc/models/user_model.dart';
import 'package:project_hmc/screens/Friend_list/Widgets/friend_card.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class Chat {
  final String name, uID;

  Chat({required this.name, required this.uID});
}

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  FriendListState createState() => FriendListState();
}

class FriendListState extends State<FriendList> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
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
                          Icons.groups,
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
              actions: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 12.5),
                  child: SearchBarAnimation(
                    enteredTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                    textEditingController:
                        TextEditingController(text: searchText),
                    buttonBorderColour: Colors.black,
                    buttonColour: Colors.black,
                    searchBoxColour: Colors.black,
                    cursorColour: Colors.white,
                    enableBoxBorder: false,
                    enableBoxShadow: false,
                    enableButtonBorder: false,
                    enableButtonShadow: false,
                    buttonElevation: 0,
                    durationInMilliSeconds: 160,
                    isSearchBoxOnRightSide: true,
                    isOriginalAnimation: true,
                    enableKeyboardFocus: true,
                    onFieldSubmitted: (query) {
                      setState(() {
                        searchText = query;
                      });
                    },
                    secondaryButtonWidget: GestureDetector(
                      onTap: () {
                        setState(() {
                          searchText = '';
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    trailingWidget: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.white,
                    ),
                    buttonWidget: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ])),
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
                if (name.toLowerCase().contains(searchText.toLowerCase())) {
                  FriendCard friendCard = FriendCard(name: name, uID: uID);
                  friendCards.add(friendCard);
                }
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
