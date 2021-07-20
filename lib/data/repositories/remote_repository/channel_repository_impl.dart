import 'package:sendbird_sdk/sendbird_sdk.dart';
import '../../data_sources/remote_data_source/channels_data_source.dart';
import '../../../domain/entities/chat_channel.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/channel_repository.dart';
import '../../data_sources/remote_data_source/models/groupChannel.dart';
import '../../data_sources/remote_data_source/models/user.dart';
import '../../data_sources/remote_data_source/models/baseMessage.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelsDataSource sendbirdChannelsDataSource;
  ChannelRepositoryImpl({this.sendbirdChannelsDataSource});

  @override
  void createChannel(List<String> userIds) {
    sendbirdChannelsDataSource.createChannel(userIds);
  }

  @override
  Future<List<ChatChannel>> getChannels() async {
    List<GroupChannel> groupChannelList =
        await sendbirdChannelsDataSource.getGroupChannels();
    return groupChannelList.map((e) => e.toDomain()).toList();
  }

  @override
  Stream<ChatMessage> getMessageStream() {
    return sendbirdChannelsDataSource.onChannelNewMessage
        .map((basemessage) => basemessage.toDomain());
  }

  @override
  Stream<ChatChannel> getChannelsStream() {
    return sendbirdChannelsDataSource.onChannelNewChanged
        .map((groupchannel) => groupchannel.toDomain());
  }

  @override
  ChatUser getCurrentUser() {
    return sendbirdChannelsDataSource.getCurrentUser().toDomain();
  }
}
