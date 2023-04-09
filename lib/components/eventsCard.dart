import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class EventsCard extends StatelessWidget {
  EventsCard({required this.place,required this.timeNdate,required this.title,required this.onTap});
    String timeNdate;
    String place;
    String title;
    Function onTap;

  @override
  Widget build(BuildContext context) {
    
    return NeumorphicButton(
      onPressed: (){
        onTap();
      },
      style: NeumorphicStyle(color: Colors.black,shadowLightColor: Colors.white,shadowDarkColor: Colors.white,depth: 1),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 0,
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "$title",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "Lato",
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
              child: Image(
                image: AssetImage('images/line.png'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: Colors.white,
                        ),
                        Text(
                          '$timeNdate',
                          style: textStyle.copyWith(fontSize: 15.sp,color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(height: 5.sp,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.locationArrow,
                          color: Colors.white,
                        ),
                        Text(
                          '$place',
                          style: textStyle.copyWith(fontSize: 15.sp,color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
