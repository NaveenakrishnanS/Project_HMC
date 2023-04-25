
import 'package:flutter/material.dart';
import 'package:project_hmc/firebase/auth/firebase_auth.dart';
import 'package:project_hmc/screens/message_card/receive_card.dart';
import 'package:project_hmc/screens/message_card/send_card.dart';

import '../firebase/cloud_database.dart';
import '../models/chat_model.dart';

class SingleChat extends StatefulWidget {
  const SingleChat({Key? key, required this.name, required this.uID})
      : super(key: key);
  final String name, uID;

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late String chatID ="";

  @override
  void initState() {
    super.initState();
    chatID = CloudDatabase().createChatRoom(userId1: FirebaseAuthentication.getUserUid,userId2: widget.uID);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              automaticallyImplyLeading: true,
              leadingWidth: 350,
              elevation: 0,
              backgroundColor: Colors.black,
              leading: Align(
                child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset('assets/user.png'),
                        ),
                        // const Icon(
                        //   Icons.person,
                        //   color: Colors.amber,
                        //   weight: Checkbox.width,
                        //   size: 40,
                        // ),
                        const SizedBox(
                          width: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  decoration: const BoxDecoration(color: Colors.white),

                  child: StreamBuilder<List<ChatModel>>(
                      stream: CloudDatabase().retrieveMessages(chatID: chatID),
                      builder: (context, snapshot){
                        // if (snapshot.connectionState == ConnectionState.waiting) {
                        //   return const Center(
                        //     child: CircularProgressIndicator(
                        //       valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        //       strokeWidth: 5,
                        //     ),
                        //   );
                        // }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text('No data available'));
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error in retrieving Users'),
                          );
                        }
                        if(snapshot.hasData){
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 20),
                              curve: Curves.easeOut,
                            );
                          });
                        }
                        List<ChatModel> messages = snapshot.data!;
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 20),
                                curve: Curves.easeOut,
                              );
                            });
                            ChatModel message = messages[index];
                            bool isSentByMe = (message.senderId == FirebaseAuthentication.getUserUid);
                            return isSentByMe
                                ? InputMessage(text: message.message!,messageTime: message.timestamp.toString().split('T')[0].split(' ')[1].substring(0,5))
                                : ReplyMessage(text: message.message!,messageTime: message.timestamp.toString().split('T')[0].split(' ')[1].substring(0,5));
                          },
                        );
                      }
                  ),

                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    hintText: 'Type your message...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if(_controller.text !=""){
                              final dt = DateTime.now();
                              ChatModel chatData = ChatModel(
                                  senderId: FirebaseAuthentication.getUserUid,
                                  receiverId: widget.uID,
                                  message: _controller.text,
                                  timestamp: dt
                              );
                              CloudDatabase().sendMessage(
                                  chatData: chatData,
                                  chatID: CloudDatabase().createChatRoom(
                                      userId1: FirebaseAuthentication.getUserUid,
                                      userId2: widget.uID)
                              );
                              _controller.clear();
                              FocusScope.of(context).unfocus();
                            }
                          },
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}
