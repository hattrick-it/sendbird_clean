import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

import '../entities/chat_message.dart';

abstract class ChatRepository {
  void setChannelUrl(String channelUrl);

  Stream<ChatMessage> getMessageStream();

  Future<ChatMessage> sendMessage(String message);

  Future<List<ChatMessage>> getMessagesList();

  Future<List<ChatUser>> getUsers();
}
