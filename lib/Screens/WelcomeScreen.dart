// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:temp_flutter_proj/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            
             ),
            child: Column(
              children: [
                SizedBox(height: 350,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Hero(tag: "maintext",
                            child: Text(
                              "EVENIFY",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: "Lato",
                                  color: Colors.white),
                            ),
                          ),
                          Hero(tag: "subtext",
                            child: Text(
                              "All Events, Sorted?",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Lato",
                                  color: Colors.white60),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Hero(tag: "logo",
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
                ),
                SizedBox(height: 145,),
                NeumorphicButton(
                  
                style: NeumorphicStyle(color: Colors.white,depth: 2), 
                onPressed: (){
                  Navigator.pushNamed(context, "/login");
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      fontSize: 20, fontFamily: "Lato", color: Colors.black),
                ),
              )
                
                
              ],
            ),
          ),
     
    );
  }
}
