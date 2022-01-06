import 'dart:async';

import 'package:sendbird_sdk/sendbird_sdk.dart';

import '../../../Core/string_constants.dart';
import 'channels_data_source.dart';

class ChatRemoteDataSource with ChannelEventHandler {
  // ignore: close_sinks
  late StreamController<BaseMessage> _chatStreamController;

  late final ChannelsDataSource channelsDataSource;
  late final SendbirdSdk sendbird;

  ChatRemoteDataSource(
      {required this.sendbird, required this.channelsDataSource}) {
    _chatStreamController = StreamController<BaseMessage>(
        onListen: () async {
          sendbird.addChannelEventHandler(StringConstants.chatHandlerKey, this);
        },
        onCancel: () =>
            sendbird.removeChannelEventHandler(StringConstants.chatHandlerKey));
  }

  Stream<BaseMessage> get getMessageStream => _chatStreamController.stream;

  late String _channelUrl;

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

  Future<BaseMessage?> sendMessage(String message) async {
    BaseMessage userMessage;
    try {
      GroupChannel channel = await getGroupChannel(_channelUrl);
      userMessage = channel.sendUserMessageWithText(message,
          onCompleted: (baseMessage, err) {
        if (err != null) {
          _chatStreamController.sink.add(baseMessage);
        } else {
          _chatStreamController.sink.add(baseMessage);
        }
      });
      _chatStreamController.sink.add(userMessage);
    } catch (e) {
      throw Exception(e);
    }
  }
}
