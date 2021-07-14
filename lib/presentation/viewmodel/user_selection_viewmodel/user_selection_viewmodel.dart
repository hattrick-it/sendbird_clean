import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';
import '../../../domain/controllers/login_controller/login_controller.dart';
import '../../../domain/controllers/user_selection_controller/user_selection_controller.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../locator/locator.dart';

final userSelectionViewModel =
    ChangeNotifierProvider<UserSelectionViewModel>((ref) => locator.get());

enum UserSelectionStatus {
  Empty,
  Loading,
  Loaded,
  Error,
}

class UserSelectionViewModel extends ChangeNotifier {
  // Locator DI
  final LoginController loginController;
  final UserSelectionController userSelectionController;

  UserSelectionViewModel({
    this.loginController,
    this.userSelectionController,
  }) {
    // adminConnect();
  }

  // Properties
  String _userType;
  List<ChatUser> _userList = [];
  UserSelectionStatus _userSelectionStatus = UserSelectionStatus.Empty;

  // Getters
  List<ChatUser> get getUserList => _userList;

  UserSelectionStatus get getUserSelectionSatus => _userSelectionStatus;

  // Setters
  void _setUserList(List<ChatUser> list) {
    _userList = [];
    _userList = list;
    notifyListeners();
  }

  void _setStatus(UserSelectionStatus status) {
    _userSelectionStatus = status;
    notifyListeners();
  }

  // Private methods

  // Public methods
  void saveUserType(String userType) {
    userSelectionController.saveUserType(userType);
    _userType = userType;
  }

  Future<String> getCurrentUserType() {
    return userSelectionController.getCurrentUserType();
  }

  // Future<void> adminConnect() async {
  //   await loginController.connect(StringConstants.adminUserIdNickname,
  //       StringConstants.adminUserIdNickname);
  // }

  // TODO !!!!!

  Future<void> getUsersByType() async {
    try {
      _setStatus(UserSelectionStatus.Loading);
      List<ChatUser> chatUsers = await userSelectionController.getUsersByType();
      _setUserList(chatUsers);
      _setStatus(UserSelectionStatus.Loaded);
    } catch (e) {
      _setStatus(UserSelectionStatus.Error);
      throw Exception(e);
    }
  }

  Future<void> getUserByName(String name) async {
    try {
      _setStatus(UserSelectionStatus.Loading);
      var chatUsers = await userSelectionController.getUserByName(name);
      _setUserList(chatUsers);
      _setStatus(UserSelectionStatus.Loaded);
    } catch (e) {
      _setStatus(UserSelectionStatus.Error);
      throw Exception(e);
    }
  }

  Future<void> getDoctorBySpecialty(String specialty) async {
    try {
      _setStatus(UserSelectionStatus.Loading);
      var chatUsers =
          await userSelectionController.getDoctorBySpecialty(specialty);
      _setUserList(chatUsers);
      _setStatus(UserSelectionStatus.Loaded);
    } catch (e) {
      _setStatus(UserSelectionStatus.Error);
      throw Exception(e);
    }
  }
}
