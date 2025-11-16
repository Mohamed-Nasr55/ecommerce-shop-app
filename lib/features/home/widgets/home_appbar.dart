

import 'package:flutter/material.dart';
import 'package:mysmallshop/features/home/widgets/cart_home_icon.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/logo.png"),
      ),
      title: const Text(
        'Shop App',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: const [CartHomeIcon()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

