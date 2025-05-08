// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const HomePage(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => const RegisterPage(),
    ),
  ];

  static void navigateToLogin() => Get.toNamed('/login');
  static void navigateToRegister() => Get.toNamed('/register');
  static void navigateToHome() => Get.offAllNamed('/');
}
