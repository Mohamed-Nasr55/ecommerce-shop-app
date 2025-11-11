import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/home/screens/home_screen.dart';
import 'package:mysmallshop/theme/app_colors.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';
import 'register_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/images/logo.png"),
                ),
                Gap(20),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sign in to continue to ShopApp',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),

                CustomElevatedButton(
                  text: 'Sign In',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  height: 50,
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: AppColors.tealPrimary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
