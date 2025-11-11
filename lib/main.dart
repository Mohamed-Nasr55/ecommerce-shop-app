import 'package:flutter/material.dart';
import 'package:mysmallshop/cart/cart_helper.dart';
import 'package:mysmallshop/theme/theme.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartHelper(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopApp',
      theme: AppThemes.tealLight,
      darkTheme: AppThemes.tealDark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
