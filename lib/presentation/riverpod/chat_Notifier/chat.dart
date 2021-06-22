import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/use_cases/chat_use_case/chat_controller.dart';
import 'package:sendbirdtutorial/locator/locator.dart';
import 'package:sendbirdtutorial/presentation/riverpod/chat_Notifier/chat_states.dart';

final chatNotifier = StateNotifierProvider.autoDispose((ref) => ChatNotifier());

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(ChatInitial());

  final ChatController _chatController = locator.get<ChatController>();

  String _message;

  void setChannelUrl(String channelUrl) {
    _chatController.setChannelUrl(channelUrl);
  }

  void sendMessage() async {
    if (_message.isNotEmpty) {
      await _chatController.sendMessage(_message);
      setMessage('');
    }
  }

  Stream<List<ChatMessage>> get onNewMessage async* {
    yield* await _chatController.streamMessages();
  }

  setMessage(String message) {
    this._message = message;
  }
}
