// import 'package:provider/provider.dart';
// import 'package:temp_flutter_proj/components/contactTray.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:temp_flutter_proj/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:contacts_service/contacts_service.dart';
// import 'package:temp_flutter_proj/partilyContacts.dart';
import 'package:temp_flutter_proj/components/iconButton.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:temp_flutter_proj/components/NeumorphicTextField.dart';

Future<List<Contact>> getcontacts() async {
  List<Contact> contacts = await ContactsService.getContacts();
  return contacts;
}

class FillEventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: NeumorphicTextField(
              hintText: "Enter the name of the event",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: NeumorphicTextField(
              type: TextInputType.phone,
              hintText: "Enter your Phone Number",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: NeumorphicTextField(
              type: TextInputType.emailAddress,
              hintText: "Enter your email address",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: NeumorphicTextField(
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
                  print(date);
                },
                icon: FontAwesomeIcons.calendar,
              ),
              MyIconButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  print(time.toString());
                },
                icon: FontAwesomeIcons.clock,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 4.h),
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
                style: textStyle.copyWith(color: Colors.white, fontSize: 20.sp),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/createEventFinalScreen');
              },
            ),
          )
        ],
      ),
    );
  }
}

