import 'dart:async';

import 'package:sendbirdtutorial/domain/repositories/chat_repository.dart';

import '../../entities/chat_user.dart';
import '../../repositories/local_user_type_repository.dart';
import '../../repositories/user_selection_repository.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/models/user.dart';

class UserSelectionController {
  final UserSelectionRepository userSelectorRepository;
  final UserTypeRepository localUserTypeRepository;
  final ChatRepository chatRepository;

  UserSelectionController({
    this.userSelectorRepository,
    this.localUserTypeRepository,
    this.chatRepository,
  });

  void saveUserType(String userType) {
    localUserTypeRepository.saveUserType(userType);
  }

  Future<String> getCurrentUserType() {
    return localUserTypeRepository.getCurrentUserType();
  }

  Future<List<ChatUser>> getUserByName(String name){
    return userSelectorRepository.getUserByName(name);
  }

  Future<List<ChatUser>> getUsersByType()async{
    var lista = await userSelectorRepository.getUsersByType();
    return lista;
  }

  Future<List<ChatUser>> getDoctorBySpecialty(String specialty){
    return userSelectorRepository.getDoctorBySpecialty(specialty);
  }
}


