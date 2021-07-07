import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/controllers/login_controller/login_controller.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../locator/locator.dart';

enum AuthState {
  Error,
  Loading,
  Loaded,
  Empty,
}

final authViewModel =
    ChangeNotifierProvider<AuthViewModel>((ref) => locator.get());

class AuthViewModel extends ChangeNotifier {
  final LoginController loginController;

  AuthViewModel({this.loginController});

  // Properties
  var _userId = '';
  var _nickname = '';
  AuthState _authState = AuthState.Empty;

  // Setters
  set setUserId(String userid) {
    _userId = userid;
  }

  set setNickname(String nickname) {
    _nickname = nickname;
  }

  void _setState(AuthState state) {
    _authState = state;
    notifyListeners();
  }

  // Getters
  AuthState get getAuthState => _authState;

  // Private Methods

  // Public Methods
  Future<void> connect(String userId, String nickname) async {
    try {
      _setState(AuthState.Loading);
      var chatUser = await loginController.connect(userId, nickname);
      if (chatUser != null) {
        _setState(AuthState.Loaded);
        return chatUser;
      } else {
        return null;
      }
    } catch (e) {
      _setState(AuthState.Error);
      throw Exception(e);
    }
  }

  Future<void> adminConnect(String userId, String nickname) async {
    var chatUser = await loginController.connect(userId, nickname);
  }
}
