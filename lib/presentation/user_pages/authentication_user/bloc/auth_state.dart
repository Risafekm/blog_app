part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

//initial state
final class AuthInitial extends AuthState {}

//loading state
class AuthLoading extends AuthState {}

//success state
class AuthSuccess extends AuthState {
  late final UserModel user;

  AuthSuccess(this.user);
}

//failure state
class AuthFailure extends AuthState {
  late final String error;

  AuthFailure(this.error);
}
