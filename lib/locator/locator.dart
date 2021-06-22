import 'package:get_it/get_it.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_channels_remote_data_source.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_chat_remote_data_source.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_user_remote_data_source.dart';
import 'package:sendbirdtutorial/data/repositories/remote_repository/channel_repository_impl.dart';
import 'package:sendbirdtutorial/domain/repositories/channel_repository.dart';
import 'package:sendbirdtutorial/domain/use_cases/channel_list_use_case/channel_list_controller.dart';
import 'package:sendbirdtutorial/domain/use_cases/chat_use_case/chat_controller.dart';
import '../data/repositories/remote_repository/chat_repository_impl.dart';
import '../data/repositories/remote_repository/user_repository_impl.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/repositories/user_repository.dart';

final locator = GetIt.instance;

void setup() {
  // repositories
  locator.registerFactory<AuthRepository>(() => AuthRespositoryImpl());
  locator.registerFactory<ChatRepository>(() => ChatRepositoryImpl());

  locator
      .registerLazySingleton<ChannelRepository>(() => ChannelRepositoryImpl());

  locator.registerFactory<SendbirdChannelsDataSource>(
      () => SendbirdChannelsDataSource());
  locator.registerFactory<SendbirdChatRemoteDataSource>(
      () => SendbirdChatRemoteDataSource());
  locator.registerFactory<SendbirdUserRemoteDataSource>(
      () => SendbirdUserRemoteDataSource());

  locator.registerFactory<ChatController>(() => ChatController());
  locator.registerFactory<ChannelListController>(() => ChannelListController());
}
