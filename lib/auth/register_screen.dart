import 'package:flutter/material.dart';
import 'package:mysmallshop/auth/sign_in_screen.dart';
import 'package:mysmallshop/screens/home_screen.dart';
import 'package:mysmallshop/theme/app_colors.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';
import 'package:mysmallshop/widgets/custom_textfeild.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                const Text(
                  'Let`s Create New Account For You ',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Full Name',
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 16),

                CustomTextField(labelText: 'Email', prefixIcon: Icons.email),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 40),

                CustomElevatedButton(
                  text: 'Register',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignInScreen()),
                    );
                  },
                  child: const Text(
                    'Already have an account? Sign In',
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
