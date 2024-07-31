// ignore_for_file: use_build_context_synchronously

import 'package:blog_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> navigateScreen(BuildContext context) async {
    await Future.delayed(
        const Duration(seconds: 2)); // Wait for the splash duration

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserLoginStatus()),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateScreen(context);
    });

    return Scaffold(
        body: const Center(
                child: Text(
      'Welcome',
      style: TextStyle(
          fontSize: 32, color: Colors.blue, fontWeight: FontWeight.bold),
    ))
            .animate()
            .scale(
                duration: const Duration(milliseconds: 700),
                curve: Curves.bounceIn)
            .fade()
            .shimmer(duration: const Duration(milliseconds: 700)));
  }
}
