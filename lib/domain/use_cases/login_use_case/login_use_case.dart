import 'package:sendbirdtutorial/domain/repositories/user_repository.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

import '../../entities/chat_user.dart';

class LoginUseCase {
  static final LoginUseCase _chatLoginCaseSingleton = LoginUseCase._internal();
  factory LoginUseCase() {
    return _chatLoginCaseSingleton;
  }
  LoginUseCase._internal();

  final AuthRepository _userRespository = locator.get<AuthRepository>();

  Future<ChatUser> connect([String userId, String nickname]) async {
    try {
      return await _userRespository.connect(userId, nickname);
    } catch (e) {
      throw Exception(e);
    }
  }
}
