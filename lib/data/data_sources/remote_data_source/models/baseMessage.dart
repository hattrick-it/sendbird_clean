import 'package:sendbird_sdk/core/message/base_message.dart';
import 'package:sendbird_sdk/core/models/sender.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';
import '../../../../domain/entities/chat_message.dart';
import '../../../../domain/entities/chat_user.dart';
import '../../../../locator/locator.dart';

SendbirdSdk sendbird = locator.get();

extension BaseMessageExtension on BaseMessage {
  ChatMessage toDomain() => ChatMessage(
        createdAt: this.createdAt != null ? this.createdAt : 0,
        data: this.data,
        messageId: this.messageId != null ? this.messageId : null,
        message: this.message != null ? this.message : null,
        channelUrl: this.channelUrl,
        sendingStatus: this.sendingStatus == MessageSendingStatus.pending
            ? MsgSendingStatus.pending
            : MsgSendingStatus.succeeded,
        sender: this.sender != null
            ? this.sender.toDomain()
            : ChatUser(userId: StringConstants.baseMessageAdminKey),
      );
}

extension SenderExtension on Sender {
  ChatUser toDomain() => ChatUser(
        userId: this.userId,
        nickname: this.nickname,
        profileUrl: this.profileUrl,
        metadata: this.metaData,
      );
}

extension ChatMessageExtension on ChatMessage {
  bool get isMyMessage => sender?.userId == sendbird.currentUser.userId;
}
