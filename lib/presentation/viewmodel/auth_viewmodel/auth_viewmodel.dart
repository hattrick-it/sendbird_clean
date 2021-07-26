import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/Core/constants.dart';
import '../../../domain/controllers/login_controller/login_controller.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../locator/locator.dart';

enum LoginState {
  Empty,
  Loading,
  Loaded,
  Error,
  PatientLoaded,
  DoctorLoaded,
}

final authViewModel =
    ChangeNotifierProvider<AuthViewModel>((ref) => locator.get());

class AuthViewModel extends ChangeNotifier {
  final LoginController loginController;

  AuthViewModel({this.loginController});

  // Properties
  var _userId = '';
  var _nickname = '';
  LoginState _loginState = LoginState.Empty;

  // Getters
  LoginState get getState => _loginState;

  // Setters
  set setUserId(String userid) {
    _userId = userid;
  }

  set setNickname(String nickname) {
    _nickname = nickname;
  }

  void _setLoginState(LoginState state) {
    _loginState = state;
    notifyListeners();
  }

  // Private Methods

  // Public Methods
  Future<void> connect(
      String userId, String nickname, String userType) async {
    try {
      _setLoginState(LoginState.Loading);
      loginController.saveUserType(userType);
      await loginController.connect(userId, nickname);
      _setLoginState(LoginState.Loaded);
    } catch (e) {
      _setLoginState(LoginState.Error);
      throw Exception(e);
    }
  }


}
