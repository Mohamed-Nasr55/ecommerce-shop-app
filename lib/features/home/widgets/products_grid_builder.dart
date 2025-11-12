import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/screens/product_details_screen.dart';
import 'package:mysmallshop/features/theme/app_colors.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';

class ProductsGridBuilder extends StatelessWidget {
  final List<Map<String, String>> products;
  final void Function(Map<String, String>) onAddToCart;

  const ProductsGridBuilder({
    super.key,
    required this.products,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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

        final image = product['image'] ?? '';
        final title = product['title'] ?? '';
        final price = product['price'] ?? '';
        final description = product['description'] ?? '';
        final rating = double.tryParse(product['rating'] ?? '0') ?? 0;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(
                  image: image,
                  title: title,
                  price: price,
                  description: description,
                  rating: rating,
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Hero(
                    tag: title,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Gap(6),
                      Text(
                        price,
                        style: const TextStyle(color: AppColors.tealPrimary),
                      ),
                      const Gap(5),
                      CustomElevatedButton(
                        text: "Add To Cart",
                        onPressed: () => onAddToCart(product),
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
