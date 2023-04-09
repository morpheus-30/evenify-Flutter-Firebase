// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
import 'package:temp_flutter_proj/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:temp_flutter_proj/components/eventsCard.dart';
import 'package:sizer/sizer.dart';
// import 'package:temp_flutter_proj/partilyContacts.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'EventDetailsScreen.dart';
class EventsScreen extends StatefulWidget {
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}
class _EventsScreenState extends State<EventsScreen> {
  List Events = [];
  bool _addListWidget = false;
  bool _accountListWidget = false;
  @override
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedinUser;
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
  void LoadList(){
    setState(() {
      null;
    });
  }
  void InitializeEvents() async {
    var EventsReference = await _firestore
        .collection("Users")
        .doc(loggedinUser.email)
        .collection("EventsInvited")
        .get();
    List EventsDocs = EventsReference.docs;
    // for (dynamic i in EventsDocs) {
    //   print(i.data());
    // }
    // print(EventsDocs.length);
    for (int i = 0; i < EventsDocs.length; i++) {
      // if (EventsDocs[i].data != null) {
      //   Events.add(EventsDocs[i].data());
      // }
      if (!Events.contains(EventsDocs[i].data())) {
        setState(() {
          Events.add(EventsDocs[i].data());
        });
      }
    }
    Events.removeAt(Events.length - 1);
    // print(Events);
  }
  void initState() {
    super.initState();
    getCurrentUser();
    InitializeEvents();
  }
  @override
  Widget build(BuildContext context) {
    bool _load = false;
    Widget lodingIndicator = _load
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container();
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(right: 20),
            child: NeumorphicButton(
              padding: EdgeInsets.all(5),
              onPressed: () {
                setState(() {
                  _accountListWidget = !_accountListWidget;
                });
              },
              style: NeumorphicStyle(
                depth: 2,
                color: Colors.white,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.solidCircleUser,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        leadingWidth: 80,
        toolbarHeight: 60,
        leading: Container(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.only(right: 20),
          child: NeumorphicButton(
            padding: EdgeInsets.all(5),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            style: NeumorphicStyle(
              depth: 2,
              color: Colors.white,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.arrowRightFromBracket,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            lodingIndicator,
            Column(
              children: [
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 1.h),
                    child: Text(
                      "Events that you've been invited at..",
                      style: textStyle.copyWith(
                          fontSize: 30.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Lato'),
                    ),
                  ),
                ),
                Expanded(
                  child: Events.length == 0
                      ? Container()
                      : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount: Events.length,
                            // padding: EdgeInsets.only(top: 30.h),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return EventsCard(
                                timeNdate: Events[index]["eventTime"] +
                                    " " +
                                    Events[index]["eventDate"],
                                place: Events[index]["eventLocation"],
                                title: Events[index]["eventName"],
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsScreen(EventDetails: Events[index],)));
                                },
                              );
                            },
                          ),
                      ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _addListWidget
                    ? Container(
                        margin: EdgeInsets.only(right: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NeumorphicButton(
                              onPressed: () {
                                setState(() {
                                  _addListWidget = false;
                                });
                                Navigator.pushNamed(context, "/typeOfEvent");
                              },
                              style: NeumorphicStyle(
                                  shadowDarkColor: Colors.white,
                                  color: Colors.black,
                                  depth: 1),
                              child: SizedBox(
                                height: 2.h,
                                width: 30.w,
                                child: Text(
                                  "Create new Event",
                                  style: textStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            NeumorphicButton(
                              onPressed: (() {
                                setState(() {
                                  _addListWidget = false;
                                });
                                Navigator.pushReplacementNamed(context, "/joinAnEvent");
                              }),
                              style: NeumorphicStyle(
                                  shadowDarkColor: Colors.white,
                                  color: Colors.black,
                                  depth: 1),
                              child: SizedBox(
                                height: 2.h,
                                width: 30.w,
                                child: Center(
                                  child: Text(
                                    "Join an Event",
                                    style: textStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: NeumorphicButton(
                    margin: EdgeInsets.all(25),
                    onPressed: () async {
                      setState(() {
                        _addListWidget = !_addListWidget;
                      });
                      // for (dynamic i in Events) {
                      //   print(i);
                      // }
                      // for(int i=0;i<Events.length;i++){
                      //   if(Events[i]=={}){
                      //     Events.rem
                      //   }
                      // }
                      // Events.removeAt(Events.length - 1);
                      // print(Events);
                      // setState(() {
                      //   _load = true;
                      // });
                      // Map<Permission, PermissionStatus> statuses = await [
                      //   Permission.contacts,
                      //   Permission.location,
                      // ].request();
                      // final info = statuses[Permission.contacts];
                      // if (info == PermissionStatus.granted) {
                      //   // await Provider.of<PartilyContacts>(context, listen: false)
                      //   //     .addContacts(FontAwesomeIcons.plus);
                      //   print("permission granted");
                      //   Navigator.pushNamed(context, "/typeOfEvent");
                      // } else {
                      //   Navigator.pushNamed(context, "/");
                      // }
                    },
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      color: Colors.black,
                      size: 40,
                    ),
                    style: NeumorphicStyle(
                      depth: 0,
                      color: Colors.white,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                  ),
                ),
              ],
            ),
            _accountListWidget
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NeumorphicButton(
                            onPressed: () {
                              setState(() {
                                _accountListWidget = false;
                              });
                              Navigator.pushNamed(context, "/accountDetails");
                            },
                            style: NeumorphicStyle(
                                shadowDarkColor: Colors.white,
                                color: Colors.white,
                                depth: 1),
                            child: SizedBox(
                              height: 2.h,
                              width: 30.w,
                              child: Text(
                                "Account",
                                textAlign: TextAlign.center,
                                style: textStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          NeumorphicButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/myEvents");
                            },
                            style: NeumorphicStyle(
                                shadowDarkColor: Colors.white,
                                color: Colors.white,
                                depth: 1),
                            child: SizedBox(
                              height: 2.h,
                              width: 30.w,
                              child: Center(
                                child: Text(
                                  "My Events",
                                  style: textStyle.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
