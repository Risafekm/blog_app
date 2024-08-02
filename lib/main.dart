// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:blog_app/core/models/postmodel/post_model.dart';
import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:blog_app/hive_database/hive_admin.dart';
import 'package:blog_app/hive_database/hive_database.dart';
import 'package:blog_app/presentation/admin_pages/admin_auth/bloc/admin_bloc.dart';
import 'package:blog_app/presentation/admin_pages/admin_home/admin_homescreen.dart';
import 'package:blog_app/presentation/login.dart';
import 'package:blog_app/presentation/splash_screen/splash_screen.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:blog_app/presentation/user_pages/home_screen/home_screen.dart';
import 'package:blog_app/presentation/user_pages/home_screen/bloc_post/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(PostModelAdapter());
    await Hive.openBox<PostModel>('posts');
    await Hive.openBox('userLoginBox');
    await Hive.openBox('adminLoginBox');
    await Hive.openBox<UserModel>('userBox');

    await AdminAuthBox.init();
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Hive: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(hiveDatabase: HiveDatabase()),
        ),
        BlocProvider(
          create: (context) => PostBloc(),
        ),
        BlocProvider(
          create: (context) => AdminBloc(hiveDatabase: AdminAuthBox()),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class UserLoginStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginStatus>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final loginStatus = snapshot.data!;
          if (loginStatus.isUserLoggedIn) {
            return BlocProvider(
              create: (context) => AuthBloc(hiveDatabase: HiveDatabase())
                ..add(CheckAuthStatus()),
              child: HomeScreen(user: loginStatus.user!),
            );
          } else if (loginStatus.isAdminLoggedIn) {
            return BlocProvider(
              create: (context) => AdminBloc(hiveDatabase: AdminAuthBox())
                ..add(CheckAdminAuthStatus()),
              child: const AdminHomeScreen(),
            );
          } else {
            return LoginScreen();
          }
        } else {
          return LoginScreen();
        }
      },
    );
  }

  Future<LoginStatus> _checkLoginStatus() async {
    final userLoginBox = Hive.box('userLoginBox');
    final adminLoginBox = Hive.box('adminLoginBox');

    bool isUserLoggedIn =
        userLoginBox.get('isUserLoggedIn', defaultValue: false);
    bool isAdminLoggedIn =
        adminLoginBox.get('isAdminLoggedIn', defaultValue: false);

    UserModel? user;
    if (isUserLoggedIn) {
      user = await HiveDatabase().getCurrentUser();
    }

    return LoginStatus(
      isUserLoggedIn: isUserLoggedIn,
      isAdminLoggedIn: isAdminLoggedIn,
      user: user,
    );
  }
}

class LoginStatus {
  final bool isUserLoggedIn;
  final bool isAdminLoggedIn;
  final UserModel? user;

  LoginStatus({
    required this.isUserLoggedIn,
    required this.isAdminLoggedIn,
    this.user,
  });
}
