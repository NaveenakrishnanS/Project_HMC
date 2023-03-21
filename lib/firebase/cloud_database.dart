// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_hmc/models/user_model.dart';

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

  Future<void> addUID({required String UID}) async {
    final String dataPath = "Users/$UID/";

    try {
      final DocumentReference<Map<String, dynamic>> docRef = _firestore.doc(dataPath);
      await docRef.set({"UID": UID});
    } on FirebaseException {
      rethrow;
    }
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

}
