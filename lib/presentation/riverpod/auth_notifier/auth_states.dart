import 'package:sendbirdtutorial/domain/entities/chat_user.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoaded extends AuthState {
  final ChatUser chatUser;
  const AuthLoaded(this.chatUser);
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
