import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/controllers/channel_list_controller/channel_list_controller.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

final chatChannelNotifier =
    ChangeNotifierProvider<ChatChannelViewModel>((ref) => locator.get());

enum ChatChannelState {
  Empty,
  Loading,
  Loaded,
  Error,
}

class ChatChannelViewModel extends ChangeNotifier {
  final ChannelListController channelListController;

  ChatChannelViewModel({this.channelListController});

  // Properties
  List<ChatChannel> _channelList = [];
  ChatChannelState _chatChannelState = ChatChannelState.Empty;
  String _errorMsg = '';

  // Getters
  List<ChatChannel> get channelList => _channelList;

  Stream<List<ChatChannel>> get onNewChannelEvent =>
      channelListController.getChannels;

  Stream<ChatMessage> get onNewMessageEvent =>
      channelListController.getMessage;

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

  ChatUser getCurrentUser() {
    return channelListController.getCurrentUser();
  }
}
