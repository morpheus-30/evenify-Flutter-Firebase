// import 'package:provider/provider.dart';
// import 'package:temp_flutter_proj/components/contactTray.dart';
import 'dart:math';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_flutter_proj/Screens/createEvent/CreateEventFinalScreen.dart';
// import 'package:temp_flutter_proj/Screens/EventDetailsScreen.dart';
import 'package:temp_flutter_proj/constants.dart';
import 'package:sizer/sizer.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:temp_flutter_proj/partilyContacts.dart';
import 'package:temp_flutter_proj/components/iconButton.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:temp_flutter_proj/components/NeumorphicTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FillEventDetails extends StatelessWidget {
  FillEventDetails(this.type);
  late User loggedInUser;
  String type;
  Map<String, dynamic> eventDetails = {
    "eventName": "",
    "eventDate": "",
    "eventTime": "",
    "eventLocation": "",
    "Type": "",
    "email": "",
    "phoneNumber": ""
  };
  void GetCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    GetCurrentUser();
  }
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 100,
          leadingWidth: 18.w,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            padding: EdgeInsets.only(left: 15),
            child: MyIconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: FontAwesomeIcons.arrowLeft,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Event Details",
                  style: textStyle.copyWith(
                      fontSize: 30.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Lato'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: NeumorphicTextField(
                onPressed: (value) {
                  eventDetails["eventName"] = value;
                },
                hintText: "Enter the name of the event",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: NeumorphicTextField(
                maxLength: 10,
                onPressed: (value) {
                  eventDetails["phoneNumber"] = value;
                },
                type: TextInputType.phone,
                hintText: "Enter your Phone Number",
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            //   child: NeumorphicTextField(
            //     maxLength: 40,
            //     onPressed: (value) {
            //       eventDetails["email"] = value;
            //     },
            //     type: TextInputType.emailAddress,
            //     hintText: "Enter your email address",
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: NeumorphicTextField(
                maxLength: 100,
                onPressed: (value) {
                  eventDetails["eventLocation"] = value;
                },
                hintText: "Enter the complete address of the venue",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyIconButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    eventDetails["eventDate"] =
                        date.toString().substring(0, 10);
                    // print(date.toString().substring(0,10));
                  },
                  icon: FontAwesomeIcons.calendar,
                ),
                MyIconButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    print(time.toString().substring(10, 15));
                    eventDetails["eventTime"] =
                        time.toString().substring(10, 15);
                  },
                  icon: FontAwesomeIcons.clock,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 2.h),
              child: NeumorphicButton(
                style: NeumorphicStyle(
                  depth: 1,
                  color: Colors.black,
                  shadowDarkColor: Colors.white,
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Next",
                  style:
                      textStyle.copyWith(color: Colors.white, fontSize: 20.sp),
                ),
                onPressed: () async {
                  GetCurrentUser();
                  // print(loggedInUser.email);
                  eventDetails["Type"] = type;
                  eventDetails["email"] = loggedInUser.email;
                  // print(eventDetails);
                  int id = (new Random().nextInt(900000)) + 100000;
                  // print(id);
                  var reference = await _firestore
                      .collection('Events')
                      .doc(id.toString())
                      .get();
                  // print(reference.exists);
                  while (reference.exists) {
                    id = (new Random().nextInt(900000)) + 100000;
                    reference = await _firestore
                        .collection('Users')
                        .doc(id.toString())
                        .get();
                  }
                  eventDetails["id"] = id.toString();
                  print(eventDetails);
                  await _firestore
                      .collection('Users')
                      .doc(loggedInUser.email)
                      .collection('MyEvents')
                      .doc(id.toString())
                      .set(eventDetails);
                  // await _firestore
                  //     .collection("Events")
                  //     .doc(id.toString())
                  //     .collection("GuestList")
                  //     .doc()
                  //     .set({});
                  // Navigator.pushNamed(context, '/createEventFinalScreen');
                  await _firestore
                      .collection("Events")
                      .doc(id.toString())
                      .set(eventDetails);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateEventFinalScreen(id.toString()),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
