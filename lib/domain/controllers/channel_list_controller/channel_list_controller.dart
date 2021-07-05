import 'dart:async';

import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/repositories/channel_repository.dart';

import '../../entities/chat_channel.dart';

class ChannelListController {

  final ChannelRepository channelRepository;
  ChannelListController({this.channelRepository}) {
    _onInitl();
  }

  void _onInitl() {
    _messageStreamController = StreamController<ChatMessage>(onListen: () {
      _getMessageStream();
    });
    _channelsStreamController =
        StreamController<List<ChatChannel>>(onListen: () async {
      _chatChannelList = await _loadChatChannelsList();
      _channelsStreamController.sink.add(_chatChannelList);
      _getChannelsStream();
    });
  }


  StreamController<ChatMessage> _messageStreamController;

  StreamController<List<ChatChannel>> _channelsStreamController;

  List<ChatChannel> _chatChannelList = [];

  Stream<List<ChatChannel>> get getChannels => _channelsStreamController.stream;

  Stream<ChatMessage> get getMessage => _messageStreamController.stream;

  Future<List<ChatChannel>> _loadChatChannelsList() async {
    return channelRepository.getChannels();
  }

  void createChannel(String userId) {
    channelRepository.createChannel(userId);
  }

  void _getChannelsStream() {
    channelRepository.getChannelsStream().listen((event) async {
      var list = await _rebuildChannelList(event);
      _channelsStreamController.sink.add(list);
    });
  }

  void _getMessageStream() {
    channelRepository.getMessageStream().listen((event) {
      _messageStreamController.sink.add(event);
    });
  }

  Future<List<ChatChannel>> _rebuildChannelList(ChatChannel channel) async {
    for (var item in _chatChannelList) {
      if (item.channelUrl == channel.channelUrl) {
        item.lastMessage = channel.lastMessage;
        item = channel;
        return _chatChannelList;
      }
    }
    _chatChannelList.add(channel);
    return _chatChannelList;
  }

  ChatUser getCurrentUser() {
    return channelRepository.getCurrentUser();
  }
}
