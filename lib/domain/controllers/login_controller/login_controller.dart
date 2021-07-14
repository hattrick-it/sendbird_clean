import '../../repositories/auth_repository.dart';
import '../../entities/chat_user.dart';

class LoginController {
  final AuthRepository authRepository;

  LoginController({this.authRepository});

  Future<void> connect(String userId, String nickname) async {
    print('ADMIN CONNECT EN Controller');
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
