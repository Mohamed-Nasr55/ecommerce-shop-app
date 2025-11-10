import 'package:flutter/material.dart';
import 'package:mysmallshop/screens/product_details_screen.dart';
import 'package:mysmallshop/home/widgets/app_card_widget.dart';

class PopularProductsGrid extends StatelessWidget {
  final List<Map<String, String>> products;

  const PopularProductsGrid({
    super.key,
    required this.products,
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
                builder: (_) => ProductDetailsScreen(
                  image: product['image']!,
                  title: product['title']!,
                  price: product['price']!,
                  description:
                      'This is a detailed description of ${product['title']!}. It has amazing features and great quality for your needs.',
                  rating: 4.5,
                ),
              ),
            );
          },
          child: AppCardWidget(
            image: product['image']!,
            title: product['title']!,
            price: product['price']!,
            onAdd: () {},
          ),
        );
      },
    );
  }
}
