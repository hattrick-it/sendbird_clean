import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../../main.dart';

class SendbirdChannelsDataSource extends ChannelEventHandler {
  StreamController<BaseMessage> _messageStreamController;
  StreamController<BaseChannel> _channelsStreamController;

  SendbirdChannelsDataSource() {
    _messageStreamController = StreamController<BaseMessage>(
        onListen: () =>
            sendbird.addChannelEventHandler('channel_event_handler', this),
        onCancel: () =>
            sendbird.removeChannelEventHandler('channel_event_handler'));

    _channelsStreamController = StreamController<BaseChannel>(
        onListen: () => sendbird.addChannelEventHandler('base_channel', this),
        onCancel: () => sendbird.removeChannelEventHandler('base_channel'));
  }


  Stream<BaseMessage> get onNewMsg => _messageStreamController.stream;

  Stream<BaseChannel> get onChannelMsg => _channelsStreamController.stream;

  void closeStream() {
    _messageStreamController.close();
    _channelsStreamController.close();
  }

  // ChannelEventHandler methods
  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    print(message.message);
    _messageStreamController.sink.add(message);
  }

  void onChannelChanged(BaseChannel channel) {
    // todo add stream nuevo para channel changes
    _channelsStreamController.sink.add(channel);
    print(channel);
  }

  // Methods
  Future<List<User>> getUsers() {
    try {
      final query = ApplicationUserListQuery();
      return query.loadNext();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GroupChannel> createChannel(List<String> userIds) {
    try {
      final params = GroupChannelParams()..userIds = userIds;
      return GroupChannel.createChannel(params);
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
    GroupChannel groupChannel;
    for (var item in channels) {
      if (item.channelUrl == channelUrl) {
        groupChannel = item;
      }
    }
    return groupChannel;
  }

  Future<User> getCurrentUser() async {
    return sendbird.currentUser;
  }
}
