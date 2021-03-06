import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import '../../../Core/constants.dart';
import '../../../domain/controllers/login_controller/login_controller.dart';
import '../../../locator/locator.dart';

enum LoginState {
  Empty,
  Loading,
  Loaded,
  Error,
}

final authViewModel =
    ChangeNotifierProvider<AuthViewModel>((ref) => locator.get());

class AuthViewModel extends ChangeNotifier {
  final LoginController loginController;

  AuthViewModel({required this.loginController});

  // Properties
  LoginState _loginState = LoginState.Empty;

  // Getters
  LoginState get getState => _loginState;

  // Setters
  void _setLoginState(LoginState state) {
    _loginState = state;
    notifyListeners();
  }

  // Private Methods

  // Public Methods
  Future<ChatUser> connect(
      String userId, String nickname, String userType) async {
    try {
      _setLoginState(LoginState.Loading);
      loginController.saveUserType(userType);
      var chatUser = await loginController.connect(userId, nickname);

      _setLoginState(LoginState.Loaded);
      return chatUser;
    } catch (e) {
      _setLoginState(LoginState.Error);
      throw Exception(e);
    } finally {
      _setLoginState(LoginState.Empty);
    }
  }

  Future<void> loginPatient() async {
    try {
      await connect(
        Constants.patientId,
        Constants.patientNickname,
        Constants.patientType,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> loginDoctor() async {
    try {
      await connect(
        Constants.doctorId,
        Constants.doctorNickname,
        Constants.doctorType,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ChatUser> connectAdmin(
      String userId, String nickname, String userType) async {
    try {
      loginController.saveUserType(userType);
      return await loginController.connect(
        userId,
        nickname,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
