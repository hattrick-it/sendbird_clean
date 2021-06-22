import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/use_cases/chat_use_case/chat_controller.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

final chatNotifier =
    ChangeNotifierProvider.autoDispose((ref) => ChatNotifier());

enum ChatStatus {
  Empty,
  Sending,
  Send,
  Error,
}

class ChatNotifier extends ChangeNotifier {
  final ChatController _chatController = locator.get<ChatController>();

  // Properties
  String _message;
  ChatStatus _chatState = ChatStatus.Empty;

  // Getters
  Stream<List<ChatMessage>> get onNewMessage async* {
    yield* await _chatController.streamMessages();
  }

  ChatStatus get getStatus => _chatState;

  // Setters
  void setChannelUrl(String channelUrl) {
    _chatController.setChannelUrl(channelUrl);
  }

  void _setStatus(ChatStatus state) {
    _chatState = state;
    notifyListeners();
  }

  // Public Methods
  void sendMessage() async {
    try {
      if (_message.isNotEmpty) {
        _setStatus(ChatStatus.Sending);
        await _chatController.sendMessage(_message);
        setMessage('');
      }
    } catch (e) {
      _setStatus(ChatStatus.Error);
      throw Exception(e);
    } finally {
      _setStatus(ChatStatus.Empty);
    }
  }

  setMessage(String message) {
    this._message = message;
  }

// Private Methods
}
