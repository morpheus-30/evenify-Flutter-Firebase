import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';
import 'package:temp_flutter_proj/constants.dart';
// import 'package:temp_flutter_proj/components/NeumorphicTextField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JoinAnEvent extends StatefulWidget {
  @override
  State<JoinAnEvent> createState() => _JoinAnEventState();
}

String id = "";

class _JoinAnEventState extends State<JoinAnEvent> {
  bool _isButtonDisabled = false;
  final _firestore = FirebaseFirestore.instance;
  User LoggedInUser = FirebaseAuth.instance.currentUser!;
  final _auth = FirebaseAuth.instance;
  List<Widget> columnWidgets = [
    Center(
      child: SizedBox(
        width: 60.w,
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: 0,
            color: Colors.black,
          ),
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 6,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: textStyle.copyWith(color: Colors.white, fontSize: 40.sp),
            decoration: loginInputDecoration.copyWith(
              hintText: "Enter the code",
              hintStyle:
                  textStyle.copyWith(color: Colors.white, fontSize: 20.sp),
            ),
            onChanged: (value) {
              id = value;
            },
          ),
        ),
      ),
    ),
    // SizedBox(
    //   height: 5.h,
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          toolbarHeight: 60,
          leading: SizedBox(
            height: 50,
            width: 50,
            child: Container(
              margin: EdgeInsets.all(5),
              child: NeumorphicButton(
                padding: EdgeInsets.all(5),
                onPressed: () {
                  Navigator.pushReplacementNamed(context,"/main");
                },
                style: NeumorphicStyle(
                  depth: 2,
                  color: Colors.white,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: columnWidgets),
            NeumorphicButton(
              style: NeumorphicStyle(
                depth: 1,
                color: Colors.black,
                shadowDarkColor: Colors.white,
                shadowLightColor: Colors.white,
              ),
              onPressed: _isButtonDisabled
                  ? null
                  : () async {
                      setState(() {
                        columnWidgets.add(Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          child: Text(
                            "Event Added Successfully on your Events Screen",
                            style: textStyle.copyWith(color: Colors.white),
                          ),
                        ));
                        _isButtonDisabled = true;
                      });
                      // print(LoggedInUser.email);
                      var EventReference =
                          await _firestore.collection("Events").doc(id).get();
                      if (EventReference.exists&&LoggedInUser.email!=EventReference.data()!["email"]) {
                        var EventDetails = EventReference.data();
                        // print(EventDetails);
                        await _firestore
                            .collection("Users")
                            .doc(LoggedInUser.email)
                            .collection("EventsInvited")
                            .doc(id)
                            .set(EventDetails!);
                      } else {
                        print("nahi h bc");
                      }
                    },
              child: Text(
                "Join",
                style: textStyle.copyWith(color: Colors.white, fontSize: 20.sp),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            NeumorphicButton(
              style: NeumorphicStyle(
                depth: 1,
                color: Colors.black,
                shadowDarkColor: Colors.white,
                shadowLightColor: Colors.white,
              ),
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/main");
              }
                    ,
              child: Text(
                "Main Screen",
                style: textStyle.copyWith(color: Colors.white, fontSize: 20.sp),
              ),
            ),
            
          ],
        ));
  }
}
