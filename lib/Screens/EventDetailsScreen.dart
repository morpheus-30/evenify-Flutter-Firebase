import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:temp_flutter_proj/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:temp_flutter_proj/mapUtils.dart';
class EventDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          minimum: EdgeInsets.only(top: 10.h, left: 6.w, right: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Josh's Birthday Party",
                textAlign: TextAlign.center,
                style: textStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Neumorphic(
                padding: EdgeInsets.all(15),
                style: NeumorphicStyle(
                    color: Colors.black,
                    depth: 1,
                    shadowDarkColor: Colors.white),
                child: SizedBox(
                  height: 35.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconTray(
                        icon: FontAwesomeIcons.calendar,
                        text: "2pm Today",
                        onIconTap: () async {
                          await LaunchApp.openApp(
                              androidPackageName:
                                  'com.google.android.calendar');
                        },
                      ),
                      IconTray(
                        icon: FontAwesomeIcons.locationArrow,
                        text: "Mere Ghar",
                        onIconTap: () async {
                          MapUtils.openMap(
                              "1012 sector 2 shastri nagar meerut");
                        },
                      ),
                      IconTray(
                        onIconTap: () async {
                          final phoneNumber = '7617439147';
                          final url = 'tel:$phoneNumber';
                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(url);
                          }
                        },
                        icon: FontAwesomeIcons.phone,
                        text: "7617439147",
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        child: NeumorphicButton(
                          style: NeumorphicStyle(color: Colors.white, depth: 1),
                          onPressed: () {},
                          child: Text(
                            "See who's on the guest list",
                            style: textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NeumorphicButton(
                    style: NeumorphicStyle(color: Colors.white, depth: 1),
                    onPressed: () {},
                    child: Text(
                      "I'll be there!",
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                  ),
                  NeumorphicButton(
                    style: NeumorphicStyle(
                        color: Colors.black,
                        depth: 1,
                        shadowDarkColor: Colors.white),
                    onPressed: () {},
                    child: Text(
                      "Can't make it!",
                      style: textStyle.copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              NeumorphicButton(
                style: NeumorphicStyle(color: Colors.white, depth: 1),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Go Back",
                  style: textStyle.copyWith(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class IconTray extends StatelessWidget {
  IconTray({required this.icon, required this.text, required this.onIconTap});
  String text;
  IconData icon;
  Function onIconTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NeumorphicButton(
          onPressed: () => onIconTap(),
          style: NeumorphicStyle(
            color: Colors.white,
            depth: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: FaIcon(
            icon,
            color: Colors.black,
          ),
        ),
        Text(
          "$text",
          style: textStyle.copyWith(fontSize: 20.sp, color: Colors.white),
        )
      ],
    );
  }
}
