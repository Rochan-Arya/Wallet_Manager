import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_manager/screens/main_screen.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController upiController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  InputDecoration fieldDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,

      prefixIcon: Icon(icon),

      filled: true,

      fillColor: Theme.of(context).cardColor,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,

          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.transparent,

        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },

            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 20),

              Text(
                "Create Account",

                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Sign up to continue",

                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 35),

              TextField(
                controller: nameController,

                decoration: fieldDecoration(
                  label: "Full Name",

                  icon: Icons.person_outline,
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: emailController,

                decoration: fieldDecoration(
                  label: "Email",

                  icon: Icons.email_outlined,
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: mobileController,

                decoration: fieldDecoration(
                  label: "Mobile Number",

                  icon: Icons.phone_outlined,
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: upiController,

                decoration: fieldDecoration(
                  label: "UPI ID",

                  icon: Icons.account_balance,
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,

                obscureText: true,

                decoration: fieldDecoration(
                  label: "Password",

                  icon: Icons.lock_outline,
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: confirmPasswordController,

                obscureText: true,

                decoration: fieldDecoration(
                  label: "Confirm Password",

                  icon: Icons.lock_reset_outlined,
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,

                height: 55,

                child: ElevatedButton(
                  onPressed: () async {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );

                      return;
                    }

                    bool success =
                        await Provider.of<AppAuthProvider>(
                          context,

                          listen: false,
                        ).signUp(
                          name: nameController.text.trim(),

                          email: emailController.text.trim(),

                          mobile: mobileController.text.trim(),

                          upiId: upiController.text.trim(),

                          password: passwordController.text.trim(),
                        );

                    if (success) {
                      Navigator.pushReplacement(
                        context,

                        MaterialPageRoute(builder: (_) => const MainScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Signup Failed")),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: const Text(
                    "Sign Up",

                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
