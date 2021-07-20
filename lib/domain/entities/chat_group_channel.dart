import 'chat_message.dart';
import 'chat_user.dart';

class ChatGroupChannel {
  ChatMessage lastMessage;
  int unreadMessageCount;
  List<ChatUser> members;
  int myLastRead;
  String coverUrl;
  ChatUser inviter;

  ChatGroupChannel({
    this.lastMessage,
    this.unreadMessageCount,
    this.members,
    this.myLastRead,
    this.inviter,
    this.coverUrl,
  });
}
