import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mysmallshop/theme/theme.dart';

class AppCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final double rating;
  final VoidCallback onAdd;

  const AppCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.rating = 0.0,
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
          Gap(8),

          Expanded(
            child: Center(
              child: Image.asset(
                image,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Gap(8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                Text(price, style: const TextStyle(color: Colors.grey)),
                Gap(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Row(
                    children: List.generate(5, (index) {
                      if (rating >= index + 1) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        );
                      } else if (rating > index && rating < index + 1) {
                        return const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                          size: 16,
                        );
                      } else {
                        return const Icon(
                          Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }
                    }),
                  ),
                ),
                Gap(8),

                ElevatedButton(
                  onPressed: onAdd,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppThemes.tealDark.primaryColor,
                  ),
                  child: const Text('Add to Cart'),
                ),
                Gap(8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
