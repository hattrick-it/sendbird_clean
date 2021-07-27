import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/controllers/chat_controller/chat_controller.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../locator/locator.dart';

final chatViewModel =
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
  ChatUser _currentUser = null;

  // Getters
  Stream<List<ChatMessage>> get onNewMessage => chatController.getMessages;

  ChatState get chatState => _chatState;

  String get errorMsg => _errorMsg;

  String get getMsg => _userMsg;

  ChatUser get getCurrentUser => _currentUser;

  // Setters
  void setChannelUrl(String channelUrl) {
    chatController.setChannelUrl(channelUrl);
  }

  void clearMsg(){
    _userMsg = '';
    notifyListeners();
  }

  void setUserMsg(String msg) {
    _userMsg = msg;
  }

  void _setState(ChatState state) {
    _chatState = state;
    notifyListeners();
  }

  // Private Methods

  // Public Methods

  void setCurrentUser(){
    _currentUser = chatController.getCurrentUser();
  }

  void sendMessage() async {
    try {
      if (_userMsg.isNotEmpty) {
        _setState(ChatState.Sending);
        await chatController.sendMessage(_userMsg);
        setUserMsg('');
        clearMsg();
        _setState(ChatState.Empty);
      }
      _setState(ChatState.Send);
    } catch (e) {
      _setState(ChatState.Error);
    }
  }
}