import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:temp_flutter_proj/Screens/MyEventsScreen.dart';
import 'package:temp_flutter_proj/Screens/createEvent/FillEventDetails.dart';
import 'package:temp_flutter_proj/Screens/EventDetailsScreen.dart';
import 'package:temp_flutter_proj/Screens/LoginScreen.dart';
import 'package:temp_flutter_proj/Screens/WelcomeScreen.dart';
// import 'package:temp_flutter_proj/partilyContacts.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/EventsScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'Screens/createEvent/typeOfEvent.dart';
import "Screens/JoinAnEvent.dart";
import "Screens/AccountDetails.dart";
// import "package:temp_flutter_proj/Screens/createEvent/CreateEventFinalScreen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Partily());
}

class Partily extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, devicetype) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            "/": (context) => WelcomeScreen(),
            "/login": (context) => LoginScreen(),
            "/register": (context) => RegisterScreen(),
            "/main": (context) => EventsScreen(),
            "/typeOfEvent": ((context) => TypeOfEvent()),
            "/joinAnEvent": (context) => JoinAnEvent(),
            // "/createEventFinalScreen": (context) => CreateEventFinalScreen(),
            "/accountDetails": (context) => AccountDetails(),
            "/myEvents": (context) => MyEventsScreen(),
          },
        );
      },
    );
  }
}
