import 'package:bloc/bloc.dart';
import 'package:blog_app/hive_database/hive_admin.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminAuthBox hiveDatabase;

  AdminBloc({required this.hiveDatabase}) : super(AdminInitial()) {
    on<AdminLoginRequested>(_onAdminLoginRequested);
    on<CheckAdminAuthStatus>(_onCheckAdminAuthStatus);
    on<AdminLogoutRequested>(_onAdminLogoutRequested);
  }

  Future<void> _onAdminLoginRequested(
      AdminLoginRequested event, Emitter<AdminState> emit) async {
    emit(AdminLoginInProgress());
    try {
      if (event.email == 'admin123@gmail.com' && event.password == 'admin') {
        await AdminAuthBox.saveAuthStatus(true, isAdmin: true);
        emit(AdminLoginSuccess());
      } else {
        emit(AdminLoginFailure(error: 'Invalid email or password'));
      }
    } catch (e) {
      emit(AdminLoginFailure(error: e.toString()));
    }
  }

  Future<void> _onCheckAdminAuthStatus(
      CheckAdminAuthStatus event, Emitter<AdminState> emit) async {
    emit(AdminLoginInProgress());
    try {
      final isAuthenticated = await AdminAuthBox.getAuthStatus();
      if (isAuthenticated) {
        emit(AdminLoginSuccess());
      } else {
        emit(AdminInitial());
      }
    } catch (e) {
      emit(AdminLoginFailure(error: e.toString()));
    }
  }

  Future<void> _onAdminLogoutRequested(
      AdminLogoutRequested event, Emitter<AdminState> emit) async {
    emit(AdminLoginInProgress());
    try {
      await AdminAuthBox.saveAuthStatus(false, isAdmin: false);
      emit(AdminInitial());
    } catch (e) {
      emit(AdminLoginFailure(error: e.toString()));
    }
  }
}
