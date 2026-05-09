import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';

import '../splash/splashscreen.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AppAuthProvider>(context);

    final themeProvider = Provider.of<ThemeProvider>(context);

    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 20),

              CircleAvatar(
                radius: 45,

                backgroundColor: Colors.orange,

                child: Text(
                  user != null && user.name.isNotEmpty
                      ? user.name.substring(0, 1).toUpperCase()
                      : "A",

                  style: const TextStyle(
                    color: Colors.black,

                    fontSize: 30,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                user?.name ?? "Admin",

                style: const TextStyle(
                  fontSize: 26,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                user?.email ?? "No Email",

                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 35),

              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,

                  borderRadius: BorderRadius.circular(25),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),

                      blurRadius: 10,

                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.admin_panel_settings),

                      title: const Text("Role"),

                      subtitle: Text(user?.role ?? "admin"),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.email),

                      title: const Text("Admin Email"),

                      subtitle: Text(user?.email ?? "No Email"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SwitchListTile(
                value: themeProvider.isDarkMode,

                onChanged: (value) {
                  themeProvider.toggleTheme();
                },

                title: const Text("Dark Mode"),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () async {
                    await authProvider.logout();

                    Navigator.pushReplacement(
                      context,

                      MaterialPageRoute(builder: (_) => const SplashScreen()),
                    );
                  },

                  child: const Text("Logout"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
