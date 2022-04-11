/* // cat/screens/zoom.dart

import 'package:cat/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:cat/models/zoommod.dart';
import 'package:cat/services/auth.dart';
import 'package:cat/services/zoomdata.dart';
import 'package:cat/widgets/zoomcard.dart';
import 'package:cat/main.dart';

/* final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/* final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>(); */

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

Future<void> main() async {
  final IOSInitializationSettings initializationSettingsIOS =
      const IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    iOS: initializationSettingsIOS,
  );
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

class PaddedElevatedButton extends StatelessWidget {
  const PaddedElevatedButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      );
}
 */

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// before my dumbass

class Zoom extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Zoom({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> with SingleTickerProviderStateMixin {
  final TextEditingController _zoomController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  late TabController _tabController;

  var _dropController = 'Favorites';

  TimeOfDay? selectedTime;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 6, vsync: this);
    super.initState();
    _requestPermissions();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text(
              "Links",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                key: const ValueKey("signOut"),
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  Auth(auth: widget.auth).signOut();
                },
              )
            ],
            /* flexibleSpace: const CustomScrollView(slivers: [
              SliverAppBar(
                pinned: false,
                snap: true,
                floating: true,
                expandedHeight: 800,
                flexibleSpace: FlexibleSpaceBar(
                  title: Card(
                      elevation: 20.0,
                      child: Center(
                        child: Text("Header"),
                      )),
                ),
              )
            ]), */
            bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(icon: Icon(Icons.star)),
                  Tab(text: "MON"),
                  Tab(text: "TUE"),
                  Tab(text: "WED"),
                  Tab(text: "THU"),
                  Tab(text: "FRI"),
                ])),
        body: /* Column(children: [
          const CustomScrollView(slivers: [
            SliverAppBar(
                pinned: false,
                snap: true,
                floating: true,
                expandedHeight: 800,
                flexibleSpace: FlexibleSpaceBar(
                    title: Card(
                  elevation: 20.0,
                  child: Center(
                    child: Text("Header"),
                  ),
                )))
          ]), */
            TabBarView(controller: _tabController, children: [
          Column(children: <Widget>[
            /* const SizedBox(
              height: 20,
            ),
            const Text(
              "Add Meetings: ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ), */
            Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListBody(
                          children: [
                            Expanded(
                              child: TextFormField(
                                key: const ValueKey("addField"),
                                controller: _zoomController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  icon: Icon(Icons.videocam),
                                  hintText: "Enter Meeting Name",
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    _linkController.text = "http://www.";
                                  });
                                },
                                key: const ValueKey("addField"),
                                controller: _linkController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  icon: Icon(Icons.link),
                                  hintText: "Enter Meeting Link",
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: DropdownButtonFormField(
                                items: <String>[
                                  'Monday',
                                  'Tuesday',
                                  'Wednesday',
                                  'Thursday',
                                  'Friday',
                                  'Favorites'
                                ].map((String label) {
                                  return DropdownMenuItem<String>(
                                    value: label,
                                    child: Text(label.toString()),
                                  );
                                }).toList(),
                                hint: const Text("Choose Day"),
                                value: _dropController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_today)),
                                //hint: const Text("Choose Days"),
                                onChanged: (value) {
                                  setState(() {
                                    _dropController = value.toString();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.schedule),
                                Text(selectedTime != null
                                    ? "${selectedTime!.hour}:${selectedTime!.minute}"
                                    : "Time"),
                                ElevatedButton(
                                    onPressed: () => _pickTime(context),
                                    child: const Text(
                                      "Select Time",
                                    ))
                              ],
                            )),
                            const SizedBox(height: 10),
                            const Expanded(
                                /* child: PaddedElevatedButton(
                              onPressed: ,
                              buttonText: "Dumbass", */
                              child: ElevatedButton(onPressed: null, child: Text("Dumbass")),
                            )]))
                            //const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      IconButton(
                        key: const ValueKey("addButton"),
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_zoomController.text != "" &&
                              _linkController.text != "") {
                            setState(() {
                              Zoomdata(firestore: widget.firestore).addZoom(
                                uid: widget.auth.currentUser!.uid,
                                name: _zoomController.text,
                                link: _linkController.text,
                                day: _dropController,
                              );
                              _zoomController.clear();
                              _linkController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                            });
                          }
                        },
                      )
                    ],
                  )),
            ),
            const Text(
              "Favorites",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: ZoomdataOther(firestore: widget.firestore)
                    .streamZoomOther(uid: widget.auth.currentUser?.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ZoomModel>> snapshot) {
                  //list has a list of zoomId content and done
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("You don't have any meetings"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return ZoomCard(
                          firestore: widget.firestore,
                          uid: widget.auth.currentUser!.uid,
                          zoom: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("loading..."),
                    );
                  }
                },
              ),
            ),
          ]),
          Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Meetings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: ZoomdataMon(firestore: widget.firestore)
                    .streamZoomMon(uid: widget.auth.currentUser?.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ZoomModel>> snapshot) {
                  //list has a list of zoomId content and done
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("You don't have any meetings"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return ZoomCard(
                          firestore: widget.firestore,
                          uid: widget.auth.currentUser!.uid,
                          zoom: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("loading..."),
                    );
                  }
                },
              ),
            ),
          ]),
          Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Meetings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: ZoomdataTues(firestore: widget.firestore)
                    .streamZoomTues(uid: widget.auth.currentUser?.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ZoomModel>> snapshot) {
                  //list has a list of zoomId content and done
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("You don't have any meetings"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return ZoomCard(
                          firestore: widget.firestore,
                          uid: widget.auth.currentUser!.uid,
                          zoom: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("loading..."),
                    );
                  }
                },
              ),
            ),
          ]),
          Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Meetings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: ZoomdataWed(firestore: widget.firestore)
                    .streamZoomWed(uid: widget.auth.currentUser?.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ZoomModel>> snapshot) {
                  //list has a list of zoomId content and done
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("You don't have any meetings"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return ZoomCard(
                          firestore: widget.firestore,
                          uid: widget.auth.currentUser!.uid,
                          zoom: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("loading..."),
                    );
                  }
                },
              ),
            ),
          ]),
          Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Meetings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: ZoomdataThurs(firestore: widget.firestore)
                    .streamZoomThurs(uid: widget.auth.currentUser?.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ZoomModel>> snapshot) {
                  //list has a list of zoomId content and done
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("You don't have any meetings"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return ZoomCard(
                          firestore: widget.firestore,
                          uid: widget.auth.currentUser!.uid,
                          zoom: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("loading..."),
                    );
                  }
                },
              ),
            ),
          ]),
          Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Meetings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: ZoomdataFri(firestore: widget.firestore)
                    .streamZoomFri(uid: widget.auth.currentUser?.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ZoomModel>> snapshot) {
                  //list has a list of zoomId content and done
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("You don't have any meetings"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return ZoomCard(
                          firestore: widget.firestore,
                          uid: widget.auth.currentUser!.uid,
                          zoom: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("loading..."),
                    );
                  }
                },
              ),
            ),
          ]),
        ]));
  }

  Future _pickTime(BuildContext context) async {
    final initialTime = TimeOfDay.fromDateTime(DateTime.now());

    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);

    if (newTime != null) {
      setState(() => selectedTime = newTime);
    } else {
      return;
    }
  }
}
 */