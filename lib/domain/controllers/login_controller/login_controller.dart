import '../../entities/chat_user.dart';
import '../../repositories/auth_repository.dart';

class LoginController {
  final AuthRepository authRepository;

  LoginController({this.authRepository});

  Future<ChatUser> connect(String userId, String nickname) {
    try {
      return authRepository.connect(userId, nickname);
    } catch (e) {
      throw Exception(e);
    }
  }

  void saveUserType(String userType) {
    authRepository.saveUserType(userType);
  }
}
