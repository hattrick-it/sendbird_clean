import 'package:get_it/get_it.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/users_data_source.dart';
import 'package:sendbirdtutorial/data/repositories/remote_repository/user_repository_impl.dart';
import 'package:sendbirdtutorial/domain/repositories/users_repository.dart';
import '../Core/constants.dart';
import '../data/data_sources/local_data_source/user_type_data_source.dart';
import '../data/data_sources/remote_data_source/channels_data_source.dart';
import '../data/data_sources/remote_data_source/chat_data_source.dart';
import '../data/data_sources/remote_data_source/auth_data_source.dart';
import '../data/data_sources/remote_data_source/user_batch_data_entry.dart';
import '../data/repositories/local_repository/user_type_repository_impl.dart';
import '../data/repositories/remote_repository/channel_repository_impl.dart';
import '../data/repositories/remote_repository/user_selection_repository_impl.dart';
import '../domain/controllers/channel_list_controller/channel_list_controller.dart';
import '../domain/controllers/chat_controller/chat_controller.dart';
import '../domain/controllers/login_controller/login_controller.dart';
import '../domain/controllers/user_selection_controller/user_selection_controller.dart';
import '../domain/repositories/channel_repository.dart';
import '../domain/repositories/local_user_type_repository.dart';
import '../domain/repositories/user_selection_repository.dart';
import '../presentation/viewmodel/auth_viewmodel/auth_viewmodel.dart';
import '../presentation/viewmodel/channel_list_viewmodel/chat_channel_list_viewmodel.dart';
import '../presentation/viewmodel/chat_viewmodel/chat_viewmodel.dart';
import '../presentation/viewmodel/user_selection_viewmodel/user_selection_viewmodel.dart';
import '../presentation/viewmodel/users_list_viewmodel/users_list_viewmodel.dart';
import '../data/repositories/remote_repository/chat_repository_impl.dart';
import '../data/repositories/remote_repository/auth_repository_impl.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/repositories/auth_repository.dart';

final locator = GetIt.instance;

void setup() {
  // SendbirdSdk
  locator.registerSingleton<SendbirdSdk>(SendbirdSdk(appId: Constants.api_key));

  // Repositories
  locator.registerFactory<AuthRepository>(
      () => AuthRespositoryImpl(sendbirdUserRemoteDataSource: locator.get()));
  locator.registerFactory<ChatRepository>(() => ChatRepositoryImpl(
        sendbirdChannelsDataSource: locator.get(),
        localUserTypeDataSource: locator.get(),
        usersDataSource: locator.get(),
      ));
  locator.registerFactory<UserSelectionRepository>(() =>
      UserSelectionRepositoryImpl(
          sendbirdUserSelectionDataSource: locator.get()));
  locator.registerFactory<UserTypeRepository>(
      () => UserTypeRepositoryImpl(localUserTypeDataSource: locator.get()));

  locator.registerFactory<ChannelRepository>(
      () => ChannelRepositoryImpl(sendbirdChannelsDataSource: locator.get()));
  locator.registerFactory<UsersRepository>(
      () => UsersRepositoryImpl(usersDataSource: locator.get()));

  // Data Sources
  locator.registerFactory<ChatDataSource>(() => ChatDataSource(
        sendbird: locator.get(),
        channelsDataSource: locator.get(),
      ));
  locator.registerFactory<ChannelsDataSource>(
      () => ChannelsDataSource(sendbird: locator.get()));
  locator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(sendbird: locator.get()));
  locator.registerFactory<UserBatchDataEntry>(
      () => UserBatchDataEntry(sendbird: locator.get()));
  locator.registerFactory<UserTypeDataSource>(() => UserTypeDataSource());
  locator.registerFactory<UsersDataSource>(
      () => UsersDataSource(sendbird: locator.get()));

  // Controllers
  locator.registerFactory<ChatController>(() => ChatController(
        chatRepository: locator.get(),
        usersRepository: locator.get(),
      ));
  locator.registerSingleton<ChannelListController>(
      ChannelListController(channelRepository: locator.get()));
  locator.registerFactory<LoginController>(
      () => LoginController(userRespository: locator.get()));
  locator
      .registerFactory<UserSelectionController>(() => UserSelectionController(
            localUserTypeRepository: locator.get(),
            userSelectorRepository: locator.get(),
          ));

  // ViewModels
  locator.registerFactory<AuthViewModel>(
      () => AuthViewModel(loginController: locator.get()));
  locator.registerFactory<UsersListViewModel>(() => UsersListViewModel(
        channelListController: locator.get(),
        chatController: locator.get(),
      ));
  locator.registerFactory<UserSelectionViewModel>(() => UserSelectionViewModel(
        loginController: locator.get(),
        userSelectionController: locator.get(),
      ));
  locator.registerFactory<ChatViewModel>(
      () => ChatViewModel(chatController: locator.get()));
  locator.registerFactory<ChatChannelViewModel>(
      () => ChatChannelViewModel(channelListController: locator.get()));
}
