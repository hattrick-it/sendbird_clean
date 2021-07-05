abstract class LocalUserTypeRepository{
  Future<void> saveUserType(String userType);

  Future<String> getCurrentUserType();
}