import 'package:sendbird_sdk/core/channel/base/base_channel.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';

import '../../../../domain/entities/chat_channel.dart';
import 'baseMessage.dart';
import 'member.dart';

extension GroupChannelExtension on GroupChannel {
  ChatChannel toDomain() => ChatChannel(
        createdAt: this.createdAt != null ? this.createdAt : null,
        channelUrl: this.channelUrl,
        coverUrl: this.coverUrl,
        members: this.members.map((e) => e.toDomain()).toList(),
        lastMessage:
            this.lastMessage != null ? this.lastMessage!.toDomain() : null,
      );
}

extension BaseChannelExtension on BaseChannel {
  ChatChannel toDomain() => ChatChannel(
        createdAt: this.createdAt != null ? this.createdAt : null,
        channelUrl: this.channelUrl,
        coverUrl: this.coverUrl,
      );
}
