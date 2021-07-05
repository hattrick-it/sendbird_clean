import 'package:sendbirdtutorial/data/data_sources/local_data_source/local_user_type_data_source.dart';
import 'package:sendbirdtutorial/domain/repositories/local_user_type_repository.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

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
