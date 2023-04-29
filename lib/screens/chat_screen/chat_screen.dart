import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_hmc/firebase/auth/firebase_auth.dart';
import 'package:project_hmc/screens/chat_screen/chat_card.dart';
import 'package:project_hmc/screens/profile_screen.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../../firebase/cloud_database.dart';
import '../../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  TextEditingController textController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      _animationController.dispose(); // dispose of the AnimationController
      super.dispose();
    }

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
                          Icons.messenger,
                          size: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 28),
                          child: Text(
                            'Chats',
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
          stream: CloudDatabase().retrieveChatUsers(),
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
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('Start Finding Your Buddies'));
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error in retrieving Users'),
              );
            }
            List<ChatCard> chatCards = [];
            if (snapshot.hasData) {
              for (var users in snapshot.data!) {
                String name = users.Name;
                String uID = users.UID;
                // ChatCard chatCard = ChatCard(name: name, uID: uID);
                // chatCards.add(chatCard);
                // Filter chatCards based on searchText
                if (name.toLowerCase().contains(searchText.toLowerCase())) {
                  ChatCard chatCard = ChatCard(name: name, uID: uID);
                  chatCards.add(chatCard);
                }
              }
              return ListView(
                children: chatCards,
              );
            }
            return ListView(
              children: chatCards,
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionBubble(
          animation: _animation,
          onPressed: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
          iconColor: Colors.white,
          iconData: Icons.chat,
          backgroundColor: Colors.black,
          items: <Widget>[
            // Floating action menu item
            BubbleMenu(
              title: "Sign Out",
              iconColor: Colors.white,
              bubbleColor: Colors.black,
              icon: Icons.logout,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              onPressed: () async {
                await FirebaseAuthentication.signOut();
                SystemNavigator.pop(); //closes the app
                dispose();
              },
            ),
            // Floating action menu item
            BubbleMenu(
              title: "Profile",
              iconColor: Colors.white,
              bubbleColor: Colors.black,
              icon: Icons.people,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Profile(),
                  ),
                );
                _animationController.reverse();
              },
            ),
            //Floating action menu item
            BubbleMenu(
              title: "Home",
              iconColor: Colors.white,
              bubbleColor: Colors.black,
              icon: Icons.home,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              onPressed: () {
                _animationController.reverse();
              },
            ),
          ],
        ),
      ),
    );
  }
}
