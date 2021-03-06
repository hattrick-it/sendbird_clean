import '../entities/chat_user.dart';

abstract class AuthRepository {
  Future<ChatUser> connect(String userId, String nickname);

  void disconnect();

  void saveUserType(String userType);
}
