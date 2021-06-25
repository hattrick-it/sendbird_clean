import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import 'package:sendbirdtutorial/domain/use_cases/channel_list_use_case/channel_list_controller.dart';

final chatChannelNotifier =
    ChangeNotifierProvider((ref) => ChatChannelNotifier());

enum ChatChannelState {
  Empty,
  Loading,
  Loaded,
  Error,
}

class ChatChannelNotifier extends ChangeNotifier {
  // TODO change to locator
  ChannelListController _chatController = ChannelListController();

  // Properties
  List<ChatChannel> _channelList = [];
  ChatChannelState _chatChannelState = ChatChannelState.Empty;
  String _errorMsg = '';

  // Getters
  List<ChatChannel> get channelList => _channelList;

  ChatChannelState get chatChannelState => _chatChannelState;

  String get errorMsg => _errorMsg;

  // Setters
  void _setChannelList(List<ChatChannel> list) {
    _channelList = list;
    notifyListeners();
  }

  void _setChatChannelState(ChatChannelState state) {
    _chatChannelState = state;
    notifyListeners();
  }

  void _setErrorMsg(String msg) {
    _errorMsg = msg;
    notifyListeners();
  }

  // Private methods

  // Public methods
  Future<void> loadChannelsList() async {
    try {
      _setChatChannelState(ChatChannelState.Loading);
      var list = await _chatController.getChannels();
      if (list.length > 0) {
        _setChannelList(list);
        _setChatChannelState(ChatChannelState.Loaded);
      } else {
        _setChatChannelState(ChatChannelState.Empty);
      }
    } catch (e) {
      _setErrorMsg(e);
      _setChatChannelState(ChatChannelState.Error);
    }
  }

  // TODO conectar y reaccionar a nuevo mensaje de nuevo usuario para
  //  mostrar en chatchannellist un nuevo chatChannel
  void listenStream() {
    _chatController.getStreamMessages();
  }
}
