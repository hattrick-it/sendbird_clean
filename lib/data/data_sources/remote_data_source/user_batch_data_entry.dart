import 'package:sendbird_sdk/sendbird_sdk.dart';
import '../../../domain/entities/chat_doctor.dart';
import '../../../domain/entities/chat_user.dart';

var doctorUsers = [
  ChatDoctor(
    userId: 'Doctor_1',
    nickname: 'Ava Davis',
    metadata: {'userType': 'Doctor', 'Specialty': 'General Practice'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1628607567/telemedicine/ava_davis_d1_bnabao.jpg',
  ),
  ChatDoctor(
    userId: 'Doctor_2',
    nickname: 'Andrea Miller',
    metadata: {'userType': 'Doctor', 'Specialty': 'Hospitalist'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1628607567/telemedicine/andrea_miller_d2_x0vgu8.jpg',
  ),
  ChatDoctor(
    userId: 'Doctor_3',
    nickname: 'Robert Anderson',
    metadata: {'userType': 'Doctor', 'Specialty': 'Family Medicine'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1628690466/telemedicine/E952E12E-FC7A-4E86-82AA-A98893E6B4C4_1_105_c_j2p6r7.jpg',
  ),
];

var patientsUsers = [
  ChatUser(
    userId: 'Patient_1',
    nickname: 'Olivia Jackson',
    metadata: {'userType': 'Patient'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1628690672/telemedicine/2FC97148-EE30-435F-9A0F-10464A390FF9_1_201_a_k3anhc.jpg',
  ),
  ChatUser(
    userId: 'Patient_2',
    nickname: 'Emma Smith',
    metadata: {'userType': 'Patient'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1628690796/telemedicine/5873800D-D9AE-43CD-8C47-519E63357E2A_1_105_c_lr3ruv.jpg',
  ),
  ChatUser(
    userId: 'Patient_3',
    nickname: 'Michael Williams',
    metadata: {'userType': 'Patient'},
    profileUrl:
        'https://res.cloudinary.com/hattrick-it/image/upload/v1628607567/telemedicine/michael_williams_p3_d7fwcv.jpg',
  ),
];

class UserBatchDataEntry {
  final SendbirdSdk sendbird;
  UserBatchDataEntry({this.sendbird});

  final send = SendbirdSdk(appId: '81E3CC1F-64AF-4F04-BDE8-A7B632250808');

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
      await send.connect(item.userId);
      await send.updateCurrentUserInfo(
          nickname: item.nickname,
          fileInfo: FileInfo.fromUrl(
            url: item.profileUrl,
          ));
      final user = send.currentUser;
      final data = item.metadata;
      await user.createMetaData(data);
    }
  }

  Future<void> createPatients() async {
    for (var item in patientsUsers) {
      await send.connect(item.userId);
      await send.updateCurrentUserInfo(
          nickname: item.nickname,
          fileInfo: FileInfo.fromUrl(
            url: item.profileUrl,
          ));
      final user = send.currentUser;
      final data = item.metadata;
      await user.createMetaData(data);
    }
  }
}
