import 'package:bloc/bloc.dart';
import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:blog_app/hive_database/hive_database.dart';
import 'package:hive/hive.dart';
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
      var box = await Hive.openBox<UserModel>('userBox');
      final List<UserModel> userList = box.values.toList();
      final user = userList.firstWhere(
        (user) => user.email == event.email && user.password == event.password,
        orElse: () => UserModel(
          email: '',
          id: '',
          isBanned: false,
          password: '',
          username: '',
        ),
      );

      if (user.id.isEmpty) {
        emit(AuthFailure('Invalid email or password.'));
      } else if (user.isBanned) {
        emit(UserBanned());
      } else {
        emit(AuthSuccess(user));
      }
    } catch (e) {
      emit(AuthFailure('An error occurred during login.'));
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
