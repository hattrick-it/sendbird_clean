import '../../entities/chat_user.dart';
import '../../repositories/local_user_type_repository.dart';
import '../../repositories/user_selection_repository.dart';

class UserSelectionController {
  final UserSelectionRepository userSelectorRepository;
  final UserTypeRepository localUserTypeRepository;

  UserSelectionController(
      {this.userSelectorRepository, this.localUserTypeRepository});

  Future<List<ChatUser>> getUsersByType(String userType) {
    return userSelectorRepository.getUsersByType(userType);
  }

  void saveUserType(String userType) {
    localUserTypeRepository.saveUserType(userType);
  }

  Future<String> getCurrentUserType() {
    return localUserTypeRepository.getCurrentUserType();
  }
}
