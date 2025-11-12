import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/features/cart/cart_cubit.dart';
import 'package:mysmallshop/features/cart/cart_item.dart';
import 'package:mysmallshop/features/cart/cart_screen.dart';
import 'package:mysmallshop/features/cart/cart_state.dart';
import 'package:mysmallshop/features/categories/categories_screen.dart';
import 'package:mysmallshop/features/home/widgets/categories_list.dart';
import 'package:mysmallshop/features/home/widgets/home_appbar.dart';
import 'package:mysmallshop/features/home/widgets/products_grid_builder.dart';
import 'package:mysmallshop/features/home/widgets/promo_banner.dart';
import 'package:mysmallshop/features/home/widgets/search_bar_widget.dart';
import 'package:mysmallshop/features/profile/screens/profile_screen.dart';
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
      const Center(child: CategoriesScreen()),
      const Center(child: CartScreen()),
      const Center(child: ProfileScreen()),
    ];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _currentIndex == 0 ? const HomeAppbar() : null,
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
          BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              return ProductsGridBuilder(
                products: products,
                onAddToCart: (product) {
                  context.read<CartCubit>().addItem(
                    CartItem(
                      title: product['title']!,
                      image: product['image']!,
                      price: double.parse(
                        product['price']!.replaceAll('\$', ''),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
