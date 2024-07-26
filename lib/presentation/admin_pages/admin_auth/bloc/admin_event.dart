part of 'admin_bloc.dart';

@immutable
sealed class AdminEvent {}

class AdminLoginRequested extends AdminEvent {
  final String email;
  final String password;

  AdminLoginRequested({required this.email, required this.password});
}

//auth status
class CheckAuthStatus extends AdminEvent {}
