import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

const textColor = Color(0xFF5B5B5B);
const uiWhite = Color(0xFFEBF3FF);
const uiPink = Color(0xFFFFB5D0);

InputDecoration loginInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.white60, fontFamily: "Lato"),
  hintText: "Enter your email",
  contentPadding: EdgeInsets.all(10),
  border: OutlineInputBorder(
    // borderSide: BorderSide(color: uiWhite, width: 1),
    borderRadius: BorderRadius.circular(20),
  ),
  enabledBorder: OutlineInputBorder(
    // borderSide: BorderSide(color: uiWhite, width: 1),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: uiWhite, width: 1),
    borderRadius: BorderRadius.circular(20),
  ),
);

const textStyle = TextStyle(
  fontSize: 15,
  fontFamily: "Lato",
  color: textColor,
);
var backgroundDecoration = DecorationImage(
  fit: BoxFit.fill,
  image: AssetImage("images/bg.jpeg"),
);
