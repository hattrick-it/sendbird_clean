import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/use_cases/login_use_case/login_use_case.dart';

import 'auth_states.dart';

final authNotifierProvider = StateNotifierProvider((ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthInitial());

  LoginUseCase _loginUseCase = LoginUseCase();

  var _userId = '';
  var _nickname = '';

  set setUserId(String userid) {
    _userId = userid;
  }

  set setNickname(String nickname) {
    _nickname = nickname;
  }

  // Future<void> connect(String userId, String nickname) async {
  Future<void> connect() async {
    state = AuthInitial();
    try {
      state = AuthLoading();
      var chatUser = await _loginUseCase.connect(_userId, _nickname);
      state = AuthLoaded(chatUser);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}
