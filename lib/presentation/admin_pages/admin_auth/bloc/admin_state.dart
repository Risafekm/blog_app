part of 'admin_bloc.dart';

@immutable
sealed class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoginInProgress extends AdminState {}

class AdminLoginSuccess extends AdminState {}

class AdminLoginFailure extends AdminState {
  final String error;

  AdminLoginFailure({required this.error});
}
