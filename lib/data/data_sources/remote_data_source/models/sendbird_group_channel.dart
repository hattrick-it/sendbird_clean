import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbirdtutorial/domain/entities/chat_group_channel.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_base_message.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_chat_member.dart';

extension SendbirdGroupChannelExtension on GroupChannel {
  ChatGroupChannel toDomain() => ChatGroupChannel(
        lastMessage: this.lastMessage.toDomain(),
        unreadMessageCount: this.unreadMessageCount,
        members: this.members.map((e) => e.toDomain()),
      );
}
