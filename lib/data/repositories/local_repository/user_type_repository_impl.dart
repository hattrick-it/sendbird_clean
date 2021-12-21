import '../../data_sources/local_data_source/user_type_data_source.dart';
import '../../../domain/repositories/local_user_type_repository.dart';

class UserTypeRepositoryImpl implements UserTypeRepository {
  final UserTypeDataSource localUserTypeDataSource;
  UserTypeRepositoryImpl({required this.localUserTypeDataSource});

  @override
  Future<void> saveUserType(String userType) async {
    await localUserTypeDataSource.saveUserType(userType);
  }

  @override
  Future<String?> getCurrentUserType() async {
    return localUserTypeDataSource.getCurrentUserType();
  }
}
