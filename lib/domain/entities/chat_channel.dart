import 'chat_message.dart';

import 'chat_user.dart';

class ChatChannel {
  ChatMessage lastMessage;
  String coverUrl;
  String channelUrl;
  List<ChatUser> members;
  int createdAt;

  ChatChannel({
    this.coverUrl,
    this.channelUrl,
    this.members,
    this.lastMessage,
    this.createdAt,
  });
}
