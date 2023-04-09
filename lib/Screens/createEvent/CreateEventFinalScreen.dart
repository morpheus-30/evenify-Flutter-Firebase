// import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:temp_flutter_proj/components/iconButton.dart';
import 'package:temp_flutter_proj/constants.dart';
import "package:sizer/sizer.dart";
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateEventFinalScreen extends StatelessWidget {
  var _firestore = FirebaseFirestore.instance;
  CreateEventFinalScreen(this.id);
  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.checkCircle, color: Colors.green, size: 50),
            SizedBox(height: 2.h),
            Container(
              child: Text(
                "Event Created",
                style: textStyle.copyWith(
                    fontSize: 30.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lato'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.h),
              child: Text(
                "You can now invite your friends to the event",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lato'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(id,
                    style: textStyle.copyWith(
                        fontSize: 40.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Lato')),
                SizedBox(
                  width: 3.w,
                ),
                NeumorphicButton(
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: "${id}"));
                    print("copied successfully");
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    shadowDarkColor: Colors.white,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 1,
                    lightSource: LightSource.topLeft,
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FaIcon(
                      FontAwesomeIcons.copy,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
              width: 40.w,
              child: NeumorphicButton(
                onPressed: () async {
                  var reference = await _firestore.collection("Users").doc("usermail@gmail.com").collection("MyEvents").doc(id).get();
                  var referenceData = reference.data();
                  var email = referenceData!["email"];
                  // print(email);
                  var newmail="";
                  for(int i=0;i<email.length;i++){
                    if(email[i]=="@"){
                      break;
                    }
                    else{
                      newmail = newmail + email[i];
                    }
                  }
                  print(newmail);

                  
                  await Share.share("""Hey, you've been invited to ${referenceData["eventName"]} by ${newmail} on Evenify. You can join it by entering the code ${id} in the app. Download the app from the link below:""");
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  shadowDarkColor: Colors.white,
                  boxShape: NeumorphicBoxShape.rect(),
                  depth: 1,
                  lightSource: LightSource.topLeft,
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.shareNodes,
                      size: 20.sp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "Share",
                      style: textStyle.copyWith(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Lato'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
