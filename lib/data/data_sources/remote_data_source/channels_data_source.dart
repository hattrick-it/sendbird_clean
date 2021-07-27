import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';

class ChannelsDataSource extends ChannelEventHandler {
  final SendbirdSdk sendbird;

  StreamController<BaseMessage> _messageStreamController;
  StreamController<BaseChannel> _channelsStreamController;

  ChannelsDataSource({this.sendbird}) {
    _messageStreamController = StreamController<BaseMessage>();

    _channelsStreamController = StreamController<GroupChannel>(
        onListen: () => sendbird.addChannelEventHandler(
            StringConstants.channelHandlerKey, this),
        onCancel: () => sendbird
            .removeChannelEventHandler(StringConstants.channelHandlerKey));
  }

  Stream<BaseMessage> get onChannelNewMessage =>
      _messageStreamController.stream;

  Stream<GroupChannel> get onChannelNewChanged =>
      _channelsStreamController.stream;

  void closeStream() {
    _messageStreamController.close();
    _channelsStreamController.close();
  }

  // ChannelEventHandler methods
  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    _messageStreamController.sink.add(message);
  }

  @override
  void onChannelChanged(BaseChannel channel) {
    GroupChannel groupChannel = channel;
    _channelsStreamController.sink.add(groupChannel);
  }

  // Methods
  Future<GroupChannel> createChannel(List<String> userIds) async {
    try {
      final params = GroupChannelParams()
        ..userIds = userIds
        ..isDistinct = true;
      var groupChannel = await GroupChannel.createChannel(params);
      return groupChannel;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<GroupChannel>> getGroupChannels() async {
    try {
      final query = GroupChannelListQuery()
        ..includeEmptyChannel = true
        ..order = GroupChannelListOrder.latestLastMessage
        ..limit = 15;
      return await query.loadNext();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GroupChannel> getGroupChannel(String channelUrl) async {
    List<GroupChannel> channels = await getGroupChannels();
    return channels.firstWhere((element) => element.channelUrl == channelUrl);
  }

  User getCurrentUser() {
    return sendbird.currentUser;
  }

  Future<GroupChannel> getChannelByIds(List<String> usersIds) async {
    try {
      final query = GroupChannelListQuery();
      query.setUserIdsIncludeFilter(
          [usersIds[0], usersIds[1]], GroupChannelListQueryType.and);
      final result = await query.loadNext();
      if (result != null && result.length > 0) {
        return result.first;
      } else {
        var newChannel = await createChannel(usersIds);
        return newChannel;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
