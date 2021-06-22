import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/use_cases/login_use_case/login_use_case.dart';

final authNotifierProvider =
ChangeNotifierProvider.autoDispose((ref) => AuthNotifier());

enum AuthStates {
  Empty,
  Loading,
  Loaded,
  Error,
}

class AuthNotifier extends ChangeNotifier {
  LoginUseCase _loginUseCase = LoginUseCase();

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
  Future<void> connect() async {
    try {
      _setStatus(AuthStates.Loading);
      var chatUser = await _loginUseCase.connect(_userId, _nickname);
      if (chatUser != null) {
        _setStatus(AuthStates.Loaded);
      }
    } catch (e) {
      _setStatus(AuthStates.Error);
      throw Exception(e);
    }
  }
}
