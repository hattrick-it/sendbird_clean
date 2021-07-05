import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/controllers/chat_controller/chat_controller.dart';
import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

final chatNotifier =
    ChangeNotifierProvider.autoDispose<ChatViewModel>((ref) => locator.get());

enum ChatState {
  Empty,
  Sending,
  Send,
  Error,
}

class ChatViewModel extends ChangeNotifier {
  final ChatController chatController;

  ChatViewModel({this.chatController});

  // Properties
  String _userMsg = '';
  String _errorMsg = '';
  ChatState _chatState = ChatState.Empty;

  // Getters
  Stream<List<ChatMessage>> get onNewMessage => chatController.getMessages;

  ChatState get chatState => _chatState;

  String get errorMsg => _errorMsg;

  // Setters
  void setChannelUrl(String channelUrl) {
    chatController.setChannelUrl(channelUrl);
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
    return chatController.getCurrentUser();
  }

  void sendMessage() async {
    try {
      _setState(ChatState.Empty);
      if (_userMsg.isNotEmpty) {
        _setState(ChatState.Sending);
        await chatController.sendMessage(_userMsg);
        setUserMsg('');
      }
      _setState(ChatState.Send);
    } catch (e) {
      _setErrorMsg(e);
      _setState(ChatState.Error);
    }
  }
}