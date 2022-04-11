// cat/services/zoomdata.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cat/models/zoommod.dart';

class Zoomdata {
  final FirebaseFirestore firestore;

  Zoomdata({required this.firestore});

  Stream<List<ZoomModel>> streamZoom({String? uid}) {
    try {
      return firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .where("done", isEqualTo: false)
          //.where("date", isEqualTo: "Monday")
          .snapshots()
          .map((query) {
        final List<ZoomModel> retVal = <ZoomModel>[];
        for (final DocumentSnapshot<Map<dynamic, dynamic>> doc in query.docs) {
          retVal.add(ZoomModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addZoom(
      {String? uid, String? name, String? link, String? day}) async {
    try {
      firestore.collection("zoom").doc(uid).collection("zoom").add({
        "name": name,
        "link": link,
        "done": false,
        "day": day,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateZoom({String? uid, String? zoomId}) async {
    try {
      firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .doc(zoomId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  }
}

class ZoomdataMon {
  final FirebaseFirestore firestore;

  ZoomdataMon({required this.firestore});

  Stream<List<ZoomModel>> streamZoomMon({String? uid}) {
    try {
      return firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .where("done", isEqualTo: false)
          .where("day", isEqualTo: "Monday")
          .snapshots()
          .map((query) {
        final List<ZoomModel> retVal = <ZoomModel>[];
        for (final DocumentSnapshot<Map<dynamic, dynamic>> doc in query.docs) {
          retVal.add(ZoomModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addZoom({String? uid, String? name, String? link}) async {
    try {
      firestore.collection("zoom").doc(uid).collection("zoom").add({
        "name": name,
        "link": link,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateZoom({String? uid, String? zoomId}) async {
    try {
      firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .doc(zoomId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  }
}

class ZoomdataTues {
  final FirebaseFirestore firestore;

  ZoomdataTues({required this.firestore});

  Stream<List<ZoomModel>> streamZoomTues({String? uid}) {
    try {
      return firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .where("done", isEqualTo: false)
          .where("day", isEqualTo: "Tuesday")
          .snapshots()
          .map((query) {
        final List<ZoomModel> retVal = <ZoomModel>[];
        for (final DocumentSnapshot<Map<dynamic, dynamic>> doc in query.docs) {
          retVal.add(ZoomModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addZoom({String? uid, String? name, String? link}) async {
    try {
      firestore.collection("zoom").doc(uid).collection("zoom").add({
        "name": name,
        "link": link,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateZoom({String? uid, String? zoomId}) async {
    try {
      firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .doc(zoomId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  }
}

class ZoomdataWed {
  final FirebaseFirestore firestore;

  ZoomdataWed({required this.firestore});

  Stream<List<ZoomModel>> streamZoomWed({String? uid}) {
    try {
      return firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .where("done", isEqualTo: false)
          .where("day", isEqualTo: "Wednesday")
          .snapshots()
          .map((query) {
        final List<ZoomModel> retVal = <ZoomModel>[];
        for (final DocumentSnapshot<Map<dynamic, dynamic>> doc in query.docs) {
          retVal.add(ZoomModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addZoom({String? uid, String? name, String? link}) async {
    try {
      firestore.collection("zoom").doc(uid).collection("zoom").add({
        "name": name,
        "link": link,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateZoom({String? uid, String? zoomId}) async {
    try {
      firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .doc(zoomId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  }
}

class ZoomdataThurs {
  final FirebaseFirestore firestore;

  ZoomdataThurs({required this.firestore});

  Stream<List<ZoomModel>> streamZoomThurs({String? uid}) {
    try {
      return firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .where("done", isEqualTo: false)
          .where("day", isEqualTo: "Thursday")
          .snapshots()
          .map((query) {
        final List<ZoomModel> retVal = <ZoomModel>[];
        for (final DocumentSnapshot<Map<dynamic, dynamic>> doc in query.docs) {
          retVal.add(ZoomModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addZoom({String? uid, String? name, String? link}) async {
    try {
      firestore.collection("zoom").doc(uid).collection("zoom").add({
        "name": name,
        "link": link,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateZoom({String? uid, String? zoomId}) async {
    try {
      firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .doc(zoomId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  }
}

class ZoomdataFri {
  final FirebaseFirestore firestore;

  ZoomdataFri({required this.firestore});

  Stream<List<ZoomModel>> streamZoomFri({String? uid}) {
    try {
      return firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .where("done", isEqualTo: false)
          .where("day", isEqualTo: "Friday")
          .snapshots()
          .map((query) {
        final List<ZoomModel> retVal = <ZoomModel>[];
        for (final DocumentSnapshot<Map<dynamic, dynamic>> doc in query.docs) {
          retVal.add(ZoomModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addZoom({String? uid, String? name, String? link}) async {
    try {
      firestore.collection("zoom").doc(uid).collection("zoom").add({
        "name": name,
        "link": link,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateZoom({String? uid, String? zoomId}) async {
    try {
      firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .doc(zoomId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  }
}

class ZoomdataOther {
  final FirebaseFirestore firestore;

  ZoomdataOther({required this.firestore});

  Stream<List<ZoomModel>> streamZoomOther({String? uid}) {
    try {
      return firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .where("done", isEqualTo: false)
          .where("day", isEqualTo: "Favorites")
          .snapshots()
          .map((query) {
        final List<ZoomModel> retVal = <ZoomModel>[];
        for (final DocumentSnapshot<Map<dynamic, dynamic>> doc in query.docs) {
          retVal.add(ZoomModel.fromDocumentSnapshot(documentSnapshot: doc));
        }
        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addZoom({String? uid, String? name, String? link}) async {
    try {
      firestore.collection("zoom").doc(uid).collection("zoom").add({
        "name": name,
        "link": link,
        "done": false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateZoom({String? uid, String? zoomId}) async {
    try {
      firestore
          .collection("zoom")
          .doc(uid)
          .collection("zoom")
          .doc(zoomId)
          .update({
        "done": true,
      });
    } catch (e) {
      rethrow;
    }
  }
}
