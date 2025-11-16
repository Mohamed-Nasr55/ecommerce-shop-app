import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysmallshop/core/product/product_cubit.dart';
import 'package:mysmallshop/core/product/product_state.dart';
import 'package:mysmallshop/core/category/category_model.dart';
import 'package:mysmallshop/features/home/widgets/products_grid_builder.dart';
import 'package:mysmallshop/features/cart/cart_cubit.dart';
import 'package:mysmallshop/features/cart/cart_item.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Category> categories;

  const CategoriesScreen({super.key, required this.categories});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _selectedCategory = 'All';

  void _onCategorySelected(String categoryName) {
    setState(() {
      _selectedCategory = categoryName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductLoaded) {
            final filteredProducts =
                _selectedCategory == 'All'
                    ? state.products
                    : state.products
                        .where(
                          (p) =>
                              p.categoryId ==
                              widget.categories
                                  .firstWhere(
                                    (c) => c.name == _selectedCategory,
                                  )
                                  .id,
                        )
                        .toList();

            if (filteredProducts.isEmpty) {
              return const Center(child: Text('No products found'));
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        itemCount: widget.categories.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final categoryName =
                              index == 0
                                  ? 'All'
                                  : widget.categories[index - 1].name;
                          final isSelected = categoryName == _selectedCategory;

                          return GestureDetector(
                            onTap: () => _onCategorySelected(categoryName),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.teal
                                        : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                categoryName,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ProductsGridBuilder(
                        products: filteredProducts,
                        onAddToCart: (product) {
                          context.read<CartCubit>().addItem(
                            CartItem(
                              title: product.title,
                              image:
                                  product.images.isNotEmpty
                                      ? product.images.first
                                      : "https://placehold.co/640x480",
                              price: product.price,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
