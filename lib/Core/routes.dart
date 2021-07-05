import 'package:flutter/material.dart';
import 'package:sendbirdtutorial/presentation/screens/channels_list/channels_list_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/chat_screen/chat_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/doctor_selector_screen/doctor_selector_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/patient_selector_screen/patient_selector_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/user_selection_screen/user_selection_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/user_type_selector_screen/user_type_selector_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/users_list_screen/users_list.dart';

class MyRoutes {
  var routes = <String, WidgetBuilder>{
    '/channel-list': (context) => ChannelListScreen(),
    '/users-list-screen': (context) => UsersListScreen(),
    '/chat-screen': (context) => ChatScreen(),
    '/user-type-selector': (context) => UserSelectorScreen(),
    '/doctor-selector': (context) => DoctorSelectorScreen(),
    '/patient-selector': (context) => PatientSelectorScreen(),
    '/user-selection-screen': (context) => UserSelectionScreen(),
  };
}
