import 'package:flutter/material.dart';

import '../../../firebase/auth/firebase_auth.dart';
import '../../../firebase/cloud_database.dart';
import '../../../firebase/flutter_secure_storage/secure_storage.dart';
import '../../OneToOne_Chat/one_to_one_chat.dart';

class ChatCard extends StatelessWidget {
  final String name, uID;

  const ChatCard({super.key, required this.name, required this.uID});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      shadowColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        height: 75,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
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
                'assets/user.png',
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
          onTap: () async {
            final id1 = FirebaseAuthentication.getUserUid;
            final id2 = uID;
            final chatID =
                CloudDatabase().createChatRoom(userId1: id1, userId2: id2);
            CloudDatabase().addIDsToChats(Id1: id1, Id2: id2, chatID: chatID);
            String? privateKey = await FSS().getData("RSAPrivateKey");
            String pk = privateKey ?? "";
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    SingleChat(name: name, uID: id2, privatekey: pk),
              ),
            );
          },
        ),
      ),
    );
  }
}
