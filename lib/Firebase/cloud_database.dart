// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_hmc/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

import '../models/chat_model.dart';
import 'auth/firebase_auth.dart';
import 'firebase_messaging.dart';

class CloudDatabase {
  late FirebaseFirestore _firestore;

  CloudDatabase() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> addUserDetails({required UserModel userdata}) async {
    final String dataPath = "Users/${userdata.UID}/Details/Details/";

    try {
      final DocumentReference<Map<String, dynamic>> docRef =
          _firestore.doc(dataPath);
      await docRef.set(userdata.toMap());
    } on FirebaseException {
      rethrow;
    }
  }

  Stream<List<UserModel>> retrieveUsers() {
    const String usersPath = "Users/";

    final collectionReference = _firestore.collection(usersPath);
    final stream = collectionReference
        .where(FieldPath.documentId,
            isNotEqualTo: FirebaseAuthentication.getUserUid)
        .snapshots();

    return stream.asyncMap((collectionsQuery) async {
      final users = <UserModel>[];

      for (var document in collectionsQuery.docs) {
        UserModel? user = await retrieveUserDetails(UID: document.id);
        users.add(user);
      }
      return users;
    });
  }

  Stream<List<UserModel>> retrieveChatUsers() {
    const String usersPath = "Users/";

    final collectionReference = _firestore.collection(usersPath);
    final stream = collectionReference
        .where(FieldPath.documentId,
            isNotEqualTo: FirebaseAuthentication.getUserUid)
        .snapshots();

    return stream.asyncMap((collectionsQuery) async {
      final users = <UserModel>[];

      for (var document in collectionsQuery.docs) {
        UserModel? user = await retrieveUserDetails(UID: document.id);

        // Check if the current user has chatted with the retrieved user
        String chatID = createChatRoom(
            userId1: FirebaseAuthentication.getUserUid, userId2: user.UID);
        QuerySnapshot<Map<String, dynamic>> chatSnapshot =
            await _firestore.collection("Chats/$chatID/Messages").get();
        if (chatSnapshot.docs.isNotEmpty) {
          users.add(user);
        }
      }
      return users;
    });
  }

  Future<UserModel> retrieveUserDetails({required String UID}) async {
    final String dataPath = "Users/$UID/Details/Details/";

    final DocumentReference documentReference = _firestore.doc(dataPath);
    final DocumentSnapshot orderDocumentSnapshot =
        await documentReference.get();

    UserModel userModel =
        UserModel.fromMap(orderDocumentSnapshot.data() as Map<String, dynamic>);

    return userModel;
  }

  Future<bool> hasAlreadyRegistered({required String UID}) async {
    final String dataPath = "Users/$UID/Details/Details/";
    try {
      final CollectionReference collectionReference =
          _firestore.collection(dataPath);
      final QuerySnapshot collectionsQuery = await collectionReference.get();
      if (collectionsQuery.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addPublicKey(
      {required String PublicKey, required String UID}) async {
    final String dataPath = "Users/$UID/";
    try {
      final DocumentReference<Map<String, dynamic>> docRef =
          _firestore.doc(dataPath);
      await docRef.set({"PublicKey": PublicKey});
    } on FirebaseException {
      rethrow;
    }
    await Messaging().getFirebaseMessagingToken();
  }

  Future<void> backupPrivateKey(
      {required String PrivateKey, required String UID}) async {
    final String dataPath = "Users/$UID/Details/PrivateKey/";

    try {
      final DocumentReference<Map<String, dynamic>> docRef =
          _firestore.doc(dataPath);
      await docRef.set({"PrivateKey": PrivateKey});
    } on FirebaseException {
      rethrow;
    }
  }

  String createChatRoom({required String userId1, required String userId2}) {
    List<String> sortedIds = [userId1, userId2]..sort();
    String chatID = "${sortedIds[0]}_${sortedIds[1]}";
    return chatID;
  }

  String createMessageID() {
    // Get the current datetime
    final now = DateTime.now();
// Format the datetime as a string in the desired format
    final formattedDateTime = "${now.day.toString().padLeft(2, '0')}"
        "${now.month.toString().padLeft(2, '0')}"
        "${now.year.toString()}"
        "${now.hour.toString().padLeft(2, '0')}"
        "${now.minute.toString().padLeft(2, '0')}"
        "${now.second.toString().padLeft(2, '0')}";
    return formattedDateTime;
  }

  Future<void> sendMessage(
      {required String chatID,
      required ChatModel chatData,
      required String messageID}) async {
    final String dataPath = "Chats/$chatID/Messages/$messageID";
    try {
      final DocumentReference<Map<String, dynamic>> newDocRef =
          _firestore.doc(dataPath);
      await newDocRef.set(chatData.toMap());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> backupSentMessage(
      {required String UID,
      required ChatModel chatData,
      required String chatID,
      required String messageID}) async {
    final String dataPath = "Users/$UID/Chats/$chatID/Messages/$messageID";
    try {
      final DocumentReference<Map<String, dynamic>> newDocRef =
          _firestore.doc(dataPath);
      await newDocRef.set(chatData.toMap());
    } on FirebaseException {
      rethrow;
    }
  }

  Stream<List<ChatModel>> retrieveSentMessages(
      {required String chatID, required String ID}) {
    final String dataPath = "Users/$ID/Chats/$chatID/Messages";
    final CollectionReference<Map<String, dynamic>> messagesRef =
        _firestore.collection(dataPath);
    return messagesRef
        .where('senderId', isEqualTo: ID)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      List<ChatModel> messages = [];
      for (final doc in snapshot.docs) {
        messages.add(ChatModel.fromMap(doc.data()));
      }
      return messages;
    });
  }

  Stream<List<ChatModel>> retrieveMessages(
      {required String chatID, required String ID}) {
    final String dataPath = "Chats/$chatID/Messages/";
    final CollectionReference<Map<String, dynamic>> messagesRef =
        _firestore.collection(dataPath);
    return messagesRef
        .where('receiverId', isEqualTo: ID)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      List<ChatModel> messages = [];
      for (final doc in snapshot.docs) {
        messages.add(ChatModel.fromMap(doc.data()));
      }
      return messages;
    });
  }

  Stream<List<List<ChatModel>>> messages(
      String chatId, String senderId, String receiveId) {
    Stream<List<ChatModel>> sentMessagesStream =
        retrieveSentMessages(chatID: chatId, ID: senderId);
    Stream<List<ChatModel>> allMessagesStream =
        retrieveAllMessages(chatID: chatId);
    return Rx.combineLatest2(sentMessagesStream, allMessagesStream,
        (sentMessages, allMessages) {
      return [sentMessages, allMessages];
    });
  }

  Stream<List<ChatModel>> retrieveAllMessages({required String chatID}) {
    final String dataPath = "Chats/$chatID/Messages/";
    final CollectionReference<Map<String, dynamic>> messagesRef =
        _firestore.collection(dataPath);
    return messagesRef
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      List<ChatModel> messages = [];
      for (final doc in snapshot.docs) {
        messages.add(ChatModel.fromMap(doc.data()));
      }
      return messages;
    });
  }

  Future<void> addIDsToChats(
      {required String Id1,
      required String Id2,
      required String chatID}) async {
    final String dataPath = "Chats/$chatID/";
    List<String> sortedIds = [Id1, Id2]..sort();
    Id1 = sortedIds[0];
    Id2 = sortedIds[1];
    final DocumentReference<Map<String, dynamic>> docRef =
        _firestore.doc(dataPath);
    await docRef.set({"UserA": Id1, "UserB": Id2}, SetOptions(merge: true));
  }

  Future<String?> getUserPublicKey({required String Id}) async {
    final doc =
        await FirebaseFirestore.instance.collection("Users").doc(Id).get();
    final publicKey = doc.get("PublicKey");
    return publicKey;
  }

  Future<String?> getUserPrivateKey({required String Id}) async {
    final String dataPath = "Users/$Id/Details/PrivateKey/";

    try {
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.doc(dataPath).get();
      return docSnapshot.data()?['PrivateKey'];
    } on FirebaseException {
      rethrow;
    }
  }
}
