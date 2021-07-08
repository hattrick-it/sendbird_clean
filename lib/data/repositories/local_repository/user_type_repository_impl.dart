import '../../data_sources/local_data_source/user_type_data_source.dart';
import '../../../domain/repositories/local_user_type_repository.dart';

class LocalUserTypeRepositoryImpl implements LocalUserTypeRepository {
  final LocalUserTypeDataSource localUserTypeDataSource;
  LocalUserTypeRepositoryImpl({this.localUserTypeDataSource});

  @override
  Future<void> saveUserType(String userType) {
    localUserTypeDataSource.saveUserType(userType);
  }

  @override
  Future<String> getCurrentUserType() {
    return localUserTypeDataSource.getCurrentUserType();
  }
}