import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/use_cases/channel_list_use_case/channel_list_controller.dart';
import 'package:sendbirdtutorial/domain/use_cases/chat_use_case/chat_controller.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

final usersListNotifier =
    ChangeNotifierProvider.autoDispose((ref) => UsersListNotifier());

enum UserListStatus {
  Empty,
  Loading,
  Loaded,
  Error,
}

class UsersListNotifier extends ChangeNotifier {
  final ChatController _chatController = locator.get<ChatController>();
  final ChannelListController _channelListController =
      locator.get<ChannelListController>();

  // Properties
  List<ChatUser> _usersList = [];
  UserListStatus _userListStatus = UserListStatus.Empty;
  String _errorMsg = '';

  // Getters
  List<ChatUser> get usersList => _usersList;
  String get errorMsg => _errorMsg;
  UserListStatus get userListStatus => _userListStatus;

  // Setters
  void _setUsersList(List<ChatUser> list) {
    _usersList = list;
    notifyListeners();
  }

  void _setStatus(UserListStatus status) {
    _userListStatus = status;
    notifyListeners();
  }

  void _setErrorMsg(String msg){
    _errorMsg = msg;
    notifyListeners();
  }

  // Private methods

  // Public methodss
  Future<void> getUsers() async {
    try {
      _setStatus(UserListStatus.Loading);
      var users = await _chatController.getUsers();
      _setUsersList(users);
      _setStatus(UserListStatus.Loaded);
    } catch (e) {
      _setErrorMsg(e);
      _setStatus(UserListStatus.Error);
    }
  }

  void createChannel(String userId) {
    _channelListController.createChannel(userId);
  }
}
