import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

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