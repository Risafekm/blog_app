// ignore_for_file: avoid_print, unused_local_variable

import 'package:blog_app/models/postmodel/post_model.dart';
import 'package:blog_app/models/usermodel/user_model.dart';
import 'package:blog_app/user_pages/authentication/login_screen.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(PostModelAdapter());

    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Hive: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginUserScreen(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
