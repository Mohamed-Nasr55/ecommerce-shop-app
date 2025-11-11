import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/cart/cart_home_icon.dart';
import 'package:mysmallshop/cart/cart_model.dart';
import 'package:mysmallshop/cart/cart_screen.dart';
import 'package:mysmallshop/home/widgets/categories_list.dart';
import 'package:mysmallshop/home/widgets/products_grid_builder.dart';
import 'package:mysmallshop/home/widgets/promo_banner.dart';
import 'package:mysmallshop/home/widgets/search_bar_widget.dart';
import 'package:mysmallshop/screens/profile_screen.dart';
import 'package:mysmallshop/theme/app_colors.dart';
import 'package:mysmallshop/theme/theme.dart';
import 'package:mysmallshop/widgets/bottom_nav_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchName = '';

  @override
  Widget build(BuildContext context) {
    final products =
        List.generate(
          6,
          (index) => {
            'image': 'assets/images/image.png',
            'title': 'Product $index',
            'price': '\$${(index + 1) * 15}.00',
            'description': 'This is a detailed description of Product $index.',
            'rating': '4.5',
          },
        ).where((product) {
          if (_searchName.isEmpty) return true;
          return product['title']!.toLowerCase().contains(
            _searchName.toLowerCase(),
          );
        }).toList();

    final pages = [
      _buildHomePage(products),
      const Center(child: Text('Categories Page')),
      const Center(child: CartScreen()),
      const Center(child: ProfileScreen()),
    ];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Shop App',
            style: TextStyle(
              color: AppColors.tealButtonLight,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppThemes.tealLight.primaryColor,
          actions: [CartHomeIcon()],
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavBarWidget(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }

  Widget _buildHomePage(List<Map<String, String>> products) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoriesList(),
          const Gap(10),
          SearchBarWidget(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchName = value),
          ),
          const Gap(10),
          const Text(
            "Discover Our Best Deals",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          const PromoBannerWidget(),
          const Gap(10),
          const Text(
            "Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Gap(15),
          ProductsGridBuilder(
            products: products,
            onAddToCart: (product) {
              CartModel().addItem({
                'image': product['image'],
                'title': product['title'],
                'price': double.parse(product['price']!.replaceAll('\$', '')),
                'quantity': 1,
              });
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
