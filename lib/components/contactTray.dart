import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactTray extends StatelessWidget {
  String name;
  IconData icon;
  ContactTray({required this.name,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: EdgeInsets.all(10),
      style: NeumorphicStyle(
        color: uiWhite,
      ),
      child: SizedBox(
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 50.w,
              child: Text(
                '$name',
                style: textStyle.copyWith(fontSize: 15.sp),
              ),
            ),
            NeumorphicButton(
              style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  color: uiWhite),
              child: FaIcon(
                icon,
                color: uiPink,
              ),
              onPressed: () {
                
              },
            )
          ],
        ),
      ),
    );
  }
}