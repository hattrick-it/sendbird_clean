import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

import '../../../../main.dart';

extension SendbirdBaseMessageExtension on BaseMessage {
  ChatMessage toDomain() => ChatMessage(
        createdAt: this.createdAt,
        data: this.data,
        messageId: this.messageId,
        message: this.message,
        channelUrl: this.channelUrl,
        sender: this.sender != null ? this.sender.senderToUser() : ChatUser(userId: ''),
      );
}

extension SenderData on Sender {
  ChatUser senderToUser() => ChatUser(
        userId: this.userId,
        nickname: this.nickname,
        profileUrl: this.profileUrl,
      );
}

extension myMessage on ChatMessage {
  bool get isMyMessage => sender?.userId == sendbird.currentUser.userId;
}