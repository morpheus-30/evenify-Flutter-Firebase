import "package:flutter/material.dart";
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:sizer/sizer.dart";
import 'package:temp_flutter_proj/components/NeumorphicTextField.dart';
import 'package:temp_flutter_proj/components/iconButton.dart';
import 'package:temp_flutter_proj/constants.dart';

class AccountDetails extends StatefulWidget {
  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  bool _showTextField = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Container(),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "Account Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          _showTextField
              ? NeumorphicButton(
                  onPressed: () => {
                    setState(() {
                      _showTextField = !_showTextField;
                    })
                  },
                  padding: EdgeInsets.all(10),
                  style: NeumorphicStyle(
                      color: Colors.black,
                      depth: 5,
                      shadowDarkColor: Colors.white,
                      shadowLightColor: Colors.white),
                  child: Text(
                    "Morpheus Valorant",
                    style: textStyle.copyWith(
                        color: Colors.white, fontSize: 20.sp),
                  ),
                )
              : Row(
                  children: [
                    SizedBox(
                      width: 65.w,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                            color: Colors.black,
                            depth: 1,
                            shadowDarkColor: Colors.white,
                            shadowLightColor: Colors.white),
                        child: TextFormField(
                          autofocus: true,
                          cursorColor: Colors.white,
                          onEditingComplete: () {
                            setState(() {
                              _showTextField = !_showTextField;
                            });
                          },
                          initialValue: "Morpheus Valorant",
                          decoration: InputDecoration(
                            hintStyle: textStyle.copyWith(
                                color: Colors.white, fontSize: 20.sp),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(
                              color: Colors.white, fontSize: 20.sp),
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      onPressed: () => {},
                      child: NeumorphicIcon(FontAwesomeIcons.rightFromBracket),
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        color: Colors.black,
                        depth: 1,
                        shadowDarkColor: Colors.white,
                        shadowLightColor: Colors.white,
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
