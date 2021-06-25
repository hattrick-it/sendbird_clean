import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/use_cases/chat_use_case/chat_controller.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

final chatNotifier = ChangeNotifierProvider((ref) => ChatNotifier());

enum ChatState {
  Empty,
  Sending,
  Send,
  Error,
}

class ChatNotifier extends ChangeNotifier {
  final ChatController _chatController = locator.get<ChatController>();

  // Properties
  String _userMsg = '';
  String _errorMsg = '';
  ChatState _chatState = ChatState.Empty;

  // Getters
  Stream<List<ChatMessage>> get onNewMessage async* {
    yield* await _chatController.streamMessages();
  }

  ChatState get chatState => _chatState;

  String get errorMsg => _errorMsg;

  // Setters
  void setChannelUrl(String channelUrl) {
    _chatController.setChannelUrl(channelUrl);
  }

  void setUserMsg(String msg) {
    _userMsg = msg;
  }

  void _setState(ChatState state) {
    _chatState = state;
    notifyListeners();
  }

  void _setErrorMsg(String msg) {
    _errorMsg = msg;
    notifyListeners();
  }

  // Private Methods

  // Public Methods

  ChatUser getCurrentUser() {
    return _chatController.getCurrentUser();
  }

  void sendMessage() async {
    try {
      _setState(ChatState.Empty);
      if (_userMsg.isNotEmpty) {
        _setState(ChatState.Sending);
        await _chatController.sendMessage(_userMsg);
        setUserMsg('');
      }
      _setState(ChatState.Send);
    } catch (e) {
      _setErrorMsg(e);
      _setState(ChatState.Error);
    }
  }
}
