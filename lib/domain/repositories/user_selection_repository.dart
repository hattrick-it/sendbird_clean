import '../entities/chat_user.dart';

abstract class UserSelectionRepository {
  Future<List<ChatUser>> getUserByName(String name);

  Future<List<ChatUser>> getUsersByType();

  Future<List<ChatUser>> getDoctorBySpecialty(String specialty);

  Future<Map<String, bool>> getSpecialtyMap();
}
