import 'package:get_it/get_it.dart';
import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
import 'package:sendbirdtutorial/Core/constants.dart';
import 'package:sendbirdtutorial/data/data_sources/local_data_source/local_user_type_data_source.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_channels_remote_data_source.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_chat_remote_data_source.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_user_remote_data_source.dart';
import 'package:sendbirdtutorial/data/data_sources/remote_data_source/sendbird_user_selection_data_source.dart';
import 'package:sendbirdtutorial/data/repositories/local_repository/local_user_type_repository_impl.dart';
import 'package:sendbirdtutorial/data/repositories/remote_repository/channel_repository_impl.dart';
import 'package:sendbirdtutorial/data/repositories/remote_repository/user_selection_repository_impl.dart';
import 'package:sendbirdtutorial/domain/controllers/channel_list_controller/channel_list_controller.dart';
import 'package:sendbirdtutorial/domain/controllers/chat_controller/chat_controller.dart';
import 'package:sendbirdtutorial/domain/controllers/login_controller/login_controller.dart';
import 'package:sendbirdtutorial/domain/controllers/user_selection_controller/user_selection_controller.dart';
import 'package:sendbirdtutorial/domain/repositories/channel_repository.dart';
import 'package:sendbirdtutorial/domain/repositories/local_user_type_repository.dart';
import 'package:sendbirdtutorial/domain/repositories/user_selection_repository.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/auth_viewmodel/auth_viewmodel.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/channel_list_viewmodel/chat_channel_list_viewmodel.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/chat_viewmodel/chat_viewmodel.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/user_selection_viewmodel/user_selection_viewmodel.dart';
import 'package:sendbirdtutorial/presentation/viewmodel/users_list_viewmodel/users_list_viewmodel.dart';
import '../data/repositories/remote_repository/chat_repository_impl.dart';
import '../data/repositories/remote_repository/user_repository_impl.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/repositories/user_repository.dart';

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
      ));
  locator.registerFactory<UserSelectionRepository>(() =>
      UserSelectionRepositoryImpl(
          sendbirdUserSelectionDataSource: locator.get()));
  locator.registerFactory<LocalUserTypeRepository>(() =>
      LocalUserTypeRepositoryImpl(localUserTypeDataSource: locator.get()));

  locator.registerFactory<ChannelRepository>(
      () => ChannelRepositoryImpl(sendbirdChannelsDataSource: locator.get()));

  // Data Sources
  locator.registerFactory<SendbirdChatRemoteDataSource>(
      () => SendbirdChatRemoteDataSource(sendbird: locator.get()));
  locator.registerFactory<SendbirdChannelsDataSource>(
      () => SendbirdChannelsDataSource(sendbird: locator.get()));
  locator.registerFactory<SendbirdUserRemoteDataSource>(
      () => SendbirdUserRemoteDataSource(sendbird: locator.get()));
  locator.registerFactory<SendbirdUserSelectionDataSource>(
      () => SendbirdUserSelectionDataSource(sendbird: locator.get()));
  locator.registerFactory<LocalUserTypeDataSource>(() => LocalUserTypeDataSource());

  // Controllers
  locator.registerFactory<ChatController>(
      () => ChatController(chatRepository: locator.get()));
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
