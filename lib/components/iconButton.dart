import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyIconButton extends StatelessWidget {
  MyIconButton({required this.onPressed, required this.icon});
  Function onPressed;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        depth: 1,
        shadowDarkColor: Colors.white,
        boxShape: NeumorphicBoxShape.circle(),
        color: Colors.white,
      ),
      onPressed: () {
        onPressed();
      },
      child: Center(
        child: FaIcon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
