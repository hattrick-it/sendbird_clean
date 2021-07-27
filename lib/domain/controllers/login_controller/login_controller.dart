import '../../repositories/auth_repository.dart';

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

  Future<void> saveUserType(String userType) async {
    await authRepository.saveUserType(userType);
  }
}
