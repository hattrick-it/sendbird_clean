import '../entities/chat_user.dart';

abstract class AuthRepository {
  Future<void> connect(String userId, String nickname);

  void disconnect();

  void saveUserType(String userType);
}
