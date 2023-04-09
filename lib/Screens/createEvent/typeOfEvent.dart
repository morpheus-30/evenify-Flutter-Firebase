// import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:temp_flutter_proj/constants.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:sizer/sizer.dart';
import 'package:temp_flutter_proj/components/iconButton.dart';


class TypeOfEvent extends StatefulWidget {
  @override
  State<TypeOfEvent> createState() => _TypeOfEventState();
}

class _TypeOfEventState extends State<TypeOfEvent> {
  bool showOthersInput = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 18.w,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.only(left: 15),
          child: MyIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: FontAwesomeIcons.arrowLeft,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Type of Event?",
                style: textStyle.copyWith(
                    fontSize: 30.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lato'),
              ),
            ),
            showOthersInput
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: 0,
                          color: Colors.black,
                        ),
                        child: TextField(
                          style: TextStyle(
                              fontFamily: "Lato", color: Colors.white),
                          decoration: loginInputDecoration.copyWith(
                            hintText: "Enter the type of event",
                            hintStyle:
                                textStyle.copyWith(color: Colors.white60),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: GridView.count(
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                crossAxisCount: 2,
                children: <Widget>[
                  TypeOfEventCard(
                    icon: FontAwesomeIcons.cakeCandles,
                    text: "Birthday",
                    onPressed: () {},
                  ),
                  TypeOfEventCard(
                    icon: FontAwesomeIcons.champagneGlasses,
                    text: "Celebration",
                    onPressed: () {},
                  ),
                  TypeOfEventCard(
                    icon: FontAwesomeIcons.peopleGroup,
                    text: "Get Together",
                    onPressed: () {},
                  ),
                  TypeOfEventCard(
                    icon: FontAwesomeIcons.listDots,
                    text: "Others",
                    onPressed: () {
                      setState(() {
                        showOthersInput = !showOthersInput;
                      });
                      // print("Others");
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 15.w,
                child: Container(
                    margin: EdgeInsets.only(top: 50.h),
                    child: MyIconButton(
                        onPressed: () => {
                              Navigator.pushNamed(context, "/fillEventDetails"),
                            },
                        icon: FontAwesomeIcons.arrowRight)),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class TypeOfEventCard extends StatelessWidget {
  IconData icon;
  Function onPressed;
  String text;
  TypeOfEventCard(
      {required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: () => onPressed(),
      style: NeumorphicStyle(
        shadowDarkColor: Colors.white,
        shadowLightColor: Colors.white,
        depth: 1,
        color: Colors.black,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FaIcon(
          icon,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          '$text',
          style: textStyle.copyWith(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
        )
      ]),
    );
    ;
  }
}
