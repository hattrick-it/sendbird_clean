import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import '../../../../domain/entities/chat_channel.dart';
import 'member.dart';
import 'baseMessage.dart';

extension GroupChannelExtension on GroupChannel {
  ChatChannel toDomain() => ChatChannel(
        channelUrl: this.channelUrl,
        coverUrl: this.coverUrl,
        members: this.members.map((e) => e.toDomain()).toList(),
        lastMessage: this.lastMessage.toDomain(),
      );
}

extension BaseChannelExtension on BaseChannel {
  ChatChannel toDomain() => ChatChannel(
        channelUrl: this.channelUrl,
        coverUrl: this.coverUrl,
      );
}