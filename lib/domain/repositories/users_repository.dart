import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

abstract class UsersRepository {
  Future<List<ChatUser>> getUsers();

  ChatUser getCurrentUser();

}