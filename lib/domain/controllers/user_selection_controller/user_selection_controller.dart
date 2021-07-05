import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/domain/repositories/local_user_type_repository.dart';
import 'package:sendbirdtutorial/domain/repositories/user_selection_repository.dart';

class UserSelectionController {
  final UserSelectionRepository userSelectorRepository;
  final LocalUserTypeRepository localUserTypeRepository;

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
