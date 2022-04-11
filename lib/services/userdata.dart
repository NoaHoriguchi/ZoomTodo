// cat/serives/userdata.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cat/models/nav.dart';

class UserData {
  final FirebaseFirestore firestore;

  UserData({required this.firestore});

  Stream<List<UserModel>> streamUser({String? uid}) {
    try {
      return firestore
          .collection("userdata")
          .doc(uid)
          .collection("userdata")
          .snapshots()
          .map((query) {
        final List<UserModel> retVal = <UserModel>[];
        for (final DocumentSnapshot<Map<dynamic, dynamic>> doc in query.docs) {
          retVal.add(UserModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser(
      {String? uid, String? name, String? email, String? password}) async {
    try {
      firestore
          .collection("userdata")
          .doc(uid)
          .collection("userdata")
          .add({"name": name, "email": email, "password": password});
    } catch (e) {
      rethrow;
    }
  }
  // for updating password or username
  /* Future<void> updateUser({String? uid, String? userId}) async {
    try {
      firestore
          .collection("userdata")
          .doc(uid)
          .collection("userdata")
          .doc(userId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  } */
}
