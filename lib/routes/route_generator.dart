// lib/routes/route_generator.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_lab03/routes/app_routes.dart';
import 'package:flutter_application_lab03/screens/home_screen.dart';
import 'package:flutter_application_lab03/screens/screen_one.dart';
import 'package:flutter_application_lab03/screens/screen_two.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.screenOne:
        return MaterialPageRoute(builder: (_) => const ScreenOne());
      case AppRoutes.screenTwo:
        return MaterialPageRoute(builder: (_) => const ScreenTwo());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Página no encontrada')),
        );
      },
    );
  }
}
