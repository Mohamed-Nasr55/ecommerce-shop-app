import 'package:flutter/material.dart';
import 'package:mysmallshop/widgets/app_card_widget.dart';
import 'package:mysmallshop/theme/app_colors.dart';
import 'package:mysmallshop/theme/theme.dart';
import 'package:mysmallshop/widgets/bottom_nav_bar_widget.dart';
import 'package:mysmallshop/widgets/search_bar_widget.dart';

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
    final theme = Theme.of(context);

    final products =
        List.generate(
          6,
          (index) => {
            'image': 'assets/images/beefnoodel.png',
            'title': 'Product $index',
            'price': '\$${(index + 1) * 15}.00',
          },
        ).where((product) {
          if (_searchName.isEmpty) return true;
          return product['title']!.toLowerCase().contains(
            _searchName.toLowerCase(),
          );
        }).toList();

    final pages = [
      _buildHomePage(products),
      const Center(child: Text(' Categories Page')),
      const Center(child: Text(' Favorites Page')),
      const Center(child: Text(' Profile Page')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShopApp',
          style: TextStyle(
            color: AppColors.tealButtonLight,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppThemes.tealLight.primaryColor,
      ),

      body: pages[_currentIndex],

      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  Widget _buildHomePage(List<Map<String, String>> products) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchName = value),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return AppCardWidget(
                  image: product['image']!,
                  title: product['title']!,
                  price: product['price']!,
                  onAdd: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
