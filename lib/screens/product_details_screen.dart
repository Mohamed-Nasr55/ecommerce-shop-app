import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/features/theme/app_colors.dart';
import 'package:mysmallshop/widgets/custom_elevated_button.dart';
import 'package:mysmallshop/core/product/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  final String heroTag;
  final void Function(Product) onAddToCart;
  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.heroTag,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
   
    final image =
        (product.images.isNotEmpty && product.images[0].isNotEmpty)
            ? product.images[0]
            : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image, size: 40)),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          const Gap(15),
          Text(
            product.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.tealPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(10),
          Text(product.description, style: const TextStyle(fontSize: 16)),
          const Gap(100),

          CustomElevatedButton(
            text: "Add To Cart",
            height: 50,
            onPressed: () {
              onAddToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.title} added to cart'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
