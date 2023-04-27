import 'package:flutter/material.dart';
import 'package:project_hmc/firebase/auth/firebase_auth.dart';
import 'package:project_hmc/firebase/decryptor.dart';
import 'package:project_hmc/firebase/encryptor.dart';
import 'package:project_hmc/screens/message_card/receive_card.dart';
import 'package:project_hmc/screens/message_card/send_card.dart';

import '../firebase/cloud_database.dart';
import '../firebase/key_managers/aes_key_manager.dart';
import '../models/chat_model.dart';

class SingleChat extends StatefulWidget {
  const SingleChat(
      {Key? key,
      required this.name,
      required this.uID,
      required this.privatekey})
      : super(key: key);
  final String name, uID;
  final String privatekey;

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late String chatID = "";

  @override
  void initState() {
    super.initState();
    chatID = CloudDatabase().createChatRoom(
        userId1: FirebaseAuthentication.getUserUid, userId2: widget.uID);
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
                  child: StreamBuilder<List<List<ChatModel>>>(
                      stream: CloudDatabase().messages(CloudDatabase().createChatRoom(userId1: FirebaseAuthentication.getUserUid, userId2: widget.uID),
                          FirebaseAuthentication.getUserUid, widget.uID),
                      // CloudDatabase().retrieveAllMessages(chatID: chatID),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null|| snapshot.data!.isEmpty) {
                          return const Center(child: Text('No data available'));
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error in retrieving Messages'),
                          );
                        }
                        List<ChatModel> messages = [];
                        List<ChatModel> sents = [];
                          sents = snapshot.data![0];
                          messages = snapshot.data![1];
                          if(sents.isEmpty && messages.isEmpty){
                            return const Center(
                                child: Text('Start Sending Messages'));
                          }
                        for (ChatModel message in sents) {
                          for (int i = 0; i < messages.length; i++) {
                            bool isSentByMe = (message.senderId ==
                                FirebaseAuthentication.getUserUid);
                            if ((messages[i].timestamp == message.timestamp) && isSentByMe){
                              messages[i] = message;
                              break;
                            }
                          }
                        }
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            ChatModel message = messages[index];
                            // ChatModel sent = sents[index];
                            bool isSentByMe = (message.senderId ==
                                FirebaseAuthentication.getUserUid);
                            return isSentByMe
                                ? InputMessage(
                                    text: message.message!,
                                    messageTime: message.timestamp
                                        .toString()
                                        .split('T')[0]
                                        .split(' ')[1]
                                        .substring(0, 5))
                                : ReplyMessage(
                                    text: (decryption(message)).toString(),
                                    messageTime: message.timestamp
                                        .toString()
                                        .split('T')[0]
                                        .split(' ')[1]
                                        .substring(0, 5));
                          },
                        );
                      }),
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
                          onPressed: () async {
                            if (_controller.text != "") {
                              final dt = DateTime.now();
                              String mId = CloudDatabase().createMessageID();
                              String text = (_controller.text).toString();
                              sendingMessage(text,mId, dt);
                              backingUpSent(text,mId, dt);
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

  String decryption(ChatModel message) {
    String encryptedText = message.message!;
    String encryptedAesKey = message.aesKey!;
    String nonce = message.nonce!;
    String? rsaprivatekey = widget.privatekey;
    String rsaprk = (rsaprivatekey).toString();
    String decryptedText = Decryptor().hmcDecryptor(
        encryptedText: encryptedText,
        nonce: nonce,
        encryptedAesKey: encryptedAesKey,
        rsaPrivateKey: rsaprk);
    return decryptedText.toString();
  }

  void sendingMessage(String content, String mID, DateTime dt) async {
    String aeskey = AESKeyManager().aesKey();
    String nonce =
        Encryptor().base64Encoding(Encryptor().generateRandomNonce());
    String? rsapublickey =
        await (CloudDatabase().getUserPublicKey(Id: widget.uID));
    String rsapuk = (rsapublickey ?? "").toString();
    String encryptedAesKey =
        Encryptor().hmcAesKeyEncryptor(aesKey: aeskey, rsaPublicKey: rsapuk);
    String encryptedMsg = Encryptor().hmcMessageEncryptor(
        message: content,
        aesKey: aeskey,
        nonce: nonce,
        rsaPublicKey: rsapuk);
    ChatModel chatData = ChatModel(
        senderId: FirebaseAuthentication.getUserUid,
        receiverId: widget.uID,
        message: encryptedMsg,
        nonce: nonce,
        aesKey: encryptedAesKey,
        timestamp: dt);
    CloudDatabase().sendMessage(
        chatData: chatData,
        chatID: CloudDatabase().createChatRoom(
            userId1: FirebaseAuthentication.getUserUid, userId2: widget.uID),
        messageID: mID);
  }

  void backingUpSent(String content, String mID, DateTime dt) {
    ChatModel chatData = ChatModel(
        senderId: FirebaseAuthentication.getUserUid,
        receiverId: widget.uID,
        message: content,
        nonce: '',
        aesKey: '',
        timestamp: dt);
    CloudDatabase().backupSentMessage(
        UID: FirebaseAuthentication.getUserUid,
        chatID: CloudDatabase().createChatRoom(
            userId1: FirebaseAuthentication.getUserUid, userId2: widget.uID),
        chatData: chatData,
        messageID: mID);
  }
}
