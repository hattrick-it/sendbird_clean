import 'package:sendbirdtutorial/domain/entities/chat_message.dart';

abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  final List<ChatMessage> chatMessages;

  const ChatLoaded(this.chatMessages);
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);
}
