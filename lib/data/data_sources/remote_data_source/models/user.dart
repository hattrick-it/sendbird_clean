import 'package:sendbird_sdk/sendbird_sdk.dart';
import '../../../../domain/entities/chat_user.dart';

extension UserExtension on User {
  ChatUser toDomain() => ChatUser(
        userId: this.userId,
        nickname: this.nickname,
        profileUrl: this.profileUrl,
        isActive: this.isActive,
        lastSeenAt: this.lastSeenAt,
        metadata: this.metaData,
      );
}
