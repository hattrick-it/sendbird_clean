import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';
import 'channels_data_source.dart';

class ChatRemoteDataSource with ChannelEventHandler {
  StreamController<BaseMessage> _chatStreamController;

  StreamController<BaseMessage> _chatStreamControllerSendMessage;
  final ChannelsDataSource channelsDataSource;
  final SendbirdSdk sendbird;

  ChatRemoteDataSource({this.sendbird, this.channelsDataSource}) {
    _chatStreamControllerSendMessage = StreamController<BaseMessage>();
    _chatStreamController = StreamController<BaseMessage>(
        onListen: () async {
          sendbird.addChannelEventHandler(StringConstants.chatHandlerKey, this);
        },
        onCancel: () =>
            sendbird.removeChannelEventHandler(StringConstants.chatHandlerKey));
  }

  Stream<BaseMessage> get getMessageStream => _chatStreamController.stream;
  Stream<BaseMessage> get getSendMessageStream => _chatStreamControllerSendMessage.stream;

  String _channelUrl;

  void setChannelUrl(String channelUrl) {
    _channelUrl = channelUrl;
  }

  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    _chatStreamController.sink.add(message);
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
    BaseMessage userMessage;
    try {
      GroupChannel channel = await getGroupChannel(_channelUrl);
       userMessage = channel.sendUserMessageWithText(message, onCompleted: (baseMessage, err) {
        if (err != null) {
          _chatStreamControllerSendMessage.sink.add(baseMessage);
        } else {
          _chatStreamControllerSendMessage.sink.add(baseMessage);
        }
      });
      _chatStreamControllerSendMessage.sink.add(userMessage);
    } catch (e) {
      throw Exception(e);
    }
  }
}
