import 'chat_user.dart';

class ChatMember extends ChatUser {
  String? userId;
  String? nickname;
  String? profileUrl;
  bool? isActive;
  bool? isOnline;
  int? lastSeenAt;
  Map<String, String>? metadata;

  ChatMember({
    this.userId,
    this.nickname,
    this.profileUrl,
    this.metadata,
    this.isOnline,
    this.isActive,
    this.lastSeenAt,
  });
}
