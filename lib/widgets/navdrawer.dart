/* // cat/widgets/navdrawer.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cat/models/nav.dart';
import 'package:cat/services/database.dart';
import 'package:cat/services/userdata.dart';

class NavDraw extends StatefulWidget {
  final UserModel nav;
  final FirebaseFirestore firestore;
  final String uid;

  const NavDraw(
      {Key? key, required this.nav, required this.firestore, required this.uid})
      : super(key: key);

  @override
  _NavDrawState createState() => _NavDrawState();
}

class _NavDrawState extends State<NavDraw> {}
 */