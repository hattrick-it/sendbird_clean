import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

enum SpecialtyListStatus {
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
    required this.loginController,
    required this.userSelectionController,
  }) {
    // adminConnect();
  }

  // Properties

  String? _userType;
  List<ChatUser> _userList = [];
  List<String> _specialtyList = [];
  Map<String, bool> _specialtiesMap = {};
  UserSelectionStatus _userSelectionStatus = UserSelectionStatus.Empty;
  SpecialtyListStatus _specialtyListStatus = SpecialtyListStatus.Empty;
  int _selectedIndex = 0;

  // Getters
  List<ChatUser> get getUserList => _userList;

  List<String> get getSpecialties => _specialtyList;

  int get getSelectedIndex => _selectedIndex;

  Map<String, bool> get getSpecialtiesMap => _specialtiesMap;

  UserSelectionStatus get getUserSelectionSatus => _userSelectionStatus;

  SpecialtyListStatus get getSpecialtyListStatus => _specialtyListStatus;

  // Setters
  void _setUserList(List<ChatUser> list) {
    _userList = [];
    _userList = list;
    notifyListeners();
  }

  void _setSpecialtiesMap(Map<String, bool> myMap) {
    _specialtiesMap = {};
    _specialtiesMap = myMap;
    notifyListeners();
  }

  void _setStatus(UserSelectionStatus status) {
    _userSelectionStatus = status;
    notifyListeners();
  }

  void _setSpecialtyListStatus(SpecialtyListStatus status) {
    _specialtyListStatus = status;
    notifyListeners();
  }

  // Private methods

  // Public methods
  void saveUserType(String userType) {
    userSelectionController.saveUserType(userType);
    _userType = userType;
  }

  Future<String?> getCurrentUserType() async {
    var currentUserType = await userSelectionController.getCurrentUserType();
    return currentUserType;
  }

  Future<void> getSpecialtyMap() async {
    try {
      _setSpecialtyListStatus(SpecialtyListStatus.Loading);
      var specialties = await userSelectionController.getSpecialtiesMap();
      _setSpecialtiesMap(specialties);
      _setSpecialtyListStatus(SpecialtyListStatus.Loaded);
    } catch (e) {
      _setSpecialtyListStatus(SpecialtyListStatus.Error);
      throw Exception(e);
    }
  }

  Future<void> getUsersByType() async {
    try {
      _setStatus(UserSelectionStatus.Loading);
      List<ChatUser>? chatUsers =
          await userSelectionController.getUsersByType();
      if (chatUsers != null) {
        _setUserList(chatUsers);
        _setStatus(UserSelectionStatus.Loaded);
      }
    } catch (e) {
      _setStatus(UserSelectionStatus.Error);
      throw Exception(e);
    }
  }

  Future<void> getUserByName(String name) async {
    try {
      _setStatus(UserSelectionStatus.Loading);
      var chatUsers = await userSelectionController.getUserByName(name);
      _setUserList(chatUsers!);
      _setStatus(UserSelectionStatus.Loaded);
    } catch (e) {
      _setStatus(UserSelectionStatus.Error);
      throw Exception(e);
    }
  }

  Future<void> getDoctorBySpecialty(int index) async {
    var speciality = _specialtiesMap.keys.elementAt(index);
    setSelectedIndex(index);
    try {
      _setStatus(UserSelectionStatus.Loading);
      var chatUsers =
          await userSelectionController.getDoctorBySpecialty(speciality);
      _setUserList(chatUsers!);
      _setStatus(UserSelectionStatus.Loaded);
    } catch (e) {
      _setStatus(UserSelectionStatus.Error);
      throw Exception(e);
    }
  }

  void setSelectedIndex(int selected) {
    _specialtiesMap[_specialtiesMap.keys.elementAt(_selectedIndex)] = false;
    _specialtiesMap[_specialtiesMap.keys.elementAt(selected)] = true;
    _selectedIndex = selected;
    notifyListeners();
  }
}
