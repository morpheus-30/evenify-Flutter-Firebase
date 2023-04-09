// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:firebase_core/firebase_core.dart';
import 'package:temp_flutter_proj/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _load = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    String password = "";
    String email = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _load
          ? SizedBox(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          color: Colors.white, backgroundColor: Colors.black),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Registering you!",
                        style: textStyle.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "EVENIFY",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: "Lato",
                                  color: Colors.white),
                            ),
                            Text(
                              "All Events, Sorted?",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Lato",
                                  color: Colors.white60),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Hero(
                          tag: "logo",
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Image(
                              image: AssetImage("images/ION.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 300,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              depth: 0,
                              color: Colors.black,
                            ),
                            child: TextField(
                              style: TextStyle(
                                  fontFamily: "Lato", color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: loginInputDecoration.copyWith(
                                  hintText: "Enter your Email"),
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: Neumorphic(
                            style:
                                NeumorphicStyle(color: Colors.black, depth: 0),
                            child: TextField(
                              style: textStyle.copyWith(
                                  fontFamily: "Lato", color: Colors.white),
                              obscureText: true,
                              decoration: loginInputDecoration.copyWith(
                                  hintText: "Enter your password"),
                              onChanged: (value) => password = value,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        NeumorphicButton(
                          style: NeumorphicStyle(color: Colors.white, depth: 1),
                          onPressed: () async {
                            try {
                              setState(() {
                                _load = true;
                              });
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              
                              if (newUser != null) {
                                Navigator.pushReplacementNamed(context, "/main");
                              }
                            } catch (e) {
                              setState(() {
                                _load = false;
                              });
                              print(e);
                            }
                            await _firestore.collection("Users").doc(email).set({});
                            await _firestore.collection("Users").doc(email).collection("MyEvents").doc().set({});
                            await _firestore.collection("Users").doc(email).collection("EventsInvited").doc().set({});
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Lato",
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
    );
  }
}
