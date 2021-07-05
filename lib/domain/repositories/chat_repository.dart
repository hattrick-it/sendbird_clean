import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

import '../entities/chat_channel.dart';

abstract class ChatRepository {
  void setChannelUrl(String channelUrl);

  Stream<List<ChatMessage>> getMessageStream();

  Future<List<ChatUser>> getUsers();

  ChatUser getCurrentUser();

  Future<void> sendMessage(String message);

  Future<List<ChatMessage>> getMessagesList();
}
