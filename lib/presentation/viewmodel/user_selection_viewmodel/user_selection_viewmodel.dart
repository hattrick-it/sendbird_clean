import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sendbirdtutorial/Core/string_constants.dart';
import '../../../domain/controllers/login_controller/login_controller.dart';
import '../../../domain/controllers/user_selection_controller/user_selection_controller.dart';
import '../../../domain/entities/chat_user.dart';
import '../../../locator/locator.dart';

final userSelectionNotifier =
    ChangeNotifierProvider<UserSelectionViewModel>((ref) => locator.get());

class UserSelectionViewModel extends ChangeNotifier {
  // Locator DI
  final LoginController loginController;
  final UserSelectionController userSelectionController;

  UserSelectionViewModel({
    this.loginController,
    this.userSelectionController,
  }) {
    adminConnect();
  }

  // Properties
  String _userType;

  // Getters

  // Setters

  // Private methods

  // Public methods
  void saveUserType(String userType) {
    userSelectionController.saveUserType(userType);
    _userType = userType;
  }

  Future<String> getCurrentUserType() {
    return userSelectionController.getCurrentUserType();
  }

  Future<void> adminConnect() async {
    await loginController.connect(StringConstants.adminUserIdNickname,
        StringConstants.adminUserIdNickname);
  }

  Future<List<ChatUser>> getUsersByType() async {
    return userSelectionController.getUsersByType(_userType);
  }
}
