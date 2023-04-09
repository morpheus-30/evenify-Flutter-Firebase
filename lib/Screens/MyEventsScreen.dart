import 'package:flutter/material.dart';
import 'package:temp_flutter_proj/constants.dart';
import "package:sizer/sizer.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:temp_flutter_proj/components/eventsCard.dart';
import 'EventDetailsScreen.dart';

class MyEventsScreen extends StatefulWidget {
  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;

  late User loggedInUser;

  var Events = [];

  void InitializeEvents() async {
    var EventsReference = await _firestore
        .collection("Users")
        .doc(loggedInUser.email)
        .collection("MyEvents")
        .get();
    List EventsDocs = EventsReference.docs;
    for (int i = 0; i < EventsDocs.length; i++) {
      if (!Events.contains(EventsDocs[i].data())) {
        setState(() {
          Events.add(EventsDocs[i].data());
        });
      }
    }
    Events.removeAt(Events.length - 1);
    print(Events);
  }

  @override
  void initState() {
    loggedInUser = _auth.currentUser!;
    InitializeEvents();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Center(
            child: Text(
              "My Events",
              textAlign: TextAlign.center,
              style: textStyle.copyWith(color: Colors.white, fontSize: 20.sp),
            ),
          ),
        ),
        body:
            // ListView.builder(
            //   padding: EdgeInsets.all(5),
            //   itemCount: Events.length,
            //   // padding: EdgeInsets.only(top: 30.h),
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     return EventsCard(
            //       timeNdate: Events[index]["eventTime"] +
            //           " " +
            //           Events[index]["eventDate"],
            //       place: Events[index]["eventLocation"],
            //       title: Events[index]["eventName"],
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => EventDetailsScreen(
            //                       EventDetails: Events[index],
            //                     )));
            //       },
            //     );
            //   },
            // ),
            CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return EventsCard(
                  timeNdate: Events[index]["eventTime"] +
                      " " +
                      Events[index]["eventDate"],
                  place: Events[index]["eventLocation"],
                  title: Events[index]["eventName"],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(
                                  EventDetails: Events[index],
                                )));
                  },
                );
              },
              childCount: Events.length,
            ))
          ],
        ));
  }
}
