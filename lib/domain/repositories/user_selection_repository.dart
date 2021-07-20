import '../entities/chat_user.dart';

abstract class UserSelectionRepository {
  Future<List<ChatUser>> getUsersByType(String userType);
}
