// cat/widgets/zoomcard.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cat/models/zoommod.dart';
import 'package:cat/services/zoomdata.dart';

class ZoomCard extends StatefulWidget {
  final ZoomModel zoom;
  final FirebaseFirestore firestore;
  final String uid;

  const ZoomCard(
      {Key? key,
      required this.zoom,
      required this.firestore,
      required this.uid})
      : super(key: key);

  @override
  _ZoomCardState createState() => _ZoomCardState();
}

class _ZoomCardState extends State<ZoomCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.zoom.name as String,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Checkbox(
                value: widget.zoom.done,
                onChanged: (newValue) {
                  setState(() {});
                  Zoomdata(firestore: widget.firestore).updateZoom(
                    uid: widget.uid,
                    zoomId: widget.zoom.zoomId,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL() async {
    if (!await launch(widget.zoom.link as String)) throw 'Could not launch url';
  }
}
