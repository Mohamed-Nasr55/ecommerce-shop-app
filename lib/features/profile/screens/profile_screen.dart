import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/features/auth/sign_in_screen.dart';
import 'package:mysmallshop/features/profile/screens/payment_method_screen.dart';
import 'package:mysmallshop/features/profile/widgets/profile_header.dart';
import 'package:mysmallshop/features/profile/widgets/profile_options.dart';
import 'package:mysmallshop/features/profile/screens/shipping_address_screen.dart';
import 'package:mysmallshop/features/theme/app_colors.dart';
import 'package:mysmallshop/features/theme/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileHeader(name: "Mohamed Nasr", email: "mohamed@example.com"),

            const Gap(20),

            BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, theme) {
                final isDark = theme.brightness == Brightness.dark;
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.dark_mode_outlined, color: Colors.teal),
                          Gap(10),
                          Text(
                            "Dark Mode",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: isDark,
                        activeColor: AppColors.tealButtonLight,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme(value);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            const Gap(25),

            // Profile options
            ProfileOption(
              icon: Icons.location_on_outlined,
              title: "Shipping Address",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ShippingAddressScreen(),
                  ),
                );
              },
            ),

            ProfileOption(
              icon: Icons.payment_outlined,
              title: "Payment Methods",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PaymentMethodScreen()),
                );
              },
            ),

            const Gap(150),

            ProfileOption(
              icon: Icons.logout,
              title: "Logout",
              color: Colors.redAccent,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => SignInScreen()),
                );
              },
            ),

            const Gap(20),
          ],
        ),
      ),
    );
  }
}
