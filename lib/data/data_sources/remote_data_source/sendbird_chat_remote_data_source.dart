import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

import '../../../main.dart';
import 'sendbird_channels_remote_data_source.dart';

class SendbirdChatRemoteDataSource with ChannelEventHandler {
  StreamController<List<BaseMessage>> _chatStreamController;
  final SendbirdChannelsDataSource _sendbirdChannelsDataSource =
      locator.get<SendbirdChannelsDataSource>();
  List<BaseMessage> _messages = [];
  String _channelUrl;

  void setChannelUrl(String channelUrl) {
    _channelUrl = channelUrl;
  }

  Future<Stream<List<BaseMessage>>> initializeStream() async {
    _chatStreamController = StreamController<List<BaseMessage>>(
        onListen: () async {
          await getMessages();
          _chatStreamController.sink.add(_messages);
          sendbird.addChannelEventHandler('chat_event_handler', this);
        },
        onCancel: () =>
            sendbird.removeChannelEventHandler('chat_event_handler'));
    return _chatStreamController.stream;
  }

  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    _messages.add(message);
    _chatStreamController.sink.add(_messages);
  }

  void onChannelChanged(BaseChannel channel) async {
    GroupChannel groupChannel = await getGroupChannel(channel.channelUrl);
    _messages.add(groupChannel.lastMessage);
    _chatStreamController.sink.add(_messages);
  }

  Future<GroupChannel> getGroupChannel(String channelUrl) async {
    return _sendbirdChannelsDataSource.getGroupChannel(channelUrl);
  }

  Future<List<GroupChannel>> getGroupChannels(String channelUrl) async {
    return _sendbirdChannelsDataSource.getGroupChannels();
  }

  Future<void> getMessages() async {
    try {
      List<BaseMessage> oldMessages = [];
      GroupChannel channel = await getGroupChannel(_channelUrl);
      _messages = await channel.getMessagesByTimestamp(
          DateTime.now().millisecondsSinceEpoch * 1000, MessageListParams());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendMessage(String message) async {
    try {
      GroupChannel channel = await getGroupChannel(_channelUrl);
      channel.sendUserMessageWithText(message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<User>> getUsers() async {
    return await SendbirdChannelsDataSource().getUsers();
  }

  User getCurrentUser() {
    try {
      return sendbird.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }
}
