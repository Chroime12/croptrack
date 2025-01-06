import 'package:croptrack/features/auth/screens/login_screen.dart';
import 'package:croptrack/features/auth/screens/register_screen.dart';
import 'package:croptrack/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const HomeScreen(),
      '/login': (context) => const LoginScreen(),
      '/register': (context) => const RegisterScreen(),
    };
  }
}
