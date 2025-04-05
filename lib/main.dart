import 'package:flutter/material.dart';
import 'package:flutter_application_lab03/routes/app_routes.dart';
import 'package:flutter_application_lab03/routes/route_generator.dart';
import 'package:flutter_application_lab03/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
