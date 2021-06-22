import '../../../domain/entities/chat_channel.dart';

abstract class ChatChannelsListState {
  const ChatChannelsListState();
}

class ChatChannelsListInitial extends ChatChannelsListState {
  const ChatChannelsListInitial();
}

class ChatChannelsListLoading extends ChatChannelsListState {
  const ChatChannelsListLoading();
}

class ChatChannelsListLoaded extends ChatChannelsListState {
  final List<ChatChannel> channels;
  const ChatChannelsListLoaded(this.channels);
}

class ChatChannelsListError extends ChatChannelsListState {
  final String message;
  const ChatChannelsListError(this.message);
}
