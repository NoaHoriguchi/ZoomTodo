// cat/models/nav.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? userId;
  late String? name;
  late String? email;
  late String? password;

  static const nameString = 'name';
  static const emailString = 'email';
  static const passwordString = 'password';

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
  });

  UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<dynamic, dynamic>> documentSnapshot}) {
    userId = documentSnapshot.id;
    name = documentSnapshot.data()![nameString] as String;
    email = documentSnapshot.data()![emailString] as String;
    password = documentSnapshot.data()![passwordString] as String;
  }
}
