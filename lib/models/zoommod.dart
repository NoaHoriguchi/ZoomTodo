// cat/models/zoommod.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class ZoomModel {
  late String? zoomId;
  late String? name;
  late String? link;
  late bool? done;

  static const nameString = 'name';
  static const linkString = 'link';
  static const doneBool = 'done';

  ZoomModel({
    required this.zoomId,
    required this.name,
    required this.link,
    required this.done,
  });

  ZoomModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<dynamic, dynamic>> documentSnapshot}) {
    zoomId = documentSnapshot.id;
    name = documentSnapshot.data()![nameString] as String;
    link = documentSnapshot.data()![linkString] as String;
    done = documentSnapshot.data()![doneBool] as bool;
  }
}
