import 'package:flutter/material.dart';

import 'admin_dashboard_screen.dart';
import 'admin_requests_screen.dart';
import 'admin_users_screen.dart';
import 'admin_profile_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const AdminDashboardScreen(),

    const AdminRequestsScreen(),

    const AdminUsersScreen(),

    const AdminProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: screens[selectedIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),

        padding: const EdgeInsets.symmetric(vertical: 10),

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

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Icon(
                    Icons.dashboard,

                    color: selectedIndex == 0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Dashboard",

                    style: TextStyle(
                      color: selectedIndex == 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Icon(
                    Icons.receipt_long,

                    color: selectedIndex == 1
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Requests",

                    style: TextStyle(
                      color: selectedIndex == 1
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
              },

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Icon(
                    Icons.people,

                    color: selectedIndex == 2
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Users",

                    style: TextStyle(
                      color: selectedIndex == 2
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
              },

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Icon(
                    Icons.person,

                    color: selectedIndex == 3
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Profile",

                    style: TextStyle(
                      color: selectedIndex == 3
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
