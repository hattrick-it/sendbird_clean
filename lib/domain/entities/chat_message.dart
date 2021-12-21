import 'chat_user.dart';

class ChatMessage {
  int? createdAt;
  String? data;
  int? messageId;
  String? type;
  List<ChatUser>? mentionedUsers;
  String? channelUrl;
  String? message;
  ChatUser? sender;

  ChatMessage({
    this.createdAt,
    this.data,
    this.messageId,
    this.type,
    this.mentionedUsers,
    this.channelUrl,
    this.message,
    this.sender,
  });
}
