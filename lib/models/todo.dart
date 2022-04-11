// cat/models/todo.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  late String? todoId;
  late String? content;
  late bool? done;

  static const contentString = 'content';
  static const doneBool = 'done';

  TodoModel({
    required this.todoId,
    required this.content,
    required this.done,
  });

  TodoModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<dynamic, dynamic>> documentSnapshot}) {
    todoId = documentSnapshot.id;
    content = documentSnapshot.data()![contentString] as String;
    done = documentSnapshot.data()![doneBool] as bool;
  }
}
/* 
class UserModel {
  static const NUMBER = 'number';
  static const ID = 'id';

  String _number = '';
  String _id = '';

  String get number => _number;
  String get id => _id;

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _number = snapshot.data()![NUMBER];
    _id = snapshot.data()![ID];
  }
}
 */