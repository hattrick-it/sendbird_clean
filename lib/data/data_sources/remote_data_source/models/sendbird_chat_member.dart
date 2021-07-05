import 'package:sendbird_sdk/core/models/member.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

extension MemberExtension on Member {
  ChatUser toDomain() => ChatUser(
        userId: this.userId,
        nickname: this.nickname,
        profileUrl: this.profileUrl,
      );
}
