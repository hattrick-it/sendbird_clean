import 'package:flutter/material.dart';

import '../presentation/screens/channels_list/channels_list_screen.dart';
import '../presentation/screens/chat_screen/chat_screen.dart';
import '../presentation/screens/doctors_list_screen/doctor_list_screen.dart';
import '../presentation/screens/patients_list_screen/patients_list_screen.dart';
import '../presentation/screens/welcome_screen/welcome_screen.dart';

class MyRoutes {
  var routes = <String, WidgetBuilder>{
    ChannelListScreen.routeName: (context) => ChannelListScreen(),
    PatientsListScreen.routeName: (context) => PatientsListScreen(),
    ChatScreen.routeName: (context) => ChatScreen(),
    WelcomeScreen.routeName: (context) => WelcomeScreen(),
    DoctorListScreen.routeName: (context) => DoctorListScreen(),
  };
}
