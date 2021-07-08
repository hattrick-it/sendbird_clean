import 'package:flutter/material.dart';
import '../presentation/screens/channels_list/channels_list_screen.dart';
import '../presentation/screens/chat_screen/chat_screen.dart';
import '../presentation/screens/doctor_selector_screen/doctor_selector_screen.dart';
import '../presentation/screens/patient_selector_screen/patient_selector_screen.dart';
import '../presentation/screens/user_selection_screen/user_selection_screen.dart';
import '../presentation/screens/user_type_selector_screen/user_type_selector_screen.dart';
import '../presentation/screens/users_list_screen/users_list.dart';

class MyRoutes {
  var routes = <String, WidgetBuilder>{
    ChannelListScreen.routeName: (context) => ChannelListScreen(),
    UsersListScreen.routeName: (context) => UsersListScreen(),
    ChatScreen.routeName: (context) => ChatScreen(),
    UserSelectorScreen.routeName: (context) => UserSelectorScreen(),
    DoctorSelectorScreen.routeName: (context) => DoctorSelectorScreen(),
    PatientSelectorScreen.routeName: (context) => PatientSelectorScreen(),
    UserSelectionScreen.routeName: (context) => UserSelectionScreen(),
  };
}
