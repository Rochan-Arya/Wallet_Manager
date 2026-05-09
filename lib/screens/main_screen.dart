import 'package:flutter/material.dart';
import 'package:wallet_manager/screens/user/profile_screen.dart';

import 'user/dashboard_screen.dart';
import 'user/transaction_request_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const DashboardScreen(),

    const TransactionRequestScreen(),

    const ProfileScreen(),
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
                    Icons.home,

                    color: selectedIndex == 0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Home",

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
                    "Transactions",

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
                    Icons.person,

                    color: selectedIndex == 2
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Profile",

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
          ],
        ),
      ),
    );
  }
}
