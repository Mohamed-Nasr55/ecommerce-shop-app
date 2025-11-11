import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/cart/cart_model.dart';
import 'package:mysmallshop/home/widgets/products_grid_builder.dart';
import 'package:mysmallshop/theme/app_colors.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Map<String, dynamic>> _categories = [
    {'id': 1, 'name': 'Electronics', 'icon': Icons.devices_other},
    {'id': 2, 'name': 'Fashion', 'icon': Icons.checkroom},
    {'id': 3, 'name': 'Home & Kitchen', 'icon': Icons.kitchen},
    {'id': 4, 'name': 'Beauty', 'icon': Icons.spa},
    {'id': 5, 'name': 'Sports', 'icon': Icons.sports_soccer},
    {'id': 6, 'name': 'Toys', 'icon': Icons.toys},
  ];

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final products = List.generate(
      8,
      (index) => {
        'image': 'assets/images/image.png',
        'title': '${_selectedCategory ?? "Product"} $index',
        'price': '\$${(index + 1) * 10}.00',
        'description': 'High-quality ${_selectedCategory ?? "Product"} item',
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select a Category",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['name'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.tealButtonLight.withOpacity(0.2)
                                : Colors.white,
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.tealButtonLight
                                  : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'],
                            size: 32,
                            color: AppColors.tealButtonLight,
                          ),
                          const Gap(6),
                          Text(
                            category['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Gap(20),
              if (_selectedCategory != null) ...[
                Text(
                  "Products in $_selectedCategory",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(10),
                ProductsGridBuilder(
                  products: products,
                  onAddToCart: (product) {
                    CartModel().addItem({
                      'image': product['image'],
                      'title': product['title'],
                      'price': double.parse(
                        product['price']!.replaceAll('\$', ''),
                      ),
                      'quantity': 1,
                    });

                    CartModel().cartCountNotifier.value =
                        CartModel().cartCountNotifier.value + 1;
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
