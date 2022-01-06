import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../../domain/entities/chat_channel.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../domain/repositories/channel_repository.dart';
import '../../data_sources/remote_data_source/channels_data_source.dart';
import '../../data_sources/remote_data_source/models/baseMessage.dart';
import '../../data_sources/remote_data_source/models/groupChannel.dart';
import '../../data_sources/remote_data_source/models/user.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelsDataSource channelsDataSource;
  ChannelRepositoryImpl({required this.channelsDataSource});

  @override
  Future<ChatChannel> createChannel(String userId) async {
    List<String> usersIds = [];
    usersIds.add(getCurrentUser().userId!);
    usersIds.add(userId);
    var groupChannel = await channelsDataSource.createChannel(usersIds);
    return groupChannel.toDomain();
  }

  @override
  Future<List<ChatChannel>> getChannels() async {
    List<GroupChannel> groupChannelList =
        await channelsDataSource.getGroupChannels();
    return groupChannelList.map((e) => e.toDomain()).toList();
  }

  @override
  Stream<ChatMessage> getMessageStream() {
    return channelsDataSource.onChannelNewMessage
        .map((basemessage) => basemessage.toDomain());
  }

  @override
  Stream<ChatChannel> getChannelsStream() {
    return channelsDataSource.onChannelNewChanged
        .map((groupchannel) => groupchannel.toDomain());
  }

  @override
  ChatUser getCurrentUser() {
    var currentUser = channelsDataSource.getCurrentUser()!.toDomain();
    return currentUser;
  }

  @override
  Future<ChatChannel> getChannelByIds(String userId) async {
    try {
      var currentUser = getCurrentUser();
      var currentUserId = currentUser.userId;
      List<String> usersIds = [currentUserId!, userId];
      var groupChannel = await channelsDataSource.getChannelByIds(usersIds);
      return groupChannel.toDomain();
    } catch (e) {
      throw Exception(e);
    }
  }
}
