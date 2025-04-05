import 'package:flutter/material.dart';
import 'package:flutter_application_lab03/routes/app_routes.dart';
import 'package:flutter_application_lab03/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Screen!'),
            const SizedBox(
              height: 20,
            ), // Espacio entre el texto y el primer botón
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.screenOne);
              },
              child: const Text('Go to Screen 1'),
            ),
            const SizedBox(height: 10), // Espacio entre los botones
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.screenTwo);
              },
              child: const Text('Go to Screen 2'),
            ),
          ],
        ),
      ),
    );
  }
}
