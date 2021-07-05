import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/controllers/login_controller/login_controller.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

final authNotifierProvider =
    ChangeNotifierProvider<AuthViewModel>((ref) => locator.get());

enum AuthStates {
  Empty,
  Loading,
  Loaded,
  Error,
}

class AuthViewModel extends ChangeNotifier {
  final LoginController loginController;

  AuthViewModel({this.loginController});

  // Properties
  var _userId = '';
  var _nickname = '';
  AuthStates _authState = AuthStates.Empty;

  // Setters
  set setUserId(String userid) {
    _userId = userid;
  }

  set setNickname(String nickname) {
    _nickname = nickname;
  }

  // Getters
  AuthStates get getAuthState => _authState;

  // Private Methods
  void _setStatus(AuthStates state) {
    _authState = state;
    notifyListeners();
  }

  // Public Methods
  Future<ChatUser> connect(String userId, String nickname) async {
    try {
      // _setStatus(AuthStates.Loading);
      var chatUser = await loginController.connect(userId, nickname);
      if (chatUser != null) {
        // _setStatus(AuthStates.Loaded);
        return chatUser;
      } else {
        return null;
      }
    } catch (e) {
      // _setStatus(AuthStates.Error);
      throw Exception(e);
    }
  }
}
