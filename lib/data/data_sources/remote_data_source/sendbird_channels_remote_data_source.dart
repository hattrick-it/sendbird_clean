import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';

class SendbirdChannelsDataSource extends ChannelEventHandler {
  final SendbirdSdk sendbird;

  StreamController<BaseMessage> _messageStreamController;
  StreamController<BaseChannel> _channelsStreamController;

  SendbirdChannelsDataSource({this.sendbird}) {
    _messageStreamController = StreamController<BaseMessage>();

    _channelsStreamController = StreamController<GroupChannel>(
        onListen: () => sendbird.addChannelEventHandler('base_channel', this),
        onCancel: () => sendbird.removeChannelEventHandler('base_channel'));
  }

  Stream<BaseMessage> get onChannelNewMessage => _messageStreamController.stream;

  Stream<GroupChannel> get onChannelNewChanged => _channelsStreamController.stream;

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
      var ret = await query.loadNext();
      return ret;
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

  User getCurrentUser()  {
    return sendbird.currentUser;
  }
}
