class ChatUser {
  String userId;
  String nickname;
  String profileUrl;
  bool isActive;
  bool isOnline;
  int lastSeenAt;
  ChatUser({
    this.userId,
    this.nickname,
    this.profileUrl,
    this.isActive,
    this.lastSeenAt, isOnline,
  });
}
