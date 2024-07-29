import 'package:bloc/bloc.dart';
import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:blog_app/hive_database/hive_database.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final HiveDatabase hiveDatabase;

  AuthBloc({required this.hiveDatabase}) : super(AuthInitial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoginUser>(_onLoginUser);
    on<LogoutUser>(_onLogoutUser);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await hiveDatabase.addUser(event.user);
      await hiveDatabase.setCurrentUser(event.user.id);
      await hiveDatabase.setUserLoginStatus(true);
      emit(AuthSuccess(event.user));
    } catch (e) {
      emit(AuthFailure("Registration failed"));
    }
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      var users = await hiveDatabase.getAllUsers();
      UserModel? user;
      for (var u in users) {
        if (u.email == event.email && u.password == event.password) {
          user = u;
          break;
        }
      }
      if (user != null) {
        await hiveDatabase.setCurrentUser(user.id);
        await hiveDatabase.setUserLoginStatus(true);
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Login failed"));
      }
    } catch (e) {
      emit(AuthFailure("Login failed"));
    }
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await hiveDatabase.logoutUser();
      await hiveDatabase.setUserLoginStatus(false);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure("Logout failed"));
    }
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await hiveDatabase.getCurrentUser();
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure("Failed to check authentication status"));
    }
  }
}
