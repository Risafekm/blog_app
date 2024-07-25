// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//register user
class RegisterUser extends AuthEvent {
  late UserModel user;

  RegisterUser(this.user);
}

//login user
class LoginUser extends AuthEvent {
  final String email;
  final String password;

  LoginUser({required this.email, required this.password});
}

//logout
class LogoutUser extends AuthEvent {}

//auth status
class CheckAuthStatus extends AuthEvent {}
