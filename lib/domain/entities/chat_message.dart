import 'chat_user.dart';

enum MsgSendingStatus { none, pending, failed, succeeded, canceled }

class ChatMessage {
  int createdAt;
  String requestId;
  String data;
  int messageId;
  String type;
  List<ChatUser> mentionedUsers;
  String channelUrl;
  String message;
  ChatUser sender;
  MsgSendingStatus sendingStatus;

  ChatMessage({
    this.createdAt,
    this.requestId,
    this.data,
    this.messageId,
    this.type,
    this.mentionedUsers,
    this.channelUrl,
    this.message,
    this.sender,
    this.sendingStatus,
  });
}
