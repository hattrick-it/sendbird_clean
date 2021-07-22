import 'chat_message.dart';

import 'chat_user.dart';

class ChatChannel {
  String coverUrl;
  String channelUrl;
  List<ChatUser> members;
  ChatMessage lastMessage;
  int createdAt;

  ChatChannel({
    this.coverUrl,
    this.channelUrl,
    this.members,
    this.lastMessage,
    this.createdAt,
  });
}
