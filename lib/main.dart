import 'package:flutter/material.dart';
import 'package:mysmallshop/theme/theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopApp',
       theme: AppThemes.tealLight, // choose light theme
      darkTheme: AppThemes.tealDark, // corresponding dark theme
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
