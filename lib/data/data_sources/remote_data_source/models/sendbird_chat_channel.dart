import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';

extension SendbirdChatChannelExtension on BaseChannel {
  ChatChannel toDomain() => ChatChannel(
        data: this.data,
        name: this.name,
        url: this.channelUrl,
        coverUrl: this.coverUrl,
      );
}
