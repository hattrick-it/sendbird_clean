import 'dart:async';

import '../../entities/chat_message.dart';
import '../../entities/chat_user.dart';
import '../../repositories/chat_repository.dart';
import '../../repositories/users_repository.dart';

class ChatController {
  final ChatRepository chatRepository;
  final UsersRepository usersRepository;

  ChatController(
      {required this.chatRepository, required this.usersRepository}) {
    _chatStreamController =
        StreamController<List<ChatMessage>>(onListen: () async {
      _chatMessagesList = await getMessagesList();
      _chatStreamController.sink.add(_chatMessagesList);
      _getMessageStream();
    });
  }

  late StreamController<List<ChatMessage>> _chatStreamController;

  Stream<List<ChatMessage>> get getMessages => _chatStreamController.stream;

  List<ChatMessage> _chatMessagesList = [];

  Future<List<ChatUser>> getUsers() {
    return usersRepository.getUsers();
  }

  ChatUser getCurrentUser() {
    return usersRepository.getCurrentUser();
  }

  Future<void> sendMessage(String message) async {
    await chatRepository.sendMessage(message);
  }

  void setChannelUrl(String channelUrl) {
    chatRepository.setChannelUrl(channelUrl);
  }

  Future<List<ChatMessage>> getMessagesList() async {
    return await chatRepository.getMessagesList();
  }

  void _getMessageStream() {
    chatRepository.getMessageStream().listen((event) {
      final message = _chatMessagesList.firstWhere(
        (element) => element.requestId == event.requestId,
      );
      if (message == null) {
        _chatMessagesList.add(event);
        _chatStreamController.sink.add(_chatMessagesList);
      } else {
        message.sendingStatus = event.sendingStatus;
        _chatStreamController.sink.add(_chatMessagesList);
      }
    });
  }
}
