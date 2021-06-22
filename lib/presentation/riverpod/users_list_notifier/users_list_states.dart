import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

abstract class UsersListStates {
  const UsersListStates();
}

class UsersListInitial extends UsersListStates {
  const UsersListInitial();
}

class UsersListLoading extends UsersListStates {
  const UsersListLoading();
}

class UsersListLoaded extends UsersListStates {
  final List<ChatUser> usersList;
  const UsersListLoaded(this.usersList);
}

class UsersListError extends UsersListStates {
  final String message;

  const UsersListError(this.message);
}
