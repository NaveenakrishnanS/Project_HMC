// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_hmc/models/user_model.dart';
import 'auth/firebase_auth.dart';

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
        .where(FieldPath.documentId, isNotEqualTo: FirebaseAuthentication.getUserUid).snapshots();

    return stream.asyncMap((collectionsQuery) async {
      final users = <UserModel>[];

      for (var document in collectionsQuery.docs) {
        UserModel? user = await retrieveUserDetails(UID: document.id);
        users.add(user);
      }
      return users;
    });
  }

  Future<UserModel> retrieveUserDetails({required String UID}) async {
    final String dataPath = "Users/$UID/Details/Details/";

    final DocumentReference documentReference = _firestore.doc(dataPath);
    final DocumentSnapshot orderDocumentSnapshot = await documentReference.get();

    UserModel userModel = UserModel.fromMap(
        orderDocumentSnapshot.data() as Map<String, dynamic>);

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

  Future<void> addPublicKey({required String PublicKey, required String UID}) async {
    final String dataPath = "Users/$UID/";
    try {
      final DocumentReference<Map<String, dynamic>> docRef = _firestore.doc(dataPath);
      await docRef.set({"PublicKey": PublicKey});
    } on FirebaseException {
      rethrow;
    }
  }
  
  Future<void> backupPrivateKey({required String PrivateKey, required String UID}) async {
    final String dataPath = "Users/$UID/Details/PrivateKey/";

    try {
      final DocumentReference<Map<String, dynamic>> docRef = _firestore.doc(dataPath);
      await docRef.set({"PrivateKey": PrivateKey});
    } on FirebaseException {
      rethrow;
    }
  }
}
