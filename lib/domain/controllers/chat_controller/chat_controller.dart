import 'dart:async';

import 'package:sendbirdtutorial/domain/entities/chat_message.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/repositories/chat_repository.dart';

class ChatController {
  final ChatRepository chatRepository;
  ChatController({this.chatRepository}) {
    _chatStreamController = StreamController<List<ChatMessage>>(onListen: () async {
      _chatMessagesList = await getMessagesList();
      _chatStreamController.sink.add(_chatMessagesList);
      _getMessageStream();
    });
  }

  StreamController<List<ChatMessage>> _chatStreamController;

  Stream<List<ChatMessage>> get getMessages => _chatStreamController.stream;

  List<ChatMessage> _chatMessagesList = [];

  Future<List<ChatUser>> getUsers() {
    return chatRepository.getUsers();
  }

  Future<void> sendMessage(String message) {
    return chatRepository.sendMessage(message);
  }

  void setChannelUrl(String channelUrl) {
    chatRepository.setChannelUrl(channelUrl);
  }

  ChatUser getCurrentUser() {
    return chatRepository.getCurrentUser();
  }

  Future<List<ChatMessage>> getMessagesList() async {
    return await chatRepository.getMessagesList();
  }

  void _getMessageStream() {
    chatRepository.getMessageStream().listen((event) {
      _chatStreamController.sink.add(event);
    });
  }
}
