import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/controllers/login_controller/login_controller.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../locator/locator.dart';

final authViewModel =
    ChangeNotifierProvider<AuthViewModel>((ref) => locator.get());

class AuthViewModel extends ChangeNotifier {
  final LoginController loginController;

  AuthViewModel({this.loginController});

  // Properties
  var _userId = '';
  var _nickname = '';

  // Setters
  set setUserId(String userid) {
    _userId = userid;
  }

  set setNickname(String nickname) {
    _nickname = nickname;
  }

  // Getters

  // Private Methods

  // Public Methods
  Future<ChatUser> connect(String userId, String nickname) async {
    try {
      var chatUser = await loginController.connect(userId, nickname);
      if (chatUser != null) {
        return chatUser;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
