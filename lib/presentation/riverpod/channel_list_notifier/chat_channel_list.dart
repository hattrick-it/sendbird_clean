import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import 'package:sendbirdtutorial/domain/use_cases/channel_list_use_case/channel_list_controller.dart';

import 'chat_channel_list_states.dart';

final chatChannelNotifier =
    StateNotifierProvider((ref) => ChatChannelNotifier());

class ChatChannelNotifier extends StateNotifier<ChatChannelsListState> {
  ChatChannelNotifier() : super(ChatChannelsListInitial());

  ChannelListController _chatController = ChannelListController();

  void loadChannelsList() async {
    try {
      state = ChatChannelsListLoading();
      List<ChatChannel> channelList = await _chatController.getChannels();

      if (channelList.length > 0) {
        state = ChatChannelsListLoaded(channelList);
      } else {
        state = ChatChannelsListInitial();
      }
    } catch (e) {
      state = ChatChannelsListError(e.toString());
    }
  }

  void listenStream() {
    _chatController.getStreamMessages();
  }
}
