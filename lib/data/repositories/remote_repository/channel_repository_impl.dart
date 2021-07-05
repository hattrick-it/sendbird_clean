import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_channels_remote_data_source.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/repositories/channel_repository.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_group_channel.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_user.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/sendbird_base_message.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final SendbirdChannelsDataSource sendbirdChannelsDataSource;
  ChannelRepositoryImpl({this.sendbirdChannelsDataSource});

  @override
  void createChannel(String userId) {
    List<String> userIds = [];
    User current = sendbirdChannelsDataSource.getCurrentUser();
    userIds.add(current.userId);
    userIds.add(userId);
    sendbirdChannelsDataSource.createChannel(userIds);
  }

  void getChatChannel() {
    // TODO: implement getChatChannel
    throw UnimplementedError();
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
  ChatUser getCurrentUser()  {
    return sendbirdChannelsDataSource.getCurrentUser().toDomain();
  }
}
