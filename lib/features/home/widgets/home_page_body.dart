import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/core/product/product_model.dart';
import 'package:mysmallshop/features/home/widgets/products_grid_builder.dart';
import 'package:mysmallshop/features/home/widgets/promo_banner.dart';
import 'package:mysmallshop/features/home/widgets/search_bar_widget.dart';


class HomePageBody extends StatelessWidget {
  final List<Product> products;
  final TextEditingController searchController;
  final void Function(String) onSearchChanged;
  final void Function(Product) onAddToCart;

  const HomePageBody({
    super.key,
    required this.products,
    required this.searchController,
    required this.onSearchChanged,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Gap(10),
          SearchBarWidget(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 10),
          const PromoBannerWidget(),
          const SizedBox(height: 10),
          const Text(
            "Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          ProductsGridBuilder(
            products: products,
            onAddToCart: (product) {
              onAddToCart(product);
            },
          ),
        ],
      ),
    );
  }
}


