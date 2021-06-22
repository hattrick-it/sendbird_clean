import 'package:flutter/material.dart';
import 'package:sendbirdtutorial/presentation/screens/channels_list/channels_list_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/chat_screen/chat_screen.dart';
import 'package:sendbirdtutorial/presentation/screens/users_list_screen/users_list.dart';
import '../presentation/screens/login_screen/login_screen.dart';

class MyRoutes {
  var routes = <String, WidgetBuilder>{
    '/': (context) => LoginScreen(),
    '/channel-list': (context) => ChannelListScreen(),
    '/users-list-screen': (context) => UsersListScreen(),
    '/chat-screen': (context) => ChatScreen(),
  };
}
