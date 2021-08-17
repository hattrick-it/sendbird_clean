import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/domain/entities/chat_channel.dart';
import '../../../domain/controllers/channel_list_controller/channel_list_controller.dart';
import '../../../domain/controllers/chat_controller/chat_controller.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../locator/locator.dart';

enum UserListStatus {
  Empty,
  Loading,
  Loaded,
  Error,
}

final usersListViewModel =
    ChangeNotifierProvider<UsersListViewModel>((ref) => locator.get());

class UsersListViewModel extends ChangeNotifier {
  final ChannelListController channelListController;
  final ChatController chatController;

  UsersListViewModel({this.chatController, this.channelListController});

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

  void _setErrorMsg(String msg) {
    _errorMsg = msg;
    notifyListeners();
  }

  // Private methods

  // Public methodss


  Future<void> getUsers() async {
    try {
      _setStatus(UserListStatus.Loading);
      var users = await chatController.getUsers();
      _setUsersList(users);
      _setStatus(UserListStatus.Loaded);
    } catch (e) {
      _setErrorMsg(e);
      _setStatus(UserListStatus.Error);
    }
  }

  Future<ChatChannel> createChannel(String userId) {
    return channelListController.createChannel(userId);
  }

  Future<ChatChannel> getChannelByIds(String userId) async {
    return await channelListController.getChannelByIds(userId);
  }
}
