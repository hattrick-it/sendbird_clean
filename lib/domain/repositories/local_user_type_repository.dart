abstract class UserTypeRepository {
  Future<void> saveUserType(String userType);

  Future<String?> getCurrentUserType();
}
