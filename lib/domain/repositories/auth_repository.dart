import '../entities/chat_user.dart';

abstract class AuthRepository {
  Future<void> connect(String userId, String nickname);

  void disconnect();

  Future<void> saveUserType(String userType);
}
