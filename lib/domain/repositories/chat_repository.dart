import '../entities/chat_message.dart';
import '../entities/chat_user.dart';

import '../entities/chat_channel.dart';

abstract class ChatRepository {
  void setChannelUrl(String channelUrl);

  Stream<ChatMessage> getMessageStream();

  Stream<ChatMessage> getSendMessageStream();

  Future<ChatMessage> sendMessage(String message);

  Future<List<ChatMessage>> getMessagesList();
}
