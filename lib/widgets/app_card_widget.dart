import 'package:flutter/material.dart';
import 'package:mysmallshop/theme/theme.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Product title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          // Product price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(price, style: const TextStyle(color: Colors.grey)),
          ),
          // Add to cart button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onAdd,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppThemes.tealLight.primaryColor,
              ),
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
