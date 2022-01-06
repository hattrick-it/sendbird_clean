import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/controllers/channel_list_controller/channel_list_controller.dart';
import '../../../domain/entities/chat_channel.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../locator/locator.dart';

final chatChannelViewModel =
    ChangeNotifierProvider<ChatChannelViewModel>((ref) => locator.get());

enum ChatChannelState {
  Empty,
  Loading,
  Loaded,
  Error,
}

class ChatChannelViewModel extends ChangeNotifier {
  final ChannelListController channelListController;

  ChatChannelViewModel({required this.channelListController});

  // Properties
  List<ChatChannel> _channelList = [];
  ChatChannelState _chatChannelState = ChatChannelState.Empty;

  // Getters
  List<ChatChannel> get channelList => _channelList;

  Stream<List<ChatChannel>> get onNewChannelEvent =>
      channelListController.getChannels;

  Stream<ChatMessage> get onNewMessageEvent => channelListController.getMessage;

  ChatChannelState get chatChannelState => _chatChannelState;

  // Setters

  // Private methods

  // Public methods

  ChatUser getCurrentUser() {
    return channelListController.getCurrentUser();
  }
}
