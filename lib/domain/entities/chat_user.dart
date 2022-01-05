class ChatUser {
  String? userId;
  String? nickname;
  String? profileUrl;
  bool? isActive;
  bool? isOnline;
  int? lastSeenAt;
  Map<String, String>? metadata;
  ChatUser({
    this.userId,
    this.nickname,
    this.profileUrl,
    this.isActive,
    this.lastSeenAt,
    this.isOnline,
    this.metadata,
  });
}
