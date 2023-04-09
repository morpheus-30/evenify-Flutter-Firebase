import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import "package:temp_flutter_proj/constants.dart";

class NeumorphicTextField extends StatelessWidget {
  String hintText;
  int maxLength;
  final type;
  NeumorphicTextField({required this.hintText,this.type,this.maxLength=20});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 0,
        color: Colors.black,
      ),
      child: TextField(
        maxLength: maxLength,
        keyboardType: type==null?TextInputType.text:type,
        style: textStyle.copyWith(color: Colors.white),
        decoration: loginInputDecoration.copyWith(hintText: "$hintText"),
        onChanged: (value) {},
      ),
    );
  }
}
