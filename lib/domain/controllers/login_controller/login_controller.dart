import '../../repositories/auth_repository.dart';
import '../../entities/chat_user.dart';

class LoginController {
  final AuthRepository authRepository;

  LoginController({this.authRepository});

  Future<void> connect(String userId, String nickname) async {
    try {
      await authRepository.connect(userId, nickname);
    } catch (e) {
      throw Exception(e);
    }
  }

  void saveUserType(String userType) {
    authRepository.saveUserType(userType);
  }
}
