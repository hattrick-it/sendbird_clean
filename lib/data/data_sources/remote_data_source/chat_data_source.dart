import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';
import 'channels_data_source.dart';

class ChatDataSource with ChannelEventHandler {
  StreamController<BaseMessage> _chatStreamController;
  final ChannelsDataSource channelsDataSource;
  final SendbirdSdk sendbird;

  ChatDataSource({this.sendbird, this.channelsDataSource}) {
    _chatStreamController = StreamController<BaseMessage>(
        onListen: () async {
          sendbird.addChannelEventHandler(StringConstants.chatHandlerKey, this);
        },
        onCancel: () =>
            sendbird.removeChannelEventHandler(StringConstants.chatHandlerKey));
  }

  Stream<BaseMessage> get getMessageStream => _chatStreamController.stream;

  String _channelUrl;

  void setChannelUrl(String channelUrl) {
    _channelUrl = channelUrl;
  }

  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    _chatStreamController.sink.add(message);
  }

  void onChannelChanged(BaseChannel channel) async {
    GroupChannel groupChannel = await getGroupChannel(channel.channelUrl);
    // _chatStreamController.sink.add(groupChannel.lastMessage);
  }

  Future<GroupChannel> getGroupChannel(String channelUrl) async {
    return channelsDataSource.getGroupChannel(channelUrl);
  }

  Future<List<GroupChannel>> getGroupChannels(String channelUrl) async {
    return channelsDataSource.getGroupChannels();
  }

  Future<List<BaseMessage>> getMessages() async {
    try {
      GroupChannel channel = await getGroupChannel(_channelUrl);
      return channel.getMessagesByTimestamp(
          DateTime.now().millisecondsSinceEpoch * 1000, MessageListParams());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<BaseMessage> sendMessage(String message) async {
    try {
      final Completer<BaseMessage> completer = Completer();
      GroupChannel channel = await getGroupChannel(_channelUrl);
      channel.sendUserMessageWithText(message, onCompleted: (baseMessage, err) {
        if (err != null) {
          completer.complete(null);
        } else {
          completer.complete(baseMessage);
        }
      });
      return completer.future;
    } catch (e) {
      throw Exception(e);
    }
  }
}
