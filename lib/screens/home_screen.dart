import 'package:flutter/material.dart';
import 'package:mysmallshop/widgets/app_card_widget.dart';
import 'package:mysmallshop/theme/app_colors.dart';
import 'package:mysmallshop/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShopApp',
          style: TextStyle(
            color: AppColors.tealButtonDark,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppThemes.tealLight.primaryColor,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  color: AppColors.tealButtonLight,
                  size: 30,
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: 9,
                  backgroundColor: Colors.red,
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
          children: List.generate(
            6,
            (index) => ProductCard(
              image: 'assets/images/beefnoodel.png',
              title: 'T-Shirt',
              price: '\$99.99',
              onAdd: () {},
            ),
          ),
        ),
      ),
    );
  }
}
