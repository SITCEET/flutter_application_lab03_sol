import 'package:flutter/material.dart';
import 'package:flutter_application_lab03/routes/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              Navigator.pushNamed(context, AppRoutes.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pantalla 1'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              Navigator.pushNamed(context, AppRoutes.screenOne);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pantalla 2'),
            onTap: () {
              Navigator.pop(context); // Cierra el drawer
              Navigator.pushNamed(context, AppRoutes.screenTwo);
            },
          ),
        ],
      ),
    );
  }
}
