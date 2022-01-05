import 'dart:async';

import '../../repositories/chat_repository.dart';

import '../../entities/chat_user.dart';
import '../../repositories/local_user_type_repository.dart';
import '../../repositories/user_selection_repository.dart';

class UserSelectionController {
  final UserSelectionRepository userSelectorRepository;
  final UserTypeRepository localUserTypeRepository;
  final ChatRepository chatRepository;

  UserSelectionController({
    required this.userSelectorRepository,
    required this.localUserTypeRepository,
    required this.chatRepository,
  });

  void saveUserType(String userType) {
    localUserTypeRepository.saveUserType(userType);
  }

  Future<String?> getCurrentUserType() {
    return localUserTypeRepository.getCurrentUserType();
  }

  Future<List<ChatUser>?> getUserByName(String name) {
    return userSelectorRepository.getUserByName(name);
  }

  Future<List<ChatUser>?> getUsersByType() async {
    return await userSelectorRepository.getUsersByType();
  }

  Future<List<ChatUser>?> getDoctorBySpecialty(String specialty) {
    return userSelectorRepository.getDoctorBySpecialty(specialty);
  }

  Future<Map<String, bool>> getSpecialtiesMap() async {
    return await userSelectorRepository.getSpecialtyMap();
  }
}
