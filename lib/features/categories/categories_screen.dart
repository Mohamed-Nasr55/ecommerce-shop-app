import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysmallshop/features/cart/cart_cubit.dart';
import 'package:mysmallshop/features/cart/cart_item.dart';
import 'package:mysmallshop/features/cart/cart_state.dart';
import 'package:mysmallshop/features/categories/category_item_widget.dart';
import 'package:mysmallshop/features/home/widgets/products_grid_builder.dart';

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
              const Gap(40),
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
                  return CategoryItemWidget(
                    name: category['name'],
                    icon: category['icon'],
                    isSelected: _selectedCategory == category['name'],
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['name'];
                      });
                    },
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${product['title']} added to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
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
