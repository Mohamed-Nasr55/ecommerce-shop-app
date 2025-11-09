// import 'package:flutter/material.dart';
// import 'package:mysmallshop/widgets/app_card_widget.dart';
// import 'package:mysmallshop/theme/app_colors.dart';
// import 'package:mysmallshop/theme/theme.dart';
// import 'package:mysmallshop/widgets/bottom_nav_bar_widget.dart';
// import 'package:mysmallshop/widgets/categories_list.dart';
// import 'package:mysmallshop/widgets/promo_banner.dart';
// import 'package:mysmallshop/widgets/search_bar_widget.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchName = '';

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     final products =
//         List.generate(
//           6,
//           (index) => {
//             'image': 'assets/images/image.png',
//             'title': 'Product $index',
//             'price': '\$ ${(index + 1) * 15}.00',
//           },
//         ).where((product) {
//           if (_searchName.isEmpty) return true;
//           return product['title']!.toLowerCase().contains(
//             _searchName.toLowerCase(),
//           );
//         }).toList();

//     final pages = [
//       _buildHomePage(products),
//       const Center(child: Text(' Categories Page')),
//       const Center(child: Text(' Favorites Page')),
//       const Center(child: Text(' Profile Page')),
//     ];

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),

//       child: Scaffold(
//         appBar: AppBar(
//           leading: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Image.asset("assets/images/logo.png"),
//           ),
//           title: const Text(
//             'Shop App',
//             style: TextStyle(
//               color: AppColors.tealButtonLight,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           backgroundColor: AppThemes.tealLight.primaryColor,
//         ),

//         body: pages[_currentIndex],

//         bottomNavigationBar: BottomNavBarWidget(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() => _currentIndex = index);
//           },
//         ),
//       ),
//     );
//   }

//  Widget _buildHomePage(List<Map<String, String>> products) {
//   return SingleChildScrollView(
//     padding: const EdgeInsets.all(12.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const PromoBannerWidget(),
//         const SizedBox(height: 10),
//         const CategoriesList(),
//         const SizedBox(height: 10),
//         SearchBarWidget(
//           controller: _searchController,
//           onChanged: (value) => setState(() => _searchName = value),
//         ),
//         const SizedBox(height: 16),
//         GridView.builder(
//           itemCount: products.length,
//           shrinkWrap: true, // 👈 makes GridView fit inside scroll
//           physics: const NeverScrollableScrollPhysics(), // 👈 prevents double scroll
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             childAspectRatio: 0.7,
//           ),
//           itemBuilder: (context, index) {
//             final product = products[index];
//             return AppCardWidget(
//               image: "assets/images/logo.png",
//               title: product['title']!,
//               price: product['price']!,
//               onAdd: () {},
//             );
//           },
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/theme/app_colors.dart';
import 'package:mysmallshop/theme/theme.dart';
import 'package:mysmallshop/widgets/app_card_widget.dart';
import 'package:mysmallshop/widgets/bottom_nav_bar_widget.dart';
import 'package:mysmallshop/widgets/categories_list.dart';
import 'package:mysmallshop/widgets/promo_banner.dart';
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
            'image': 'assets/images/image.png',
            'title': 'Product $index',
            'price': '\$ ${(index + 1) * 15}.00',
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
      const Center(child: Text('Favorites Page')),
      const Center(child: Text('Profile Page')),
    ];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset("assets/images/logo.png"),
          ),
          title: const Text(
            'Shop App',
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
          Gap(10),
          SearchBarWidget(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchName = value),
          ),
          Gap(10),
          const Text(
            "Discover Our Best Deals ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Gap(10),

          const PromoBannerWidget(),
          Gap(10),

          const Text(
            "Popular Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          GridView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
        ],
      ),
    );
  }
}
