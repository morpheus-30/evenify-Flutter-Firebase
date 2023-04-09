// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:temp_flutter_proj/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    final _auth = FirebaseAuth.instance;
    String password = "123456";
    String email = "nakshatrachandna@gmail.com";
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: _load
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
                          "Logging you in!",
                          style: textStyle.copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Column(
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
                            style: textStyle.copyWith(
                                fontSize: 12, color: Colors.white60),
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
                            controller: emailcontroller,
                            style: textStyle.copyWith(color: Colors.white),
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
                          style: NeumorphicStyle(
                            depth: 0,
                            color: Colors.black,
                          ),
                          child: TextField(
                            style: textStyle.copyWith(color: Colors.white),
                            controller: passwordcontroller,
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
                        style: NeumorphicStyle(color: Colors.white, depth: 2),
                        onPressed: () async {
                          try {
                            setState(() {
                              _load = true;
                            });
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              emailcontroller.clear();
                              passwordcontroller.clear();
                              Navigator.pushReplacementNamed(context, "/main");
                            }
                          } catch (e) {
                            setState(() {
                              _load = false;
                            });
                            print(e);
                          }
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Lato",
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: Container(
                          height: 1.0,
                          width: 230.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text("New to Evenify? Register with us!",
                            style: textStyle.copyWith(
                                fontSize: 16, color: Colors.white60)),
                      ),
                      NeumorphicButton(
                        style: NeumorphicStyle(
                            color: Colors.white,
                            depth: 2,
                            shadowDarkColor: Colors.black),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/register");
                        },
                        child: Text(
                          "Register Now!",
                          style: textStyle.copyWith(
                              fontSize: 20, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
