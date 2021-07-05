import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:sendbirdtutorial/domain/entities/chat_doctor.dart';
import 'package:sendbirdtutorial/domain/entities/chat_user.dart';
import 'package:sendbirdtutorial/locator/locator.dart';

import '../../../main.dart';

var doctorUsers = [
  ChatDoctor(
    userId: 'Doctor_1',
    nickname: 'Dr.Edwin Ching MBBS,MIRCP',
    metadata: {'userType': 'Doctor', 'Specialty': 'General Practice'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1624907937/users/doctor_1.jpg',
  ),
  ChatDoctor(
    userId: 'Doctor_2',
    nickname: 'Dr.Kevin Zeng M.D.',
    metadata: {'userType': 'Doctor', 'Specialty': 'Hospitalist'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1624907946/users/doctor_2.jpg',
  ),
  ChatDoctor(
    userId: 'Doctor_3',
    nickname: 'Dr.Jhon Shi Chang Su MBBS',
    metadata: {'userType': 'Doctor', 'Specialty': 'Family Medicine'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1624907952/users/doctor_3.jpg',
  ),
];

var patientsUsers = [
  ChatUser(
    userId: 'Patient_1',
    nickname: 'Steve Rogers',
    metadata: {'userType': 'Patient'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1624909040/users/steve_rogers.jpg',
  ),
  ChatUser(
    userId: 'Patient_2',
    nickname: 'Tony Stark',
    metadata: {'userType': 'Patient'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1624909049/users/tony_stark.jpg',
  ),
  ChatUser(
    userId: 'Patient_3',
    nickname: 'Black Widow',
    metadata: {'userType': 'Patient'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1624909075/users/black_widow.jpg',
  ),
];


class SendbirdUserSelectionDataSource {
  final SendbirdSdk sendbird;
  SendbirdUserSelectionDataSource({this.sendbird});

  Future<List<User>> getUsers() {
    try {
      final query = ApplicationUserListQuery();
      return query.loadNext();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createDoctors() async {
    for (var item in doctorUsers) {
      await sendbird.connect(item.userId);
      await sendbird.updateCurrentUserInfo(
          nickname: item.nickname,
          fileInfo: FileInfo.fromUrl(
            url: item.profileUrl,
          ));
      final user = sendbird.currentUser;
      final data = item.metadata;
      await user.createMetaData(data);
    }
  }

  Future<void> createPatients() async {
    for (var item in patientsUsers) {
      await sendbird.connect(item.userId);
      await sendbird.updateCurrentUserInfo(
          nickname: item.nickname,
          fileInfo: FileInfo.fromUrl(
            url: item.profileUrl,
          ));
      final user = sendbird.currentUser;
      final data = item.metadata;
      await user.createMetaData(data);
    }
  }
}
