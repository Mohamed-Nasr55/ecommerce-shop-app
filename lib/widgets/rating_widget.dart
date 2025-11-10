import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, this.rating = 4.5});
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber[600], size: 20),
        Icon(Icons.star, color: Colors.amber[600], size: 20),
        Icon(Icons.star, color: Colors.amber[600], size: 20),
        Icon(Icons.star, color: Colors.amber[600], size: 20),
        Icon(Icons.star_half, color: Colors.amber[600], size: 20),
        const Gap(8),
        Text(
          "$rating (120 reviews)",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
