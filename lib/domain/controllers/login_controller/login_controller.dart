import '../../repositories/auth_repository.dart';
import '../../entities/chat_user.dart';

class LoginController {
  final AuthRepository userRespository;

  LoginController({this.userRespository});

  Future<ChatUser> connect([String userId, String nickname]) async {
    try {
      return await userRespository.connect(userId, nickname);
    } catch (e) {
      throw Exception(e);
    }
  }
}
