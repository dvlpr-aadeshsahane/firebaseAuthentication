import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  changeScreen() {
    Future.delayed(Duration(seconds: 2), () {
      if (AuthController().isLogin) {
        GoRouter.of(appContext).goNamed(Routes.homescreen.name);
      } else {
        GoRouter.of(appContext).goNamed(Routes.signin.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    changeScreen();
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
