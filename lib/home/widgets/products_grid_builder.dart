import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/screens/product_details_screen.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';

class ProductsGridBuilder extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function(Map<String, String>) onAddToCart;

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

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => ProductDetailsScreen(
                      image: product['image']!,
                      title: product['title']!,
                      price: product['price']!,
                      description: product['description']!,
                      rating: double.tryParse(product['rating'] ?? '0') ?? 0,
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
                    tag: product['title']!,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        product['image']!,
                        fit: BoxFit.cover,
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
                        product['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Gap(6),
                      Text(
                        product['price']!,
                        style: const TextStyle(color: Colors.teal),
                      ),
                      const Gap(8),
                      SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          text: "Add To Cart",
                          onPressed: () => onAddToCart(product),
                        ),
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
