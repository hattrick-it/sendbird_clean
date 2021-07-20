import 'chat_user.dart';

class ChatDoctor extends ChatUser {
  @override
  String userId;

  @override
  String nickname;

  @override
  String profileUrl;

  @override
  bool isActive;

  @override
  bool isOnline;

  @override
  int lastSeenAt;

  @override
  Map<String, String> metadata;

  String specialty;

  ChatDoctor({
    this.userId,
    this.nickname,
    this.profileUrl,
    this.isActive,
    this.isOnline,
    this.lastSeenAt,
    this.metadata,
    this.specialty,
  });
}
