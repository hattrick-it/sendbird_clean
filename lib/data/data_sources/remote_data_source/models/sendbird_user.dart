

import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

extension SendbirdUserExtension on User{
  ChatUser toDomain() =>
      ChatUser(
        userId: this.userId,
        nickname: this.nickname,
        profileUrl: this.profileUrl,
        isActive: this.isActive,
        lastSeenAt: this.lastSeenAt,
      );
}
